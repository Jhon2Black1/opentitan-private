// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

class chip_env_cfg extends dv_base_env_cfg #(.RAL_T(chip_reg_block));

  bit                 stub_cpu;

  // chip top interfaces
  gpio_vif            gpio_vif;
  virtual mem_bkdr_if mem_bkdr_vifs[chip_mem_e];

  // ext component cfgs
  rand uart_agent_cfg m_uart_agent_cfg;
  rand jtag_agent_cfg m_jtag_agent_cfg;

  // tap tl_agent onto cpu data interaface
  rand tl_agent_cfg   m_cpu_d_tl_agent_cfg;

  `uvm_object_utils_begin(chip_env_cfg)
    `uvm_field_int   (stub_cpu,             UVM_DEFAULT)
    `uvm_field_object(m_uart_agent_cfg,     UVM_DEFAULT)
    `uvm_field_object(m_jtag_agent_cfg,     UVM_DEFAULT)
    `uvm_field_object(m_cpu_d_tl_agent_cfg, UVM_DEFAULT)
  `uvm_object_utils_end

  `uvm_object_new

  // chip csr base address starts at 0
  constraint csr_base_addr_c {
    csr_base_addr == 0;
  }

  virtual function void initialize(bit [TL_AW-1:0] csr_base_addr = '1,
                                   bit [TL_AW-1:0] csr_addr_map_size = 2048);

    chip_mem_e mems[] = {Rom, FlashBank0, FlashBank1};

    super.initialize();
    // create uart agent config obj
    m_uart_agent_cfg = uart_agent_cfg::type_id::create("m_uart_agent_cfg");
    m_uart_agent_cfg.en_tx_monitor = 1'b0;
    m_uart_agent_cfg.en_rx_monitor = 1'b0;
    // create jtag agent config obj
    m_jtag_agent_cfg = jtag_agent_cfg::type_id::create("m_jtag_agent_cfg");
    // create tl agent config obj
    m_cpu_d_tl_agent_cfg = tl_agent_cfg::type_id::create("m_cpu_d_tl_agent_cfg");
    m_cpu_d_tl_agent_cfg.is_active = stub_cpu;
    m_cpu_d_tl_agent_cfg.is_host = 1'b1;
    // initialize the mem_bkdr_if vifs we want for this chip
    foreach(mems[mem]) begin
      mem_bkdr_vifs[mems[mem]] = null;
    end
  endfunction

endclass
