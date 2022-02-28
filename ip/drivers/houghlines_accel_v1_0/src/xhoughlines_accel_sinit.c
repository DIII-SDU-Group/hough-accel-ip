// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xhoughlines_accel.h"

extern XHoughlines_accel_Config XHoughlines_accel_ConfigTable[];

XHoughlines_accel_Config *XHoughlines_accel_LookupConfig(u16 DeviceId) {
	XHoughlines_accel_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XHOUGHLINES_ACCEL_NUM_INSTANCES; Index++) {
		if (XHoughlines_accel_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XHoughlines_accel_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XHoughlines_accel_Initialize(XHoughlines_accel *InstancePtr, u16 DeviceId) {
	XHoughlines_accel_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XHoughlines_accel_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XHoughlines_accel_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

