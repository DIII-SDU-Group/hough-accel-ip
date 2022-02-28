// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// BUS_A
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read)
//        bit 7  - auto_restart (Read/Write)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0  - enable ap_done interrupt (Read/Write)
//        bit 1  - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0  - ap_done (COR/TOW)
//        bit 1  - ap_ready (COR/TOW)
//        others - reserved
// 0x10 : Data signal of img_in
//        bit 7~0 - img_in[7:0] (Read/Write)
//        others  - reserved
// 0x14 : reserved
// 0x18 : Data signal of theta_array
//        bit 31~0 - theta_array[31:0] (Read)
// 0x1c : Control signal of theta_array
//        bit 0  - theta_array_ap_vld (Read/COR)
//        others - reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XHOUGHLINES_ACCEL_BUS_A_ADDR_AP_CTRL          0x00
#define XHOUGHLINES_ACCEL_BUS_A_ADDR_GIE              0x04
#define XHOUGHLINES_ACCEL_BUS_A_ADDR_IER              0x08
#define XHOUGHLINES_ACCEL_BUS_A_ADDR_ISR              0x0c
#define XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_DATA      0x10
#define XHOUGHLINES_ACCEL_BUS_A_BITS_IMG_IN_DATA      8
#define XHOUGHLINES_ACCEL_BUS_A_ADDR_THETA_ARRAY_DATA 0x18
#define XHOUGHLINES_ACCEL_BUS_A_BITS_THETA_ARRAY_DATA 32
#define XHOUGHLINES_ACCEL_BUS_A_ADDR_THETA_ARRAY_CTRL 0x1c

