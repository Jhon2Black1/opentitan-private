// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

class rv_timer_env_cov extends cip_base_env_cov #(.CFG_T(rv_timer_env_cfg));
  `uvm_component_utils(rv_timer_env_cov)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    // add more covergroup here
  endfunction : new

endclass
