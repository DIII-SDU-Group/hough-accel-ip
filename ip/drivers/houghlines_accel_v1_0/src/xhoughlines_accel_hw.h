// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// BUS_A
// 0x00000 : Control signals
//           bit 0  - ap_start (Read/Write/COH)
//           bit 1  - ap_done (Read/COR)
//           bit 2  - ap_idle (Read)
//           bit 3  - ap_ready (Read)
//           bit 7  - auto_restart (Read/Write)
//           others - reserved
// 0x00004 : Global Interrupt Enable Register
//           bit 0  - Global Interrupt Enable (Read/Write)
//           others - reserved
// 0x00008 : IP Interrupt Enable Register (Read/Write)
//           bit 0  - enable ap_done interrupt (Read/Write)
//           bit 1  - enable ap_ready interrupt (Read/Write)
//           others - reserved
// 0x0000c : IP Interrupt Status Register (Read/TOW)
//           bit 0  - ap_done (COR/TOW)
//           bit 1  - ap_ready (COR/TOW)
//           others - reserved
// 0x00080 ~
// 0x000ff : Memory 'theta_array' (32 * 32b)
//           Word n : bit [31:0] - theta_array[n]
// 0x80000 ~
// 0xfffff : Memory 'img_in' (307200 * 8b)
//           Word n : bit [ 7: 0] - img_in[4n]
//                    bit [15: 8] - img_in[4n+1]
//                    bit [23:16] - img_in[4n+2]
//                    bit [31:24] - img_in[4n+3]
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XHOUGHLINES_ACCEL_BUS_A_ADDR_AP_CTRL          0x00000
#define XHOUGHLINES_ACCEL_BUS_A_ADDR_GIE              0x00004
#define XHOUGHLINES_ACCEL_BUS_A_ADDR_IER              0x00008
#define XHOUGHLINES_ACCEL_BUS_A_ADDR_ISR              0x0000c
#define XHOUGHLINES_ACCEL_BUS_A_ADDR_THETA_ARRAY_BASE 0x00080
#define XHOUGHLINES_ACCEL_BUS_A_ADDR_THETA_ARRAY_HIGH 0x000ff
#define XHOUGHLINES_ACCEL_BUS_A_WIDTH_THETA_ARRAY     32
#define XHOUGHLINES_ACCEL_BUS_A_DEPTH_THETA_ARRAY     32
#define XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_BASE      0x80000
#define XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_HIGH      0xfffff
#define XHOUGHLINES_ACCEL_BUS_A_WIDTH_IMG_IN          8
#define XHOUGHLINES_ACCEL_BUS_A_DEPTH_IMG_IN          307200

