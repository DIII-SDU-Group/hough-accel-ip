// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="houghlines_accel_houghlines_accel,hls_ip_2020_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu3eg-sbva484-1-i,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=dataflow,HLS_SYN_CLOCK=6.923278,HLS_SYN_LAT=258878,HLS_SYN_TPT=258877,HLS_SYN_MEM=437,HLS_SYN_DSP=0,HLS_SYN_FF=60520,HLS_SYN_LUT=1839171,HLS_VERSION=2020_2}" *)

module houghlines_accel (
        s_axi_BUS_A_AWVALID,
        s_axi_BUS_A_AWREADY,
        s_axi_BUS_A_AWADDR,
        s_axi_BUS_A_WVALID,
        s_axi_BUS_A_WREADY,
        s_axi_BUS_A_WDATA,
        s_axi_BUS_A_WSTRB,
        s_axi_BUS_A_ARVALID,
        s_axi_BUS_A_ARREADY,
        s_axi_BUS_A_ARADDR,
        s_axi_BUS_A_RVALID,
        s_axi_BUS_A_RREADY,
        s_axi_BUS_A_RDATA,
        s_axi_BUS_A_RRESP,
        s_axi_BUS_A_BVALID,
        s_axi_BUS_A_BREADY,
        s_axi_BUS_A_BRESP,
        ap_clk,
        ap_rst_n,
        interrupt
);

parameter    C_S_AXI_BUS_A_DATA_WIDTH = 32;
parameter    C_S_AXI_BUS_A_ADDR_WIDTH = 20;
parameter    C_S_AXI_DATA_WIDTH = 32;
parameter    C_S_AXI_ADDR_WIDTH = 32;

parameter C_S_AXI_BUS_A_WSTRB_WIDTH = (32 / 8);
parameter C_S_AXI_WSTRB_WIDTH = (32 / 8);

input   s_axi_BUS_A_AWVALID;
output   s_axi_BUS_A_AWREADY;
input  [C_S_AXI_BUS_A_ADDR_WIDTH - 1:0] s_axi_BUS_A_AWADDR;
input   s_axi_BUS_A_WVALID;
output   s_axi_BUS_A_WREADY;
input  [C_S_AXI_BUS_A_DATA_WIDTH - 1:0] s_axi_BUS_A_WDATA;
input  [C_S_AXI_BUS_A_WSTRB_WIDTH - 1:0] s_axi_BUS_A_WSTRB;
input   s_axi_BUS_A_ARVALID;
output   s_axi_BUS_A_ARREADY;
input  [C_S_AXI_BUS_A_ADDR_WIDTH - 1:0] s_axi_BUS_A_ARADDR;
output   s_axi_BUS_A_RVALID;
input   s_axi_BUS_A_RREADY;
output  [C_S_AXI_BUS_A_DATA_WIDTH - 1:0] s_axi_BUS_A_RDATA;
output  [1:0] s_axi_BUS_A_RRESP;
output   s_axi_BUS_A_BVALID;
input   s_axi_BUS_A_BREADY;
output  [1:0] s_axi_BUS_A_BRESP;
input   ap_clk;
input   ap_rst_n;
output   interrupt;

 reg    ap_rst_n_inv;
wire   [7:0] img_in_q0;
wire    ap_start;
wire    ap_ready;
wire    ap_done;
wire    ap_idle;
wire    Block_split1_proc_U0_ap_start;
wire    Block_split1_proc_U0_ap_done;
wire    Block_split1_proc_U0_ap_continue;
wire    Block_split1_proc_U0_ap_idle;
wire    Block_split1_proc_U0_ap_ready;
wire   [5:0] Block_split1_proc_U0_imgInput_rows_out_din;
wire    Block_split1_proc_U0_imgInput_rows_out_write;
wire   [9:0] Block_split1_proc_U0_imgInput_cols_out_din;
wire    Block_split1_proc_U0_imgInput_cols_out_write;
wire    Array2xfMat_8_0_480_640_1_U0_ap_start;
wire    Array2xfMat_8_0_480_640_1_U0_ap_done;
wire    Array2xfMat_8_0_480_640_1_U0_ap_continue;
wire    Array2xfMat_8_0_480_640_1_U0_ap_idle;
wire    Array2xfMat_8_0_480_640_1_U0_ap_ready;
wire    Array2xfMat_8_0_480_640_1_U0_start_out;
wire    Array2xfMat_8_0_480_640_1_U0_start_write;
wire   [18:0] Array2xfMat_8_0_480_640_1_U0_img_in_address0;
wire    Array2xfMat_8_0_480_640_1_U0_img_in_ce0;
wire   [7:0] Array2xfMat_8_0_480_640_1_U0_imgInput_44_din;
wire    Array2xfMat_8_0_480_640_1_U0_imgInput_44_write;
wire    Array2xfMat_8_0_480_640_1_U0_dstMat_rows_read;
wire    Array2xfMat_8_0_480_640_1_U0_dstMat_cols_read;
wire   [5:0] Array2xfMat_8_0_480_640_1_U0_dstMat_rows_out_din;
wire    Array2xfMat_8_0_480_640_1_U0_dstMat_rows_out_write;
wire   [9:0] Array2xfMat_8_0_480_640_1_U0_dstMat_cols_out_din;
wire    Array2xfMat_8_0_480_640_1_U0_dstMat_cols_out_write;
wire    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_start;
wire    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_done;
wire    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_continue;
wire    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_idle;
wire    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_ready;
wire    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_imgInput_44_read;
wire   [31:0] HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array;
wire    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_ap_vld;
wire    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_p_src_mat_rows_read;
wire    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_p_src_mat_cols_read;
wire    ap_sync_continue;
wire    imgInput_rows_c_full_n;
wire   [5:0] imgInput_rows_c_dout;
wire    imgInput_rows_c_empty_n;
wire    imgInput_cols_c_full_n;
wire   [9:0] imgInput_cols_c_dout;
wire    imgInput_cols_c_empty_n;
wire    imgInput_data_full_n;
wire   [7:0] imgInput_data_dout;
wire    imgInput_data_empty_n;
wire    imgInput_rows_c7_full_n;
wire   [5:0] imgInput_rows_c7_dout;
wire    imgInput_rows_c7_empty_n;
wire    imgInput_cols_c8_full_n;
wire   [9:0] imgInput_cols_c8_dout;
wire    imgInput_cols_c8_empty_n;
wire    ap_sync_done;
wire    ap_sync_ready;
reg    ap_sync_reg_Block_split1_proc_U0_ap_ready;
wire    ap_sync_Block_split1_proc_U0_ap_ready;
reg    ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready;
wire    ap_sync_Array2xfMat_8_0_480_640_1_U0_ap_ready;
wire    Block_split1_proc_U0_start_full_n;
wire    Block_split1_proc_U0_start_write;
wire   [0:0] start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_din;
wire    start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_full_n;
wire   [0:0] start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_dout;
wire    start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_empty_n;
wire    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_start_full_n;
wire    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_start_write;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_sync_reg_Block_split1_proc_U0_ap_ready = 1'b0;
#0 ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready = 1'b0;
end

houghlines_accel_BUS_A_s_axi #(
    .C_S_AXI_ADDR_WIDTH( C_S_AXI_BUS_A_ADDR_WIDTH ),
    .C_S_AXI_DATA_WIDTH( C_S_AXI_BUS_A_DATA_WIDTH ))
BUS_A_s_axi_U(
    .AWVALID(s_axi_BUS_A_AWVALID),
    .AWREADY(s_axi_BUS_A_AWREADY),
    .AWADDR(s_axi_BUS_A_AWADDR),
    .WVALID(s_axi_BUS_A_WVALID),
    .WREADY(s_axi_BUS_A_WREADY),
    .WDATA(s_axi_BUS_A_WDATA),
    .WSTRB(s_axi_BUS_A_WSTRB),
    .ARVALID(s_axi_BUS_A_ARVALID),
    .ARREADY(s_axi_BUS_A_ARREADY),
    .ARADDR(s_axi_BUS_A_ARADDR),
    .RVALID(s_axi_BUS_A_RVALID),
    .RREADY(s_axi_BUS_A_RREADY),
    .RDATA(s_axi_BUS_A_RDATA),
    .RRESP(s_axi_BUS_A_RRESP),
    .BVALID(s_axi_BUS_A_BVALID),
    .BREADY(s_axi_BUS_A_BREADY),
    .BRESP(s_axi_BUS_A_BRESP),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .theta_array(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array),
    .theta_array_ap_vld(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_ap_vld),
    .img_in_address0(Array2xfMat_8_0_480_640_1_U0_img_in_address0),
    .img_in_ce0(Array2xfMat_8_0_480_640_1_U0_img_in_ce0),
    .img_in_q0(img_in_q0),
    .ap_start(ap_start),
    .interrupt(interrupt),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_idle(ap_idle)
);

houghlines_accel_Block_split1_proc Block_split1_proc_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(Block_split1_proc_U0_ap_start),
    .ap_done(Block_split1_proc_U0_ap_done),
    .ap_continue(Block_split1_proc_U0_ap_continue),
    .ap_idle(Block_split1_proc_U0_ap_idle),
    .ap_ready(Block_split1_proc_U0_ap_ready),
    .imgInput_rows_out_din(Block_split1_proc_U0_imgInput_rows_out_din),
    .imgInput_rows_out_full_n(imgInput_rows_c_full_n),
    .imgInput_rows_out_write(Block_split1_proc_U0_imgInput_rows_out_write),
    .imgInput_cols_out_din(Block_split1_proc_U0_imgInput_cols_out_din),
    .imgInput_cols_out_full_n(imgInput_cols_c_full_n),
    .imgInput_cols_out_write(Block_split1_proc_U0_imgInput_cols_out_write)
);

houghlines_accel_Array2xfMat_8_0_480_640_1_s Array2xfMat_8_0_480_640_1_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(Array2xfMat_8_0_480_640_1_U0_ap_start),
    .start_full_n(start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_full_n),
    .ap_done(Array2xfMat_8_0_480_640_1_U0_ap_done),
    .ap_continue(Array2xfMat_8_0_480_640_1_U0_ap_continue),
    .ap_idle(Array2xfMat_8_0_480_640_1_U0_ap_idle),
    .ap_ready(Array2xfMat_8_0_480_640_1_U0_ap_ready),
    .start_out(Array2xfMat_8_0_480_640_1_U0_start_out),
    .start_write(Array2xfMat_8_0_480_640_1_U0_start_write),
    .img_in_address0(Array2xfMat_8_0_480_640_1_U0_img_in_address0),
    .img_in_ce0(Array2xfMat_8_0_480_640_1_U0_img_in_ce0),
    .img_in_q0(img_in_q0),
    .imgInput_44_din(Array2xfMat_8_0_480_640_1_U0_imgInput_44_din),
    .imgInput_44_full_n(imgInput_data_full_n),
    .imgInput_44_write(Array2xfMat_8_0_480_640_1_U0_imgInput_44_write),
    .dstMat_rows_dout(imgInput_rows_c_dout),
    .dstMat_rows_empty_n(imgInput_rows_c_empty_n),
    .dstMat_rows_read(Array2xfMat_8_0_480_640_1_U0_dstMat_rows_read),
    .dstMat_cols_dout(imgInput_cols_c_dout),
    .dstMat_cols_empty_n(imgInput_cols_c_empty_n),
    .dstMat_cols_read(Array2xfMat_8_0_480_640_1_U0_dstMat_cols_read),
    .dstMat_rows_out_din(Array2xfMat_8_0_480_640_1_U0_dstMat_rows_out_din),
    .dstMat_rows_out_full_n(imgInput_rows_c7_full_n),
    .dstMat_rows_out_write(Array2xfMat_8_0_480_640_1_U0_dstMat_rows_out_write),
    .dstMat_cols_out_din(Array2xfMat_8_0_480_640_1_U0_dstMat_cols_out_din),
    .dstMat_cols_out_full_n(imgInput_cols_c8_full_n),
    .dstMat_cols_out_write(Array2xfMat_8_0_480_640_1_U0_dstMat_cols_out_write)
);

houghlines_accel_HoughLines_1u_2u_32_800_0_180_0_480_640_1_s HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_start),
    .ap_done(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_done),
    .ap_continue(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_continue),
    .ap_idle(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_idle),
    .ap_ready(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_ready),
    .imgInput_44_dout(imgInput_data_dout),
    .imgInput_44_empty_n(imgInput_data_empty_n),
    .imgInput_44_read(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_imgInput_44_read),
    .theta_array(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array),
    .theta_array_ap_vld(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_ap_vld),
    .p_src_mat_rows_dout(imgInput_rows_c7_dout),
    .p_src_mat_rows_empty_n(imgInput_rows_c7_empty_n),
    .p_src_mat_rows_read(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_p_src_mat_rows_read),
    .p_src_mat_cols_dout(imgInput_cols_c8_dout),
    .p_src_mat_cols_empty_n(imgInput_cols_c8_empty_n),
    .p_src_mat_cols_read(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_p_src_mat_cols_read)
);

houghlines_accel_fifo_w6_d2_S_x imgInput_rows_c_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Block_split1_proc_U0_imgInput_rows_out_din),
    .if_full_n(imgInput_rows_c_full_n),
    .if_write(Block_split1_proc_U0_imgInput_rows_out_write),
    .if_dout(imgInput_rows_c_dout),
    .if_empty_n(imgInput_rows_c_empty_n),
    .if_read(Array2xfMat_8_0_480_640_1_U0_dstMat_rows_read)
);

houghlines_accel_fifo_w10_d2_S_x imgInput_cols_c_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Block_split1_proc_U0_imgInput_cols_out_din),
    .if_full_n(imgInput_cols_c_full_n),
    .if_write(Block_split1_proc_U0_imgInput_cols_out_write),
    .if_dout(imgInput_cols_c_dout),
    .if_empty_n(imgInput_cols_c_empty_n),
    .if_read(Array2xfMat_8_0_480_640_1_U0_dstMat_cols_read)
);

houghlines_accel_fifo_w8_d2_S_x imgInput_data_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Array2xfMat_8_0_480_640_1_U0_imgInput_44_din),
    .if_full_n(imgInput_data_full_n),
    .if_write(Array2xfMat_8_0_480_640_1_U0_imgInput_44_write),
    .if_dout(imgInput_data_dout),
    .if_empty_n(imgInput_data_empty_n),
    .if_read(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_imgInput_44_read)
);

houghlines_accel_fifo_w6_d2_S_x imgInput_rows_c7_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Array2xfMat_8_0_480_640_1_U0_dstMat_rows_out_din),
    .if_full_n(imgInput_rows_c7_full_n),
    .if_write(Array2xfMat_8_0_480_640_1_U0_dstMat_rows_out_write),
    .if_dout(imgInput_rows_c7_dout),
    .if_empty_n(imgInput_rows_c7_empty_n),
    .if_read(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_p_src_mat_rows_read)
);

houghlines_accel_fifo_w10_d2_S_x imgInput_cols_c8_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Array2xfMat_8_0_480_640_1_U0_dstMat_cols_out_din),
    .if_full_n(imgInput_cols_c8_full_n),
    .if_write(Array2xfMat_8_0_480_640_1_U0_dstMat_cols_out_write),
    .if_dout(imgInput_cols_c8_dout),
    .if_empty_n(imgInput_cols_c8_empty_n),
    .if_read(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_p_src_mat_cols_read)
);

houghlines_accel_start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0 start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_din),
    .if_full_n(start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_full_n),
    .if_write(Array2xfMat_8_0_480_640_1_U0_start_write),
    .if_dout(start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_dout),
    .if_empty_n(start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_empty_n),
    .if_read(HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_ready)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready <= 1'b0;
    end else begin
        if (((ap_sync_ready & ap_start) == 1'b1)) begin
            ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready <= 1'b0;
        end else begin
            ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready <= ap_sync_Array2xfMat_8_0_480_640_1_U0_ap_ready;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_sync_reg_Block_split1_proc_U0_ap_ready <= 1'b0;
    end else begin
        if (((ap_sync_ready & ap_start) == 1'b1)) begin
            ap_sync_reg_Block_split1_proc_U0_ap_ready <= 1'b0;
        end else begin
            ap_sync_reg_Block_split1_proc_U0_ap_ready <= ap_sync_Block_split1_proc_U0_ap_ready;
        end
    end
end

assign Array2xfMat_8_0_480_640_1_U0_ap_continue = 1'b1;

assign Array2xfMat_8_0_480_640_1_U0_ap_start = ((ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready ^ 1'b1) & ap_start);

assign Block_split1_proc_U0_ap_continue = 1'b1;

assign Block_split1_proc_U0_ap_start = ((ap_sync_reg_Block_split1_proc_U0_ap_ready ^ 1'b1) & ap_start);

assign Block_split1_proc_U0_start_full_n = 1'b1;

assign Block_split1_proc_U0_start_write = 1'b0;

assign HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_continue = 1'b1;

assign HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_start = start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_empty_n;

assign HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_start_full_n = 1'b1;

assign HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_start_write = 1'b0;

assign ap_done = HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_done;

assign ap_idle = (HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_idle & Block_split1_proc_U0_ap_idle & Array2xfMat_8_0_480_640_1_U0_ap_idle);

assign ap_ready = ap_sync_ready;

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign ap_sync_Array2xfMat_8_0_480_640_1_U0_ap_ready = (ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready | Array2xfMat_8_0_480_640_1_U0_ap_ready);

assign ap_sync_Block_split1_proc_U0_ap_ready = (ap_sync_reg_Block_split1_proc_U0_ap_ready | Block_split1_proc_U0_ap_ready);

assign ap_sync_continue = 1'b1;

assign ap_sync_done = HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_done;

assign ap_sync_ready = (ap_sync_Block_split1_proc_U0_ap_ready & ap_sync_Array2xfMat_8_0_480_640_1_U0_ap_ready);

assign start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_din = 1'b1;


// synthesis translate_off
`include "houghlines_accel_hls_deadlock_detector.vh"
// synthesis translate_on

endmodule //houghlines_accel

