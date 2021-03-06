// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

class cip_base_env_cfg #(type RAL_T = dv_base_reg_block) extends dv_base_env_cfg #(RAL_T);

  // ext component cfgs
  rand tl_agent_cfg     m_tl_agent_cfg;

  // common interfaces - intrrupts and alerts
  intr_vif              intr_vif;
  alerts_vif            alerts_vif;

  uint                  num_interrupts;
  uint                  num_alerts;

  `uvm_object_param_utils_begin(cip_base_env_cfg #(RAL_T))
    `uvm_field_object(m_tl_agent_cfg, UVM_DEFAULT)
    `uvm_field_int   (num_interrupts, UVM_DEFAULT)
    `uvm_field_int   (num_alerts,     UVM_DEFAULT)
 `uvm_object_utils_end

  `uvm_object_new

  virtual function void initialize(bit [TL_AW-1:0] csr_base_addr = '1,
                                   bit [TL_AW-1:0] csr_addr_map_size = 2048);
    super.initialize(csr_base_addr, csr_addr_map_size);
    // create tl agent config obj
    m_tl_agent_cfg = tl_agent_cfg::type_id::create("m_tl_agent_cfg");
    m_tl_agent_cfg.is_host = 1'b1;
  endfunction

endclass
