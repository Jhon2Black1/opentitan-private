// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package aes_reg_pkg;

// Register to internal design logic
typedef struct packed {

  struct packed {
    logic [31:0] q; // [538:507]
    logic qe; // [506]
  } key0;
  struct packed {
    logic [31:0] q; // [505:474]
    logic qe; // [473]
  } key1;
  struct packed {
    logic [31:0] q; // [472:441]
    logic qe; // [440]
  } key2;
  struct packed {
    logic [31:0] q; // [439:408]
    logic qe; // [407]
  } key3;
  struct packed {
    logic [31:0] q; // [406:375]
    logic qe; // [374]
  } key4;
  struct packed {
    logic [31:0] q; // [373:342]
    logic qe; // [341]
  } key5;
  struct packed {
    logic [31:0] q; // [340:309]
    logic qe; // [308]
  } key6;
  struct packed {
    logic [31:0] q; // [307:276]
    logic qe; // [275]
  } key7;
  struct packed {
    logic [31:0] q; // [274:243]
    logic qe; // [242]
  } data_in0;
  struct packed {
    logic [31:0] q; // [241:210]
    logic qe; // [209]
  } data_in1;
  struct packed {
    logic [31:0] q; // [208:177]
    logic qe; // [176]
  } data_in2;
  struct packed {
    logic [31:0] q; // [175:144]
    logic qe; // [143]
  } data_in3;
  struct packed {
    logic [31:0] q; // [142:111]
    logic re; // [110]
  } data_out0;
  struct packed {
    logic [31:0] q; // [109:78]
    logic re; // [77]
  } data_out1;
  struct packed {
    logic [31:0] q; // [76:45]
    logic re; // [44]
  } data_out2;
  struct packed {
    logic [31:0] q; // [43:12]
    logic re; // [11]
  } data_out3;
  struct packed {
    struct packed {
      logic q; // [10]
      logic qe; // [9]
    } mode;
    struct packed {
      logic [2:0] q; // [8:6]
      logic qe; // [5]
    } key_len;
    struct packed {
      logic q; // [4]
      logic qe; // [3]
    } manual_start_trigger;
    struct packed {
      logic q; // [2]
      logic qe; // [1]
    } force_data_overwrite;
  } ctrl;
  struct packed {
    logic [0:0] q; // [0:0]
  } trigger;
} aes_reg2hw_t;

// Internal design logic to register
typedef struct packed {

  struct packed {
    logic [31:0] d; // [141:110]
  } data_out0;
  struct packed {
    logic [31:0] d; // [109:78]
  } data_out1;
  struct packed {
    logic [31:0] d; // [77:46]
  } data_out2;
  struct packed {
    logic [31:0] d; // [45:14]
  } data_out3;
  struct packed {
    struct packed {
      logic [2:0] d; // [13:11]
      logic de; // [10]
    } key_len;
  } ctrl;
  struct packed {
    logic [0:0] d; // [9:9]
    logic de; // [8]
  } trigger;
  struct packed {
    struct packed {
      logic d;  // [7]
      logic de; // [6]
    } idle;
    struct packed {
      logic d;  // [5]
      logic de; // [4]
    } stall;
    struct packed {
      logic d;  // [3]
      logic de; // [2]
    } output_valid;
    struct packed {
      logic d;  // [1]
      logic de; // [0]
    } input_ready;
  } status;
} aes_hw2reg_t;

  // Register Address
  parameter AES_KEY0_OFFSET = 7'h 0;
  parameter AES_KEY1_OFFSET = 7'h 4;
  parameter AES_KEY2_OFFSET = 7'h 8;
  parameter AES_KEY3_OFFSET = 7'h c;
  parameter AES_KEY4_OFFSET = 7'h 10;
  parameter AES_KEY5_OFFSET = 7'h 14;
  parameter AES_KEY6_OFFSET = 7'h 18;
  parameter AES_KEY7_OFFSET = 7'h 1c;
  parameter AES_DATA_IN0_OFFSET = 7'h 20;
  parameter AES_DATA_IN1_OFFSET = 7'h 24;
  parameter AES_DATA_IN2_OFFSET = 7'h 28;
  parameter AES_DATA_IN3_OFFSET = 7'h 2c;
  parameter AES_DATA_OUT0_OFFSET = 7'h 30;
  parameter AES_DATA_OUT1_OFFSET = 7'h 34;
  parameter AES_DATA_OUT2_OFFSET = 7'h 38;
  parameter AES_DATA_OUT3_OFFSET = 7'h 3c;
  parameter AES_CTRL_OFFSET = 7'h 40;
  parameter AES_TRIGGER_OFFSET = 7'h 44;
  parameter AES_STATUS_OFFSET = 7'h 48;


endpackage
