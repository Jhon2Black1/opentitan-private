// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
module tb;
  // dep packages
  import uvm_pkg::*;
  import dv_utils_pkg::*;
  import alert_handler_env_pkg::*;
  import alert_handler_test_pkg::*;

  // macro includes
  `include "uvm_macros.svh"
  `include "dv_macros.svh"

  wire clk, rst_n;
  wire [NUM_MAX_INTERRUPTS-1:0] interrupts;
  wire [NUM_MAX_ALERTS-1:0] alerts;
  wire [NUM_MAX_ESC_SEV-1:0] esc_en;
  wire entropy;

  // interfaces
  clk_rst_if clk_rst_if(.clk(clk), .rst_n(rst_n));
  pins_if #(NUM_MAX_INTERRUPTS) intr_if(interrupts);
  pins_if #(NUM_MAX_ALERTS) alerts_if(alerts);
  pins_if #(NUM_MAX_ESC_SEV) esc_en_if(esc_en);
  pins_if #(1) entropy_if(entropy);
  pins_if #(1) devmode_if();
  tl_if tl_if(.clk(clk), .rst_n(rst_n));

  // dut signals
  prim_pkg::alert_rx_t [alert_pkg::NAlerts-1:0] alert_rx;
  prim_pkg::alert_tx_t [alert_pkg::NAlerts-1:0] alert_tx;

  prim_pkg::esc_rx_t [alert_pkg::N_ESC_SEV-1:0] esc_rx;
  prim_pkg::esc_tx_t [alert_pkg::N_ESC_SEV-1:0] esc_tx;

  // escalation sender duts
  for (genvar k = 0; k < alert_pkg::NAlerts; k++) begin : gen_alert_tx
    prim_alert_sender #(
      .AsyncOn(alert_pkg::AsyncOn[k])
    ) i_prim_alert_sender (
      .clk_i      ( clk         ),
      .rst_ni     ( rst_n       ),
      .alert_i    ( alerts[k]   ),
      .alert_rx_i ( alert_rx[k] ),
      .alert_tx_o ( alert_tx[k] )
    );
  end

  // main dut
  alert_handler dut (
    .clk_i                ( clk           ),
    .rst_ni               ( rst_n         ),
    .tl_i                 ( tl_if.h2d     ),
    .tl_o                 ( tl_if.d2h     ),
    .intr_classa_o        ( interrupts[0] ),
    .intr_classb_o        ( interrupts[1] ),
    .intr_classc_o        ( interrupts[2] ),
    .intr_classd_o        ( interrupts[3] ),
    .crashdump_o          (               ),
    .entropy_i            ( entropy       ),
    .alert_rx_o           ( alert_rx      ),
    .alert_tx_i           ( alert_tx      ),
    .esc_rx_i             ( esc_rx        ),
    .esc_tx_o             ( esc_tx        )
  );

  // escalation receiver duts
  for (genvar k = 0; k < alert_pkg::N_ESC_SEV; k++) begin : gen_esc_rx
    prim_esc_receiver i_prim_esc_receiver (
      .clk_i    ( clk       ),
      .rst_ni   ( rst_n     ),
      .esc_en_o ( esc_en[k] ),
      .esc_rx_o ( esc_rx[k] ),
      .esc_tx_i ( esc_tx[k] )
    );
  end

  initial begin
    // drive clk and rst_n from clk_if
    clk_rst_if.set_active();
    uvm_config_db#(virtual clk_rst_if)::set(null, "*.env", "clk_rst_vif", clk_rst_if);
    uvm_config_db#(intr_vif)::set(null, "*.env", "intr_vif", intr_if);
    uvm_config_db#(alerts_vif)::set(null, "*.env", "alerts_vif", alerts_if);
    uvm_config_db#(esc_en_vif)::set(null, "*.env", "esc_en_vif", esc_en_if);
    uvm_config_db#(entropy_vif)::set(null, "*.env", "entropy_vif", entropy_if);
    uvm_config_db#(devmode_vif)::set(null, "*.env", "devmode_vif", devmode_if);
    uvm_config_db#(tlul_assert_vif)::set(null, "*.env", "tlul_assert_vif",
                                         tb.dut.tlul_assert_host);
    uvm_config_db#(virtual tl_if)::set(null, "*.env.m_tl_agent*", "vif", tl_if);
    $timeformat(-12, 0, " ps", 12);
    run_test();
  end

endmodule
