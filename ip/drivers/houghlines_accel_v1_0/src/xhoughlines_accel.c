// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xhoughlines_accel.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XHoughlines_accel_CfgInitialize(XHoughlines_accel *InstancePtr, XHoughlines_accel_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Bus_a_BaseAddress = ConfigPtr->Bus_a_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XHoughlines_accel_Start(XHoughlines_accel *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHoughlines_accel_ReadReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_AP_CTRL) & 0x80;
    XHoughlines_accel_WriteReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_AP_CTRL, Data | 0x01);
}

u32 XHoughlines_accel_IsDone(XHoughlines_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHoughlines_accel_ReadReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XHoughlines_accel_IsIdle(XHoughlines_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHoughlines_accel_ReadReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XHoughlines_accel_IsReady(XHoughlines_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHoughlines_accel_ReadReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XHoughlines_accel_EnableAutoRestart(XHoughlines_accel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHoughlines_accel_WriteReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_AP_CTRL, 0x80);
}

void XHoughlines_accel_DisableAutoRestart(XHoughlines_accel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHoughlines_accel_WriteReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_AP_CTRL, 0);
}

u32 XHoughlines_accel_Get_theta_array(XHoughlines_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHoughlines_accel_ReadReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_THETA_ARRAY_DATA);
    return Data;
}

u32 XHoughlines_accel_Get_theta_array_vld(XHoughlines_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHoughlines_accel_ReadReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_THETA_ARRAY_CTRL);
    return Data & 0x1;
}

u32 XHoughlines_accel_Get_img_in_BaseAddress(XHoughlines_accel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Bus_a_BaseAddress + XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_BASE);
}

u32 XHoughlines_accel_Get_img_in_HighAddress(XHoughlines_accel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Bus_a_BaseAddress + XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_HIGH);
}

u32 XHoughlines_accel_Get_img_in_TotalBytes(XHoughlines_accel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_HIGH - XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_BASE + 1);
}

u32 XHoughlines_accel_Get_img_in_BitWidth(XHoughlines_accel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHOUGHLINES_ACCEL_BUS_A_WIDTH_IMG_IN;
}

u32 XHoughlines_accel_Get_img_in_Depth(XHoughlines_accel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHOUGHLINES_ACCEL_BUS_A_DEPTH_IMG_IN;
}

u32 XHoughlines_accel_Write_img_in_Words(XHoughlines_accel *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_HIGH - XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Bus_a_BaseAddress + XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHoughlines_accel_Read_img_in_Words(XHoughlines_accel *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_HIGH - XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Bus_a_BaseAddress + XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHoughlines_accel_Write_img_in_Bytes(XHoughlines_accel *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_HIGH - XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Bus_a_BaseAddress + XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHoughlines_accel_Read_img_in_Bytes(XHoughlines_accel *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_HIGH - XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Bus_a_BaseAddress + XHOUGHLINES_ACCEL_BUS_A_ADDR_IMG_IN_BASE + offset + i);
    }
    return length;
}

void XHoughlines_accel_InterruptGlobalEnable(XHoughlines_accel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHoughlines_accel_WriteReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_GIE, 1);
}

void XHoughlines_accel_InterruptGlobalDisable(XHoughlines_accel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHoughlines_accel_WriteReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_GIE, 0);
}

void XHoughlines_accel_InterruptEnable(XHoughlines_accel *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XHoughlines_accel_ReadReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_IER);
    XHoughlines_accel_WriteReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_IER, Register | Mask);
}

void XHoughlines_accel_InterruptDisable(XHoughlines_accel *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XHoughlines_accel_ReadReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_IER);
    XHoughlines_accel_WriteReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_IER, Register & (~Mask));
}

void XHoughlines_accel_InterruptClear(XHoughlines_accel *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHoughlines_accel_WriteReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_ISR, Mask);
}

u32 XHoughlines_accel_InterruptGetEnabled(XHoughlines_accel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHoughlines_accel_ReadReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_IER);
}

u32 XHoughlines_accel_InterruptGetStatus(XHoughlines_accel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHoughlines_accel_ReadReg(InstancePtr->Bus_a_BaseAddress, XHOUGHLINES_ACCEL_BUS_A_ADDR_ISR);
}

