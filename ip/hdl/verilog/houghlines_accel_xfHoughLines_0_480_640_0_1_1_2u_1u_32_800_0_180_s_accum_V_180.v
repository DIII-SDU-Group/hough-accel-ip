// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module houghlines_accel_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_accum_V_180_ram (addr0, ce0, d0, we0,  clk);

parameter DWIDTH = 1;
parameter AWIDTH = 10;
parameter MEM_SIZE = 801;

input[AWIDTH-1:0] addr0;
input ce0;
input[DWIDTH-1:0] d0;
input we0;
input clk;

(* ram_style = "block" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];




always @(posedge clk)  
begin 
    if (ce0) begin
        if (we0) 
            ram[addr0] <= d0; 
    end
end


endmodule

`timescale 1 ns / 1 ps
module houghlines_accel_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_accum_V_180(
    reset,
    clk,
    address0,
    ce0,
    we0,
    d0);

parameter DataWidth = 32'd1;
parameter AddressRange = 32'd801;
parameter AddressWidth = 32'd10;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
input we0;
input[DataWidth - 1:0] d0;



houghlines_accel_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_accum_V_180_ram houghlines_accel_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_accum_V_180_ram_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .we0( we0 ),
    .d0( d0 ));

endmodule

