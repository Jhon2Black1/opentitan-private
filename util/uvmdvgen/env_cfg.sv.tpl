// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

% if is_cip:
class ${name}_env_cfg extends cip_base_env_cfg #(.RAL_T(${name}_reg_block));
% else:
class ${name}_env_cfg extends dv_base_env_cfg #(.RAL_T(${name}_reg_block));
% endif

  // ext component cfgs
% for agent in env_agents:
  rand ${agent}_agent_cfg m_${agent}_agent_cfg;
% endfor

  `uvm_object_utils_begin(${name}_env_cfg)
% for agent in env_agents:
    `uvm_field_object(m_${agent}_agent_cfg, UVM_DEFAULT)
% endfor
  `uvm_object_utils_end

  `uvm_object_new

  virtual function void initialize(bit [TL_AW-1:0] csr_base_addr = '1,
                                   bit [TL_AW-1:0] csr_addr_map_size = 2048);
    super.initialize();
% for agent in env_agents:
    // create ${agent} agent config obj
    m_${agent}_agent_cfg = ${agent}_agent_cfg::type_id::create("m_${agent}_agent_cfg");
% endfor
% if is_cip:

    // set num_interrupts & num_alerts which will be used to create coverage and more
    num_interrupts = ral.intr_state.get_n_used_bits();
    num_alerts = 0;
% endif
  endfunction

endclass
