// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package rv_plic_reg_pkg;

  // Param list
  localparam int NumSrc = 54;
  localparam int NumTarget = 1;

/////////////////////////////////////////////////////////////////////
// Typedefs for multiregs
/////////////////////////////////////////////////////////////////////

typedef struct packed {
  logic [0:0] q;
} rv_plic_reg2hw_le_mreg_t;
typedef struct packed {
  logic [0:0] q;
} rv_plic_reg2hw_ie0_mreg_t;

typedef struct packed {
  logic [0:0] d;
  logic de;
} rv_plic_hw2reg_ip_mreg_t;

/////////////////////////////////////////////////////////////////////
// Register to internal design logic
/////////////////////////////////////////////////////////////////////

typedef struct packed {
  rv_plic_reg2hw_le_mreg_t [53:0] le; // [226:173]
  struct packed {
    logic [1:0] q; // [172:171]
  } prio0;
  struct packed {
    logic [1:0] q; // [170:169]
  } prio1;
  struct packed {
    logic [1:0] q; // [168:167]
  } prio2;
  struct packed {
    logic [1:0] q; // [166:165]
  } prio3;
  struct packed {
    logic [1:0] q; // [164:163]
  } prio4;
  struct packed {
    logic [1:0] q; // [162:161]
  } prio5;
  struct packed {
    logic [1:0] q; // [160:159]
  } prio6;
  struct packed {
    logic [1:0] q; // [158:157]
  } prio7;
  struct packed {
    logic [1:0] q; // [156:155]
  } prio8;
  struct packed {
    logic [1:0] q; // [154:153]
  } prio9;
  struct packed {
    logic [1:0] q; // [152:151]
  } prio10;
  struct packed {
    logic [1:0] q; // [150:149]
  } prio11;
  struct packed {
    logic [1:0] q; // [148:147]
  } prio12;
  struct packed {
    logic [1:0] q; // [146:145]
  } prio13;
  struct packed {
    logic [1:0] q; // [144:143]
  } prio14;
  struct packed {
    logic [1:0] q; // [142:141]
  } prio15;
  struct packed {
    logic [1:0] q; // [140:139]
  } prio16;
  struct packed {
    logic [1:0] q; // [138:137]
  } prio17;
  struct packed {
    logic [1:0] q; // [136:135]
  } prio18;
  struct packed {
    logic [1:0] q; // [134:133]
  } prio19;
  struct packed {
    logic [1:0] q; // [132:131]
  } prio20;
  struct packed {
    logic [1:0] q; // [130:129]
  } prio21;
  struct packed {
    logic [1:0] q; // [128:127]
  } prio22;
  struct packed {
    logic [1:0] q; // [126:125]
  } prio23;
  struct packed {
    logic [1:0] q; // [124:123]
  } prio24;
  struct packed {
    logic [1:0] q; // [122:121]
  } prio25;
  struct packed {
    logic [1:0] q; // [120:119]
  } prio26;
  struct packed {
    logic [1:0] q; // [118:117]
  } prio27;
  struct packed {
    logic [1:0] q; // [116:115]
  } prio28;
  struct packed {
    logic [1:0] q; // [114:113]
  } prio29;
  struct packed {
    logic [1:0] q; // [112:111]
  } prio30;
  struct packed {
    logic [1:0] q; // [110:109]
  } prio31;
  struct packed {
    logic [1:0] q; // [108:107]
  } prio32;
  struct packed {
    logic [1:0] q; // [106:105]
  } prio33;
  struct packed {
    logic [1:0] q; // [104:103]
  } prio34;
  struct packed {
    logic [1:0] q; // [102:101]
  } prio35;
  struct packed {
    logic [1:0] q; // [100:99]
  } prio36;
  struct packed {
    logic [1:0] q; // [98:97]
  } prio37;
  struct packed {
    logic [1:0] q; // [96:95]
  } prio38;
  struct packed {
    logic [1:0] q; // [94:93]
  } prio39;
  struct packed {
    logic [1:0] q; // [92:91]
  } prio40;
  struct packed {
    logic [1:0] q; // [90:89]
  } prio41;
  struct packed {
    logic [1:0] q; // [88:87]
  } prio42;
  struct packed {
    logic [1:0] q; // [86:85]
  } prio43;
  struct packed {
    logic [1:0] q; // [84:83]
  } prio44;
  struct packed {
    logic [1:0] q; // [82:81]
  } prio45;
  struct packed {
    logic [1:0] q; // [80:79]
  } prio46;
  struct packed {
    logic [1:0] q; // [78:77]
  } prio47;
  struct packed {
    logic [1:0] q; // [76:75]
  } prio48;
  struct packed {
    logic [1:0] q; // [74:73]
  } prio49;
  struct packed {
    logic [1:0] q; // [72:71]
  } prio50;
  struct packed {
    logic [1:0] q; // [70:69]
  } prio51;
  struct packed {
    logic [1:0] q; // [68:67]
  } prio52;
  struct packed {
    logic [1:0] q; // [66:65]
  } prio53;
  rv_plic_reg2hw_ie0_mreg_t [53:0] ie0; // [64:11]
  struct packed {
    logic [1:0] q; // [10:9]
  } threshold0;
  struct packed {
    logic [5:0] q; // [8:3]
    logic qe; // [2]
    logic re; // [1]
  } cc0;
  struct packed {
    logic [0:0] q; // [0:0]
  } msip0;
} rv_plic_reg2hw_t;

/////////////////////////////////////////////////////////////////////
// Internal design logic to register
/////////////////////////////////////////////////////////////////////

typedef struct packed {
  rv_plic_hw2reg_ip_mreg_t [53:0] ip; // [113:6]
  struct packed {
    logic [5:0] d; // [5:0]
  } cc0;
} rv_plic_hw2reg_t;

  // Register Address
  parameter RV_PLIC_IP0_OFFSET = 9'h 0;
  parameter RV_PLIC_IP1_OFFSET = 9'h 4;
  parameter RV_PLIC_LE0_OFFSET = 9'h 8;
  parameter RV_PLIC_LE1_OFFSET = 9'h c;
  parameter RV_PLIC_PRIO0_OFFSET = 9'h 10;
  parameter RV_PLIC_PRIO1_OFFSET = 9'h 14;
  parameter RV_PLIC_PRIO2_OFFSET = 9'h 18;
  parameter RV_PLIC_PRIO3_OFFSET = 9'h 1c;
  parameter RV_PLIC_PRIO4_OFFSET = 9'h 20;
  parameter RV_PLIC_PRIO5_OFFSET = 9'h 24;
  parameter RV_PLIC_PRIO6_OFFSET = 9'h 28;
  parameter RV_PLIC_PRIO7_OFFSET = 9'h 2c;
  parameter RV_PLIC_PRIO8_OFFSET = 9'h 30;
  parameter RV_PLIC_PRIO9_OFFSET = 9'h 34;
  parameter RV_PLIC_PRIO10_OFFSET = 9'h 38;
  parameter RV_PLIC_PRIO11_OFFSET = 9'h 3c;
  parameter RV_PLIC_PRIO12_OFFSET = 9'h 40;
  parameter RV_PLIC_PRIO13_OFFSET = 9'h 44;
  parameter RV_PLIC_PRIO14_OFFSET = 9'h 48;
  parameter RV_PLIC_PRIO15_OFFSET = 9'h 4c;
  parameter RV_PLIC_PRIO16_OFFSET = 9'h 50;
  parameter RV_PLIC_PRIO17_OFFSET = 9'h 54;
  parameter RV_PLIC_PRIO18_OFFSET = 9'h 58;
  parameter RV_PLIC_PRIO19_OFFSET = 9'h 5c;
  parameter RV_PLIC_PRIO20_OFFSET = 9'h 60;
  parameter RV_PLIC_PRIO21_OFFSET = 9'h 64;
  parameter RV_PLIC_PRIO22_OFFSET = 9'h 68;
  parameter RV_PLIC_PRIO23_OFFSET = 9'h 6c;
  parameter RV_PLIC_PRIO24_OFFSET = 9'h 70;
  parameter RV_PLIC_PRIO25_OFFSET = 9'h 74;
  parameter RV_PLIC_PRIO26_OFFSET = 9'h 78;
  parameter RV_PLIC_PRIO27_OFFSET = 9'h 7c;
  parameter RV_PLIC_PRIO28_OFFSET = 9'h 80;
  parameter RV_PLIC_PRIO29_OFFSET = 9'h 84;
  parameter RV_PLIC_PRIO30_OFFSET = 9'h 88;
  parameter RV_PLIC_PRIO31_OFFSET = 9'h 8c;
  parameter RV_PLIC_PRIO32_OFFSET = 9'h 90;
  parameter RV_PLIC_PRIO33_OFFSET = 9'h 94;
  parameter RV_PLIC_PRIO34_OFFSET = 9'h 98;
  parameter RV_PLIC_PRIO35_OFFSET = 9'h 9c;
  parameter RV_PLIC_PRIO36_OFFSET = 9'h a0;
  parameter RV_PLIC_PRIO37_OFFSET = 9'h a4;
  parameter RV_PLIC_PRIO38_OFFSET = 9'h a8;
  parameter RV_PLIC_PRIO39_OFFSET = 9'h ac;
  parameter RV_PLIC_PRIO40_OFFSET = 9'h b0;
  parameter RV_PLIC_PRIO41_OFFSET = 9'h b4;
  parameter RV_PLIC_PRIO42_OFFSET = 9'h b8;
  parameter RV_PLIC_PRIO43_OFFSET = 9'h bc;
  parameter RV_PLIC_PRIO44_OFFSET = 9'h c0;
  parameter RV_PLIC_PRIO45_OFFSET = 9'h c4;
  parameter RV_PLIC_PRIO46_OFFSET = 9'h c8;
  parameter RV_PLIC_PRIO47_OFFSET = 9'h cc;
  parameter RV_PLIC_PRIO48_OFFSET = 9'h d0;
  parameter RV_PLIC_PRIO49_OFFSET = 9'h d4;
  parameter RV_PLIC_PRIO50_OFFSET = 9'h d8;
  parameter RV_PLIC_PRIO51_OFFSET = 9'h dc;
  parameter RV_PLIC_PRIO52_OFFSET = 9'h e0;
  parameter RV_PLIC_PRIO53_OFFSET = 9'h e4;
  parameter RV_PLIC_IE00_OFFSET = 9'h 100;
  parameter RV_PLIC_IE01_OFFSET = 9'h 104;
  parameter RV_PLIC_THRESHOLD0_OFFSET = 9'h 108;
  parameter RV_PLIC_CC0_OFFSET = 9'h 10c;
  parameter RV_PLIC_MSIP0_OFFSET = 9'h 110;


  // Register Index
  typedef enum int {
    RV_PLIC_IP0,
    RV_PLIC_IP1,
    RV_PLIC_LE0,
    RV_PLIC_LE1,
    RV_PLIC_PRIO0,
    RV_PLIC_PRIO1,
    RV_PLIC_PRIO2,
    RV_PLIC_PRIO3,
    RV_PLIC_PRIO4,
    RV_PLIC_PRIO5,
    RV_PLIC_PRIO6,
    RV_PLIC_PRIO7,
    RV_PLIC_PRIO8,
    RV_PLIC_PRIO9,
    RV_PLIC_PRIO10,
    RV_PLIC_PRIO11,
    RV_PLIC_PRIO12,
    RV_PLIC_PRIO13,
    RV_PLIC_PRIO14,
    RV_PLIC_PRIO15,
    RV_PLIC_PRIO16,
    RV_PLIC_PRIO17,
    RV_PLIC_PRIO18,
    RV_PLIC_PRIO19,
    RV_PLIC_PRIO20,
    RV_PLIC_PRIO21,
    RV_PLIC_PRIO22,
    RV_PLIC_PRIO23,
    RV_PLIC_PRIO24,
    RV_PLIC_PRIO25,
    RV_PLIC_PRIO26,
    RV_PLIC_PRIO27,
    RV_PLIC_PRIO28,
    RV_PLIC_PRIO29,
    RV_PLIC_PRIO30,
    RV_PLIC_PRIO31,
    RV_PLIC_PRIO32,
    RV_PLIC_PRIO33,
    RV_PLIC_PRIO34,
    RV_PLIC_PRIO35,
    RV_PLIC_PRIO36,
    RV_PLIC_PRIO37,
    RV_PLIC_PRIO38,
    RV_PLIC_PRIO39,
    RV_PLIC_PRIO40,
    RV_PLIC_PRIO41,
    RV_PLIC_PRIO42,
    RV_PLIC_PRIO43,
    RV_PLIC_PRIO44,
    RV_PLIC_PRIO45,
    RV_PLIC_PRIO46,
    RV_PLIC_PRIO47,
    RV_PLIC_PRIO48,
    RV_PLIC_PRIO49,
    RV_PLIC_PRIO50,
    RV_PLIC_PRIO51,
    RV_PLIC_PRIO52,
    RV_PLIC_PRIO53,
    RV_PLIC_IE00,
    RV_PLIC_IE01,
    RV_PLIC_THRESHOLD0,
    RV_PLIC_CC0,
    RV_PLIC_MSIP0
  } rv_plic_id_e;

  // Register width information to check illegal writes
  localparam logic [3:0] RV_PLIC_PERMIT [63] = '{
    4'b 1111, // index[ 0] RV_PLIC_IP0
    4'b 1111, // index[ 1] RV_PLIC_IP1
    4'b 1111, // index[ 2] RV_PLIC_LE0
    4'b 1111, // index[ 3] RV_PLIC_LE1
    4'b 0001, // index[ 4] RV_PLIC_PRIO0
    4'b 0001, // index[ 5] RV_PLIC_PRIO1
    4'b 0001, // index[ 6] RV_PLIC_PRIO2
    4'b 0001, // index[ 7] RV_PLIC_PRIO3
    4'b 0001, // index[ 8] RV_PLIC_PRIO4
    4'b 0001, // index[ 9] RV_PLIC_PRIO5
    4'b 0001, // index[10] RV_PLIC_PRIO6
    4'b 0001, // index[11] RV_PLIC_PRIO7
    4'b 0001, // index[12] RV_PLIC_PRIO8
    4'b 0001, // index[13] RV_PLIC_PRIO9
    4'b 0001, // index[14] RV_PLIC_PRIO10
    4'b 0001, // index[15] RV_PLIC_PRIO11
    4'b 0001, // index[16] RV_PLIC_PRIO12
    4'b 0001, // index[17] RV_PLIC_PRIO13
    4'b 0001, // index[18] RV_PLIC_PRIO14
    4'b 0001, // index[19] RV_PLIC_PRIO15
    4'b 0001, // index[20] RV_PLIC_PRIO16
    4'b 0001, // index[21] RV_PLIC_PRIO17
    4'b 0001, // index[22] RV_PLIC_PRIO18
    4'b 0001, // index[23] RV_PLIC_PRIO19
    4'b 0001, // index[24] RV_PLIC_PRIO20
    4'b 0001, // index[25] RV_PLIC_PRIO21
    4'b 0001, // index[26] RV_PLIC_PRIO22
    4'b 0001, // index[27] RV_PLIC_PRIO23
    4'b 0001, // index[28] RV_PLIC_PRIO24
    4'b 0001, // index[29] RV_PLIC_PRIO25
    4'b 0001, // index[30] RV_PLIC_PRIO26
    4'b 0001, // index[31] RV_PLIC_PRIO27
    4'b 0001, // index[32] RV_PLIC_PRIO28
    4'b 0001, // index[33] RV_PLIC_PRIO29
    4'b 0001, // index[34] RV_PLIC_PRIO30
    4'b 0001, // index[35] RV_PLIC_PRIO31
    4'b 0001, // index[36] RV_PLIC_PRIO32
    4'b 0001, // index[37] RV_PLIC_PRIO33
    4'b 0001, // index[38] RV_PLIC_PRIO34
    4'b 0001, // index[39] RV_PLIC_PRIO35
    4'b 0001, // index[40] RV_PLIC_PRIO36
    4'b 0001, // index[41] RV_PLIC_PRIO37
    4'b 0001, // index[42] RV_PLIC_PRIO38
    4'b 0001, // index[43] RV_PLIC_PRIO39
    4'b 0001, // index[44] RV_PLIC_PRIO40
    4'b 0001, // index[45] RV_PLIC_PRIO41
    4'b 0001, // index[46] RV_PLIC_PRIO42
    4'b 0001, // index[47] RV_PLIC_PRIO43
    4'b 0001, // index[48] RV_PLIC_PRIO44
    4'b 0001, // index[49] RV_PLIC_PRIO45
    4'b 0001, // index[50] RV_PLIC_PRIO46
    4'b 0001, // index[51] RV_PLIC_PRIO47
    4'b 0001, // index[52] RV_PLIC_PRIO48
    4'b 0001, // index[53] RV_PLIC_PRIO49
    4'b 0001, // index[54] RV_PLIC_PRIO50
    4'b 0001, // index[55] RV_PLIC_PRIO51
    4'b 0001, // index[56] RV_PLIC_PRIO52
    4'b 0001, // index[57] RV_PLIC_PRIO53
    4'b 1111, // index[58] RV_PLIC_IE00
    4'b 1111, // index[59] RV_PLIC_IE01
    4'b 0001, // index[60] RV_PLIC_THRESHOLD0
    4'b 0001, // index[61] RV_PLIC_CC0
    4'b 0001  // index[62] RV_PLIC_MSIP0
  };
endpackage

