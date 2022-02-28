// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XHOUGHLINES_ACCEL_H
#define XHOUGHLINES_ACCEL_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xhoughlines_accel_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u32 Bus_a_BaseAddress;
} XHoughlines_accel_Config;
#endif

typedef struct {
    u64 Bus_a_BaseAddress;
    u32 IsReady;
} XHoughlines_accel;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XHoughlines_accel_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XHoughlines_accel_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XHoughlines_accel_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XHoughlines_accel_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XHoughlines_accel_Initialize(XHoughlines_accel *InstancePtr, u16 DeviceId);
XHoughlines_accel_Config* XHoughlines_accel_LookupConfig(u16 DeviceId);
int XHoughlines_accel_CfgInitialize(XHoughlines_accel *InstancePtr, XHoughlines_accel_Config *ConfigPtr);
#else
int XHoughlines_accel_Initialize(XHoughlines_accel *InstancePtr, const char* InstanceName);
int XHoughlines_accel_Release(XHoughlines_accel *InstancePtr);
#endif

void XHoughlines_accel_Start(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_IsDone(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_IsIdle(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_IsReady(XHoughlines_accel *InstancePtr);
void XHoughlines_accel_EnableAutoRestart(XHoughlines_accel *InstancePtr);
void XHoughlines_accel_DisableAutoRestart(XHoughlines_accel *InstancePtr);

u32 XHoughlines_accel_Get_theta_array_BaseAddress(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_Get_theta_array_HighAddress(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_Get_theta_array_TotalBytes(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_Get_theta_array_BitWidth(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_Get_theta_array_Depth(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_Write_theta_array_Words(XHoughlines_accel *InstancePtr, int offset, word_type *data, int length);
u32 XHoughlines_accel_Read_theta_array_Words(XHoughlines_accel *InstancePtr, int offset, word_type *data, int length);
u32 XHoughlines_accel_Write_theta_array_Bytes(XHoughlines_accel *InstancePtr, int offset, char *data, int length);
u32 XHoughlines_accel_Read_theta_array_Bytes(XHoughlines_accel *InstancePtr, int offset, char *data, int length);
u32 XHoughlines_accel_Get_img_in_BaseAddress(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_Get_img_in_HighAddress(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_Get_img_in_TotalBytes(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_Get_img_in_BitWidth(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_Get_img_in_Depth(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_Write_img_in_Words(XHoughlines_accel *InstancePtr, int offset, word_type *data, int length);
u32 XHoughlines_accel_Read_img_in_Words(XHoughlines_accel *InstancePtr, int offset, word_type *data, int length);
u32 XHoughlines_accel_Write_img_in_Bytes(XHoughlines_accel *InstancePtr, int offset, char *data, int length);
u32 XHoughlines_accel_Read_img_in_Bytes(XHoughlines_accel *InstancePtr, int offset, char *data, int length);

void XHoughlines_accel_InterruptGlobalEnable(XHoughlines_accel *InstancePtr);
void XHoughlines_accel_InterruptGlobalDisable(XHoughlines_accel *InstancePtr);
void XHoughlines_accel_InterruptEnable(XHoughlines_accel *InstancePtr, u32 Mask);
void XHoughlines_accel_InterruptDisable(XHoughlines_accel *InstancePtr, u32 Mask);
void XHoughlines_accel_InterruptClear(XHoughlines_accel *InstancePtr, u32 Mask);
u32 XHoughlines_accel_InterruptGetEnabled(XHoughlines_accel *InstancePtr);
u32 XHoughlines_accel_InterruptGetStatus(XHoughlines_accel *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
