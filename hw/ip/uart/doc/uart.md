{{% lowrisc-doc-hdr UART HWIP Technical Specification }}
{{% regfile uart.hjson}}

{{% section1 Overview }}

This document specifies UART hardware IP functionality. This module
conforms to the
[Comportable guideline for peripheral functionality.](../../../../doc/rm/comportability_specification.md)
See that document for integration overview within the broader
top level system.

{{% toc 3 }}

{{% section2 Features }}

- 2-pin full duplex external interface
- 8-bit data word, optional even or odd parity bit per byte
- 1 stop bit
- 32 x 8b RX buffer
- 32 x 8b TX buffer
- Programmable baud rate
- Interrupt for overflow, frame error, parity error, break error, receive
  timeout

{{% section2 Description }}

The UART module is a serial-to-parallel receive (RX) and parallel-to-serial
(TX) full duplex design intended to communicate to an outside device, typically
for basic terminal-style communication. It is programmed to run at a particular
baud rate and contains only a transmit and receive signal to the outside world,
i.e. no synchronizing clock. The programmable baud rate guarantees to be met up
to 1Mbps.

{{% section2 Compatibility }}

The UART is compatible with the feature set of H1 Secure Microcontroller UART as
used in the [Chrome OS cr50][chrome-os-cr50] codebase. Additional features such
as parity have been added.

[chrome-os-cr50]: https://chromium.googlesource.com/chromiumos/platform/ec/+/master/chip/g/

{{% section1 Theory of Operations }}

{{% section2 Block Diagram }}

![UART Block Diagram](block_diagram.svg)

{{% section2 Hardware Interfaces }}

{{% hwcfg uart}}

{{% section2 Design Details }}

### Serial interface (both directions)

TX/RX serial lines are high when idle. Data starts with START bit (1-->0)
followed by 8 data bits. Least significant bit is sent first. If parity feature
is turned on, at the end of the data bit, odd or even parity bit follows then
STOP bit completes one byte data transfer.

```wavejson
{
  signal: [
    { name: 'Baud Clock',     wave: 'p............'                                                        },
    { name: 'tx',             wave: '10333333331..', data: [ "lsb", "", "", "", "", "", "", "msb" ]        },
    { name: 'Baud Clock',     wave: 'p............'                                                        },
    { name: 'tx (w/ parity)', wave: '103333333341.', data: [ "lsb", "", "", "", "", "", "", "msb", "par" ] },
  ],
  head: {
    text: 'Serial Transmission Frame',
  },
  foot: {
    text: 'start bit ("0") at cycle -1, stop bit ("1") at cycle 8, or after parity bit',
    tock: -2
  },
  foot: {
    text: [
      'tspan',
        ['tspan', 'start bit '],
        ['tspan', {class:'info h4'}, '0'],
        ['tspan', ' at cycle -1, stop bit '],
        ['tspan', {class:'info h4'}, '1'],
        ['tspan', ' at cycle 8, or at cycle 9 after parity bit'],
      ],
    tock: -2,
  }
}
```

### Transmission

A write to !!WDATA enqueues a data byte into the 32 depth write
FIFO, which triggers the transmit module to start UART TX serial data
transfer. The TX module dequeues the byte from the FIFO and shifts it
bit by bit out to the UART TX pin when baud tick is asserted.

If TX is not enabled, written DATA into FIFO will be stacked up and sent out
when TX is enabled.

### Reception

The RX module oversamples the RX input pin at 16x the requested
baud clock. When the input is detected low the receiver will check
half a bit-time later (i.e. 8 cycles of the oversample clock) that the
line is still low before detecting the START bit. If the line has
returned high the glitch is ignored. After it detects the START bit,
the RX module samples at the center of each bit-time and gathers
incoming serial bits into a charcter buffer. If the STOP bit is
detected as high and the optional partity bit is correct the data byte
is pushed into a 32 byte deep RX FIFO. The data can be read out by
reading !!RDATA register. It is expected that the software reads all
the pending data from RX FIFO if RX needs to be disabled.

This behaviour of the receiver can be used to compute the approximate
baud clock frequency error that can be tolerated between the
transmitter at the other end of the cable and the receiver. The
initial sample point is aligned with the center of the START bit. The
receiver will then sample every 16 cycles of the 16 x baud clock, the
diagram below shows the number of ticks after the centering that each
bit is captured. Because of the frequency difference between the
transmiter and receiver the actual sample point will drift compared to
the ideal center of the bit. In order to correctly receive the STOP
bit it must be sampled between the "early" and "late" points shown
on the diagram, which are half a bit-time or 8 ticks of the 16x baud
clock before or after the center. If the transmitter is considered
"ideal" then the local clock must thus differ by no more than plus or
minus 8 ticks in 144 or aproximately +/- 5.5%. If parity is enabled
the stop bit will be a bit time later, so this becomes 8/160 or about
+/- 5%.

```wavejson
{
  signal: [
    { name: 'Sample', wave: '', node: '..P............', period: "2" },
    {},
    { name: 'rx',
      wave: '1.0.3.3.3.3.3.3.3.3.1.0.3',
      node: '...A................C.D..',
      cdata: [ "idle", "start", "+16", "+32", "+48", "+64", "+80",
                "+96", "+112", "+128", "+144", "next start" ] },
  ],
    "edge"   : ["P-|>A center", "P-|>C early", "P-|>D late"],
  head: {
    text: 'Receiver sampling window',
  },
}
```

In practice, the transmitter and receiver will both differ from the
ideal baud rate. Since the worst case difference for reception is 5%,
the uart can be expected to work if both sides are within +/- 2.5% of
the ideal baud rate.

### Setting the baud rate

The baud rate is set by programming the !!CTRL.NCO register
field. This should be set to `(2^20*baud)/freq`, where `freq` is the
system clock frequency provided to the UART.

$$ NCO = {{2^{20} * f_{baud}} \over {f_{pclk}}} $$

Note that the NCO result from the above formula can be a fraction but
the NCO register only accepts an integer value. This will create an
error if the baud rate is not divisible by the fixed clock frequency. As
discussed in the previous section the error rate between the receiver
and remote transmitter should be lower than `8 / 144` to latch a
correct character value when parity is not used and lower than `8 /
160` when parity is used. In the expectation that the device the other
side of the line behaves similarly, this requires each side have a
baud rate that is matched to within +/- 2.5% of the ideal baud
rate. The contribution to this error if NCO is rounded down to an
integer (which will make the actual baud rate always lower or equal to
the requested rate) can be computed from:

$$ Error = {{(NCO - INT(NCO))} \over {NCO}} percent $$

In this case if the resulting value of NCO is greater than $$ {1 \over
0.025} = 40 $$ then this will always be less than the 2.5% error
target.

For NCO less than 40 the error in baud rate may or may not be
acceptable and should be carefully checked and rounding to the nearest
integer may achieve better results. If the computed value is close to
an integer so that the error in the target range then the baud rate
can be supported, however if it is too far off an integer then the
baud rate cannot be supported. This check is needed when

$$ {{baud} < {{40 * f_{pclk}} \over {2^{20}}}} \qquad OR \qquad
{{f_{pclk}} > {{{2^{20}} * {baud}} \over {40}}} $$

Using rounded frequencies and common baud rates, this implies that
care is needed for 9600 baud and below if the system clock is under
250MHz, with 4800 baud and below if the system clock is under 125MHz,
2400 baud and below if the system clock us under 63MHz, and 1200 baud
and below if the system clock is under 32MHz.


### Interrupts

UART module has a few interrupts including general data flow interrupts
and unexpected event interrupts.

If the TX or RX FIFO hits (meaning greater than or equal to) the designated
depth of entries, interrupts `tx_watermark` or `rx_watermark` are raised to
inform FW.  FW can configure the watermark value via registers
!!FIFO_CTRL.RXILVL or !!FIFO_CTRL.TXILVL.

If either FIFO receives an additional write request when its FIFO is full,
the interrupt `tx_overflow` or `rx_overflow` is asserted and the character
is dropped.

The `rx_break_err` interrupt is triggered if a break condition has
been detected. A break condition is defined as the RX pin being
continuously low for more than a programmable number of
character-times (via !!CTRL.RXBLVL, either 2, 4, 8, or 16). A
character time is 10 bit-times if parity is disabled (START + 8 data +
STOP) or 11 bit-times if parity is enabled (START + 8 data + parity +
STOP). If the UART is connected to an external connector this would
typically indicate the cable has been disconnected (or there is a
break in the wire). If the UART is connected to another part on the
same board it would typically indicate the other part has reset or
rebooted. (If the open connector or resetting peer part causes the RX
input to not be actively driven, then a pulldown resistor is needed to
ensure a break and a pullup resistor will ensure the line looks idle
and no break is generated.)  Note that only one interrupt is generated
per break -- the line must return high for at least half a bit-time
before an additional break interrupt is generated. The current break
status can be read from the !!STATUS.BREAK bit. If STATUS.BREAK is set
but !!INTR_STATE.BREAK is clear then the line break has already caused
an interrupt that has been cleared but the line break is still going
on. If !!STATUS.BREAK is clear but !!INTR_STATE.BREAK is set then
there has been a line break for which software has not cleared the
interrupt but the line is now back to normal.

The `rx_frame_err` interrupt is triggered if RX module receives the
`START` bit and series of data bits but did not detect `STOP` bit
(`1`). This can happen because of noise affecting the line or if the
transmitter clock is fast or slow compared to the receiver. In a real
frame error the stop bit will be present just at an incorrect time so
the line will continue to signal both high and low. The start of a
line break (described above) matches a frame error with all data bits
zero and one frame error interrupt will be raised. If the line stays zero until
the break error occurs, the frame error will be set at every char-times.

```wavejson
{
  signal: [
    { name: 'Baud Clock',        wave: 'p............'                                                 },
    { name: 'rx',                wave: '10333333330..', data: [ "lsb", "", "", "", "", "", "", "msb" ] },
    {},
    { name: 'intr_rx_frame_err', wave: '0..........1.'},
  ],
  head: {
    text: 'Serial Receive with Framing Error',
  },
  foot: {
    text: [
      'tspan',
        ['tspan', 'start bit '],
        ['tspan', {class:'info h4'}, '0'],
        ['tspan', ' at cycle -1, stop bit '],
        ['tspan', {class:'error h4'}, '1'],
        ['tspan', ' missing at cycle 8'],
      ],
    tock: -2,
  }
}
```

The effects of the line being low for certain periods are summarized
in the table:

|Line low (bit-times) | Frame Err? | Break? | Comment |
|---------------------|------------|--------|---------|
|<10                  | If STOP=0  | No     | Normal operation |
|10 (with parity)     | No         | No     | Normal zero data with STOP=1 |
|10 (no parity)       | Yes        | No     | Frame error since STOP=0 |
|11 - RXBLVL*char     | Yes        | No     | Break less than detect level |
|\>RXBLVL*char        | Yes        | Once   | Frame signalled at every char-times, break at RXBLVL char-times|

The `rx_timeout` interrupt is triggered when the RX FIFO has data sitting
in it without software reading it for a programmable number of bit times
(with baud rate clock as reference, programmable via !!TIMEOUT_CTRL). This
is used to alert software that it has data still waiting in the FIFO that
has not been handled yet. The timeout counter is reset whenever the FIFO depth
is changed or `rx_timeout` event occurs. If FIFO is full and new character is
received, it won't reset the timeout value. The software is responsible to keep
the FIFO in the level below the watermark. The actual timeout time can vary
based on the reset of the timeout timer and the start of the transaction. For
instance, if the software reset the timeout timer by reading the character from
the FIFO and right next to it the baud tick asserted and start RX transaction
from the host, it can have shortest timeout value reduced by 1 and half baud
clock period.

The `rx_parity_err` interrupt is triggered if parity is enabled and
the RX parity bit does not match the expected polarity as programmed
in !!CTRL.PARITY_ODD.

{{% section1 Programmers Guide }}

{{% section2 Initialization }}

The following code snippet shows initializing the UART to a programmable
baud rate, clearing the RX and TX FIFO, setting up the FIFOs for interrupt
levels, and enabling some interrupts. The NCO register controls the baud
rate, and should be set to `(2^20*baud)/freq`, where `freq` is the fixed
clock frequency. The UART uses `clock_primary` as a clock source.

$$ NCO = {{2^{20} * f_{baud}} \over {f_{pclk}}} $$

Note that the NCO result from the above formula can be a fraction but
the NCO register only accepts an integer value. See the the
[Reception](#reception) and [Setting the baud
rate](#setting-the-baud-rate) sections for more discussion of the
baud rate error target and when care is needed.

Also note that because the baud rate is multiplied by 2^20 care is
needed not to overflow 32-bit registers. Baud rates can easily be more
than 12 bits. The code below is careful to force 64-bit
arithmetic. (Even if the complier is pre-computing constants there can
be unexpected overflow).

```cpp
#define CLK_FIXED_FREQ_HZ (50ULL * 1000 * 1000)

void uart_init(unsigned int baud) {
  // nco = 2^20 * baud / fclk
  uint64_t uart_ctrl_nco = ((uint64_t)baud << 20) / CLK_FIXED_FREQ_HZ;
  REG32(UART_CTRL(0)) =
      ((uart_ctrl_nco & UART_CTRL_NCO_MASK) << UART_CTRL_NCO_OFFSET) |
      (1 << UART_CTRL_TX) |
      (1 << UART_CTRL_RX);

  // clear FIFOs and set up to interrupt on any RX, half-full TX
  *UART_FIFO_CTRL_REG =
      UART_FIFO_CTRL_RXRST                 | // clear both FIFOs
      UART_FIFO_CTRL_TXRST                 |
      (UART_FIFO_CTRL_RXILVL_RXFULL_1 <<3) | // intr on RX 1 character
      (UART_FIFO_CTRL_TXILVL_TXFULL_16<<5) ; // intr on TX 16 character

  // enable only RX, overflow, and error interrupts
  *UART_INTR_ENABLE_REG =
      UART_INTR_ENABLE_RX_WATERMARK_MASK  |
      UART_INTR_ENABLE_TX_OVERFLOW_MASK   |
      UART_INTR_ENABLE_RX_OVERFLOW_MASK   |
      UART_INTR_ENABLE_RX_FRAME_ERR_MASK  |
      UART_INTR_ENABLE_RX_PARITY_ERR_MASK;

  // at the processor level, the UART interrupts should also be enabled
}
```

{{% section2 Common Examples }}

The following code shows the steps to transmit a string of characters.

```cpp
int uart_tx_rdy() {
  return ((*UART_FIFO_STATUS_REG & UART_FIFO_STATUS_TXLVL_MASK) == 32) ? 0 : 1;
}

void uart_send_char(char val) {
  while(!uart_tx_rdy()) {}
  *UART_WDATA_REG = val;
}

void uart_send_str(char *str) {
  while(*str != \0) {
    uart_send_char(*str++);
}
```

Do the following to receive a character, with -1 returned if RX is empty.

```cpp
int uart_rx_empty() {
  return ((*UART_FIFO_STATUS_REG & UART_FIFO_STATUS_RXLVL_MASK) ==
          (0 << UART_FIFO_STATUS_RXLVL_LSB)) ? 1 : 0;
}

char uart_rcv_char() {
  if(uart_rx_empty())
    return 0xff;
  return *UART_RDATA_REG;
}
```

{{% section2 Interrupt Handling }}

The code below shows one example of how to handle all UART interrupts
in one service routine.

```cpp
void uart_interrupt_routine() {
  volatile uint32 intr_state = *UART_INTR_STATE_REG;
  uint32 intr_state_mask = 0;
  char uart_ch;
  uint32 intr_enable_reg;

  // Turn off Interrupt Enable
  intr_enable_reg = *UART_INTR_ENABLE_REG;
  *UART_INTR_ENABLE_REG = intr_enable_reg & 0xFFFFFF00; // Clr bits 7:0

  if (intr_state & UART_INTR_STATE_RX_PARITY_ERR_MASK) {
    // Do something ...

    // Store Int mask
    intr_state_mask |= UART_INTR_STATE_RX_PARITY_ERR_MASK;
  }

  if (intr_state & UART_INTR_STATE_RX_BREAK_ERR_MASK) {
    // Do something ...

    // Store Int mask
    intr_state_mask |= UART_INTR_STATE_RX_BREAK_ERR_MASK;
  }

  // .. Frame Error

  // TX/RX Overflow Error

  // RX Int
  if (intr_state & UART_INTR_STATE_RX_WATERMARK_MASK) {
    while(1) {
      uart_ch = uart_rcv_char();
      if (uart_ch == 0xff) break;
      uart_buf.append(uart_ch);
    }
    // Store Int mask
    intr_state_mask |= UART_INTR_STATE_RX_WATERMARK_MASK;
  }

  // Clear Interrupt State
  *UART_INTR_STATE_REG = intr_state_mask;

  // Restore Interrupt Enable
  *UART_INTR_ENABLE_REG = intr_enable_reg;
}
```

One use of the `rx_timeout` interrupt is when the !!FIFO_CTRL.RXILVL
is set greater than one, so an interrupt is only fired when the fifo
is full to a certain level. If the remote device sends fewer than the
watermark number of characters before stopping sending (for example it
is waiting an acknowledgement) then the usual `rx_watermark` interrupt
would not be raised. In this case an `rx_timeout` would generate an
interrupt that allows the host to read these additional characters. The
`rx_timeout` can be selected based on the worst latency experienced by a
character. The worst case latency experienced by a character will happen
if characters happen to arrive just slower than the timeout: the second
character arrives just before the timeout for the first (resetting the
timer), the third just before the timeout from the second etc. In this
case the host will eventually get a watermark interrupt, this will happen
`((RXILVL - 1)*timeout)` after the first character was received.

{{% section2 Register Table }}

{{% registers x }}
