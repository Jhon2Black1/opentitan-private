// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#include "uart.h"

#include "common.h"

inline void uart_init(unsigned int baud) {
  // nco = 2^20 * baud / fclk
  uint64_t uart_ctrl_nco = ((uint64_t)baud << 20) / CLK_FIXED_FREQ_HZ;
  REG32(UART_CTRL(0)) =
      ((uart_ctrl_nco & UART_CTRL_NCO_MASK) << UART_CTRL_NCO_OFFSET) |
      (1 << UART_CTRL_TX) | (1 << UART_CTRL_RX);

  // reset RX/TX FIFOs
  REG32(UART_FIFO_CTRL(0)) =
      (1 << UART_FIFO_CTRL_RXRST) | (1 << UART_FIFO_CTRL_TXRST);

  // disable interrupts
  REG32(UART_INTR_ENABLE(0)) = 0;
}

static int uart_tx_rdy(void) {
  return !(REG32(UART_STATUS(0)) & (1 << UART_STATUS_TXFULL));
}

void uart_send_char(char c) {
  while (!uart_tx_rdy()) {
  }
  REG32(UART_WDATA(0)) = c;
}

int uart_tx_empty(void) {
  return !!(REG32(UART_STATUS(0)) & (1 << UART_STATUS_TXEMPTY));
}

/**
 * Send a NULL-terminated string over UART
 */
void uart_send_str(char *str) {
  while (*str != '\0') {
    uart_send_char(*str++);
  }
}

#define hexchar(i) (((i & 0xf) > 9) ? (i & 0xf) - 10 + 'A' : (i & 0xf) + '0')

/**
 * Send unsigned int over UART
 */
void uart_send_uint(uint32_t n, int bits) {
  for (int i = bits - 4; i >= 0; i -= 4) {
    uart_send_char(hexchar(n >> i));
  }
}

int uart_rx_empty(void) {
  return !!(REG32(UART_STATUS(0)) & (1 << UART_STATUS_RXEMPTY));
}

/**
 * Receive a single character from UART
 *
 * @param c received character, caller-allocated
 * @return 0 on success, -1 if no data is available
 */
int uart_rcv_char(char *c) {
  if (uart_rx_empty()) {
    return -1;
  }

  *c = REG32(UART_RDATA(0));
  return 0;
}
