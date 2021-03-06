// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

class rv_timer_env_cfg extends cip_base_env_cfg #(.RAL_T(rv_timer_reg_block));
  `uvm_object_utils(rv_timer_env_cfg)
  `uvm_object_new

  virtual function void initialize(bit [TL_AW-1:0] csr_base_addr = '1,
                                   bit [TL_AW-1:0] csr_addr_map_size = 2048);
    super.initialize();
    // TODO set num_interrupts correctly
    num_interrupts = ral.intr_state0.get_n_used_bits();
  endfunction

endclass
