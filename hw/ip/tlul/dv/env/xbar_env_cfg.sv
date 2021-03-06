// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

// ---------------------------------------------
// Xbar environment configuration class
// ---------------------------------------------
class xbar_env_cfg extends uvm_object;

  rand tl_agent_cfg  host_agent_cfg[];
  rand tl_agent_cfg  device_agent_cfg[];
  int                num_of_hosts;
  int                num_of_devices;

  `uvm_object_utils_begin(xbar_env_cfg)
    `uvm_field_array_object(host_agent_cfg,    UVM_DEFAULT)
    `uvm_field_array_object(device_agent_cfg,  UVM_DEFAULT)
    `uvm_field_int(num_of_hosts,               UVM_DEFAULT)
    `uvm_field_int(num_of_devices,             UVM_DEFAULT)
  `uvm_object_utils_end

  function new (string name = "");
    super.new(name);
  endfunction : new

  function void init_cfg();
    // Host TL agent cfg
    num_of_hosts = xbar_hosts.size();
    host_agent_cfg = new[num_of_hosts];
    foreach (host_agent_cfg[i]) begin
      host_agent_cfg[i] = tl_agent_cfg::type_id::
                          create($sformatf("%0s_agent_cfg", xbar_hosts[i].host_name));
      host_agent_cfg[i].is_host = 1;
    end
    // Device TL agent cfg
    num_of_devices = xbar_devices.size();
    device_agent_cfg = new[num_of_devices];
    foreach (device_agent_cfg[i]) begin
      device_agent_cfg[i] = tl_agent_cfg::type_id::
                            create($sformatf("%0s_agent_cfg", xbar_devices[i].device_name));
      device_agent_cfg[i].is_host = 0;
    end
  endfunction

endclass
