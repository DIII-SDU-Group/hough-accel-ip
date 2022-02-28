// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module houghlines_accel_Axi2Mat (
        p_read,
        imgInput_44_din,
        imgInput_44_full_n,
        imgInput_44_write,
        rows,
        cols,
        ap_clk,
        ap_rst,
        p_read_ap_vld,
        rows_ap_vld,
        cols_ap_vld,
        ap_start,
        ap_done,
        ap_ready,
        ap_idle,
        ap_continue
);


input  [7:0] p_read;
output  [7:0] imgInput_44_din;
input   imgInput_44_full_n;
output   imgInput_44_write;
input  [5:0] rows;
input  [9:0] cols;
input   ap_clk;
input   ap_rst;
input   p_read_ap_vld;
input   rows_ap_vld;
input   cols_ap_vld;
input   ap_start;
output   ap_done;
output   ap_ready;
output   ap_idle;
input   ap_continue;

wire    Axi2Mat_entry3_U0_ap_start;
wire    Axi2Mat_entry3_U0_ap_done;
wire    Axi2Mat_entry3_U0_ap_continue;
wire    Axi2Mat_entry3_U0_ap_idle;
wire    Axi2Mat_entry3_U0_ap_ready;
wire    Axi2Mat_entry3_U0_start_out;
wire    Axi2Mat_entry3_U0_start_write;
wire   [7:0] Axi2Mat_entry3_U0_p_read_out_din;
wire    Axi2Mat_entry3_U0_p_read_out_write;
wire   [5:0] Axi2Mat_entry3_U0_rows_out_din;
wire    Axi2Mat_entry3_U0_rows_out_write;
wire   [9:0] Axi2Mat_entry3_U0_cols_out_din;
wire    Axi2Mat_entry3_U0_cols_out_write;
wire    Axi2Mat_entry21_U0_ap_start;
wire    Axi2Mat_entry21_U0_ap_done;
wire    Axi2Mat_entry21_U0_ap_continue;
wire    Axi2Mat_entry21_U0_ap_idle;
wire    Axi2Mat_entry21_U0_ap_ready;
wire    Axi2Mat_entry21_U0_start_out;
wire    Axi2Mat_entry21_U0_start_write;
wire    Axi2Mat_entry21_U0_p_read_read;
wire    Axi2Mat_entry21_U0_rows_read;
wire    Axi2Mat_entry21_U0_cols_read;
wire   [7:0] Axi2Mat_entry21_U0_img_in_out_din;
wire    Axi2Mat_entry21_U0_img_in_out_write;
wire   [5:0] Axi2Mat_entry21_U0_rows_out_din;
wire    Axi2Mat_entry21_U0_rows_out_write;
wire   [9:0] Axi2Mat_entry21_U0_cols_out_din;
wire    Axi2Mat_entry21_U0_cols_out_write;
wire    last_blk_pxl_width_U0_ap_start;
wire    last_blk_pxl_width_U0_ap_done;
wire    last_blk_pxl_width_U0_ap_continue;
wire    last_blk_pxl_width_U0_ap_idle;
wire    last_blk_pxl_width_U0_ap_ready;
wire    last_blk_pxl_width_U0_start_out;
wire    last_blk_pxl_width_U0_start_write;
wire   [3:0] last_blk_pxl_width_U0_ret_out_din;
wire    last_blk_pxl_width_U0_ret_out_write;
wire    addrbound_U0_ap_start;
wire    addrbound_U0_ap_done;
wire    addrbound_U0_ap_continue;
wire    addrbound_U0_ap_idle;
wire    addrbound_U0_ap_ready;
wire   [18:0] addrbound_U0_return_r;
wire    addrbound_U0_return_r_ap_vld;
wire    addrbound_U0_rows_read;
wire    addrbound_U0_cols_read;
wire   [5:0] addrbound_U0_rows_out_din;
wire    addrbound_U0_rows_out_write;
wire   [9:0] addrbound_U0_cols_out_din;
wire    addrbound_U0_cols_out_write;
wire    ap_channel_done_p_channel;
wire    p_channel_full_n;
wire    Axi2Mat_Block_split15_proc_U0_ap_start;
wire    Axi2Mat_Block_split15_proc_U0_ap_done;
wire    Axi2Mat_Block_split15_proc_U0_ap_continue;
wire    Axi2Mat_Block_split15_proc_U0_ap_idle;
wire    Axi2Mat_Block_split15_proc_U0_ap_ready;
wire   [18:0] Axi2Mat_Block_split15_proc_U0_ap_return;
wire    ap_channel_done_axibound_V;
wire    axibound_V_full_n;
wire    Axi2AxiStream_U0_ap_start;
wire    Axi2AxiStream_U0_ap_done;
wire    Axi2AxiStream_U0_ap_continue;
wire    Axi2AxiStream_U0_ap_idle;
wire    Axi2AxiStream_U0_ap_ready;
wire    Axi2AxiStream_U0_img_in_read;
wire   [7:0] Axi2AxiStream_U0_ldata1_din;
wire    Axi2AxiStream_U0_ldata1_write;
wire    AxiStream2MatStream_U0_ap_start;
wire    AxiStream2MatStream_U0_ap_done;
wire    AxiStream2MatStream_U0_ap_continue;
wire    AxiStream2MatStream_U0_ap_idle;
wire    AxiStream2MatStream_U0_ap_ready;
wire    AxiStream2MatStream_U0_ldata1_read;
wire   [7:0] AxiStream2MatStream_U0_imgInput_44_din;
wire    AxiStream2MatStream_U0_imgInput_44_write;
wire    AxiStream2MatStream_U0_rows_read;
wire    AxiStream2MatStream_U0_cols_bound_per_npc_read;
wire    AxiStream2MatStream_U0_last_blk_width_read;
wire    ap_sync_continue;
wire    p_read_c_full_n;
wire   [7:0] p_read_c_dout;
wire    p_read_c_empty_n;
wire    rows_c1_full_n;
wire   [5:0] rows_c1_dout;
wire    rows_c1_empty_n;
wire    cols_c2_full_n;
wire   [9:0] cols_c2_dout;
wire    cols_c2_empty_n;
wire    img_in_c_full_n;
wire   [7:0] img_in_c_dout;
wire    img_in_c_empty_n;
wire    rows_c_full_n;
wire   [5:0] rows_c_dout;
wire    rows_c_empty_n;
wire    cols_c_full_n;
wire   [9:0] cols_c_dout;
wire    cols_c_empty_n;
wire    last_blk_width_c_full_n;
wire   [3:0] last_blk_width_c_dout;
wire    last_blk_width_c_empty_n;
wire   [18:0] p_channel_dout;
wire    p_channel_empty_n;
wire    rows_c13_full_n;
wire   [5:0] rows_c13_dout;
wire    rows_c13_empty_n;
wire    cols_c14_full_n;
wire   [9:0] cols_c14_dout;
wire    cols_c14_empty_n;
wire   [18:0] axibound_V_dout;
wire    axibound_V_empty_n;
wire    ldata_full_n;
wire   [7:0] ldata_dout;
wire    ldata_empty_n;
wire    ap_sync_done;
wire    ap_sync_ready;
reg    ap_sync_reg_Axi2Mat_entry3_U0_ap_ready;
wire    ap_sync_Axi2Mat_entry3_U0_ap_ready;
reg    ap_sync_reg_last_blk_pxl_width_U0_ap_ready;
wire    ap_sync_last_blk_pxl_width_U0_ap_ready;
wire   [0:0] start_for_Axi2Mat_entry21_U0_din;
wire    start_for_Axi2Mat_entry21_U0_full_n;
wire   [0:0] start_for_Axi2Mat_entry21_U0_dout;
wire    start_for_Axi2Mat_entry21_U0_empty_n;
wire   [0:0] start_for_addrbound_U0_din;
wire    start_for_addrbound_U0_full_n;
wire   [0:0] start_for_addrbound_U0_dout;
wire    start_for_addrbound_U0_empty_n;
wire   [0:0] start_for_AxiStream2MatStream_U0_din;
wire    start_for_AxiStream2MatStream_U0_full_n;
wire   [0:0] start_for_AxiStream2MatStream_U0_dout;
wire    start_for_AxiStream2MatStream_U0_empty_n;
wire    addrbound_U0_start_full_n;
wire    addrbound_U0_start_write;
wire    Axi2Mat_Block_split15_proc_U0_start_full_n;
wire    Axi2Mat_Block_split15_proc_U0_start_write;
wire    Axi2AxiStream_U0_start_full_n;
wire    Axi2AxiStream_U0_start_write;
wire    AxiStream2MatStream_U0_start_full_n;
wire    AxiStream2MatStream_U0_start_write;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_sync_reg_Axi2Mat_entry3_U0_ap_ready = 1'b0;
#0 ap_sync_reg_last_blk_pxl_width_U0_ap_ready = 1'b0;
end

houghlines_accel_Axi2Mat_entry3 Axi2Mat_entry3_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(Axi2Mat_entry3_U0_ap_start),
    .start_full_n(start_for_Axi2Mat_entry21_U0_full_n),
    .ap_done(Axi2Mat_entry3_U0_ap_done),
    .ap_continue(Axi2Mat_entry3_U0_ap_continue),
    .ap_idle(Axi2Mat_entry3_U0_ap_idle),
    .ap_ready(Axi2Mat_entry3_U0_ap_ready),
    .start_out(Axi2Mat_entry3_U0_start_out),
    .start_write(Axi2Mat_entry3_U0_start_write),
    .p_read(p_read),
    .rows(rows),
    .cols(cols),
    .p_read_out_din(Axi2Mat_entry3_U0_p_read_out_din),
    .p_read_out_full_n(p_read_c_full_n),
    .p_read_out_write(Axi2Mat_entry3_U0_p_read_out_write),
    .rows_out_din(Axi2Mat_entry3_U0_rows_out_din),
    .rows_out_full_n(rows_c1_full_n),
    .rows_out_write(Axi2Mat_entry3_U0_rows_out_write),
    .cols_out_din(Axi2Mat_entry3_U0_cols_out_din),
    .cols_out_full_n(cols_c2_full_n),
    .cols_out_write(Axi2Mat_entry3_U0_cols_out_write)
);

houghlines_accel_Axi2Mat_entry21 Axi2Mat_entry21_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(Axi2Mat_entry21_U0_ap_start),
    .start_full_n(start_for_addrbound_U0_full_n),
    .ap_done(Axi2Mat_entry21_U0_ap_done),
    .ap_continue(Axi2Mat_entry21_U0_ap_continue),
    .ap_idle(Axi2Mat_entry21_U0_ap_idle),
    .ap_ready(Axi2Mat_entry21_U0_ap_ready),
    .start_out(Axi2Mat_entry21_U0_start_out),
    .start_write(Axi2Mat_entry21_U0_start_write),
    .p_read_dout(p_read_c_dout),
    .p_read_empty_n(p_read_c_empty_n),
    .p_read_read(Axi2Mat_entry21_U0_p_read_read),
    .rows_dout(rows_c1_dout),
    .rows_empty_n(rows_c1_empty_n),
    .rows_read(Axi2Mat_entry21_U0_rows_read),
    .cols_dout(cols_c2_dout),
    .cols_empty_n(cols_c2_empty_n),
    .cols_read(Axi2Mat_entry21_U0_cols_read),
    .img_in_out_din(Axi2Mat_entry21_U0_img_in_out_din),
    .img_in_out_full_n(img_in_c_full_n),
    .img_in_out_write(Axi2Mat_entry21_U0_img_in_out_write),
    .rows_out_din(Axi2Mat_entry21_U0_rows_out_din),
    .rows_out_full_n(rows_c_full_n),
    .rows_out_write(Axi2Mat_entry21_U0_rows_out_write),
    .cols_out_din(Axi2Mat_entry21_U0_cols_out_din),
    .cols_out_full_n(cols_c_full_n),
    .cols_out_write(Axi2Mat_entry21_U0_cols_out_write)
);

houghlines_accel_last_blk_pxl_width last_blk_pxl_width_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(last_blk_pxl_width_U0_ap_start),
    .start_full_n(start_for_AxiStream2MatStream_U0_full_n),
    .ap_done(last_blk_pxl_width_U0_ap_done),
    .ap_continue(last_blk_pxl_width_U0_ap_continue),
    .ap_idle(last_blk_pxl_width_U0_ap_idle),
    .ap_ready(last_blk_pxl_width_U0_ap_ready),
    .start_out(last_blk_pxl_width_U0_start_out),
    .start_write(last_blk_pxl_width_U0_start_write),
    .ret_out_din(last_blk_pxl_width_U0_ret_out_din),
    .ret_out_full_n(last_blk_width_c_full_n),
    .ret_out_write(last_blk_pxl_width_U0_ret_out_write)
);

houghlines_accel_addrbound addrbound_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(addrbound_U0_ap_start),
    .ap_done(addrbound_U0_ap_done),
    .ap_continue(addrbound_U0_ap_continue),
    .ap_idle(addrbound_U0_ap_idle),
    .ap_ready(addrbound_U0_ap_ready),
    .return_r(addrbound_U0_return_r),
    .return_r_ap_vld(addrbound_U0_return_r_ap_vld),
    .rows_dout(rows_c_dout),
    .rows_empty_n(rows_c_empty_n),
    .rows_read(addrbound_U0_rows_read),
    .cols_dout(cols_c_dout),
    .cols_empty_n(cols_c_empty_n),
    .cols_read(addrbound_U0_cols_read),
    .rows_out_din(addrbound_U0_rows_out_din),
    .rows_out_full_n(rows_c13_full_n),
    .rows_out_write(addrbound_U0_rows_out_write),
    .cols_out_din(addrbound_U0_cols_out_din),
    .cols_out_full_n(cols_c14_full_n),
    .cols_out_write(addrbound_U0_cols_out_write)
);

houghlines_accel_Axi2Mat_Block_split15_proc Axi2Mat_Block_split15_proc_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(Axi2Mat_Block_split15_proc_U0_ap_start),
    .ap_done(Axi2Mat_Block_split15_proc_U0_ap_done),
    .ap_continue(Axi2Mat_Block_split15_proc_U0_ap_continue),
    .ap_idle(Axi2Mat_Block_split15_proc_U0_ap_idle),
    .ap_ready(Axi2Mat_Block_split15_proc_U0_ap_ready),
    .axibound_V_1(p_channel_dout),
    .ap_return(Axi2Mat_Block_split15_proc_U0_ap_return)
);

houghlines_accel_Axi2AxiStream Axi2AxiStream_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(Axi2AxiStream_U0_ap_start),
    .ap_done(Axi2AxiStream_U0_ap_done),
    .ap_continue(Axi2AxiStream_U0_ap_continue),
    .ap_idle(Axi2AxiStream_U0_ap_idle),
    .ap_ready(Axi2AxiStream_U0_ap_ready),
    .img_in_dout(img_in_c_dout),
    .img_in_empty_n(img_in_c_empty_n),
    .img_in_read(Axi2AxiStream_U0_img_in_read),
    .ldata1_din(Axi2AxiStream_U0_ldata1_din),
    .ldata1_full_n(ldata_full_n),
    .ldata1_write(Axi2AxiStream_U0_ldata1_write),
    .addrbound_V_read(axibound_V_dout)
);

houghlines_accel_AxiStream2MatStream AxiStream2MatStream_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(AxiStream2MatStream_U0_ap_start),
    .ap_done(AxiStream2MatStream_U0_ap_done),
    .ap_continue(AxiStream2MatStream_U0_ap_continue),
    .ap_idle(AxiStream2MatStream_U0_ap_idle),
    .ap_ready(AxiStream2MatStream_U0_ap_ready),
    .ldata1_dout(ldata_dout),
    .ldata1_empty_n(ldata_empty_n),
    .ldata1_read(AxiStream2MatStream_U0_ldata1_read),
    .imgInput_44_din(AxiStream2MatStream_U0_imgInput_44_din),
    .imgInput_44_full_n(imgInput_44_full_n),
    .imgInput_44_write(AxiStream2MatStream_U0_imgInput_44_write),
    .rows_dout(rows_c13_dout),
    .rows_empty_n(rows_c13_empty_n),
    .rows_read(AxiStream2MatStream_U0_rows_read),
    .cols_bound_per_npc_dout(cols_c14_dout),
    .cols_bound_per_npc_empty_n(cols_c14_empty_n),
    .cols_bound_per_npc_read(AxiStream2MatStream_U0_cols_bound_per_npc_read),
    .last_blk_width_dout(last_blk_width_c_dout),
    .last_blk_width_empty_n(last_blk_width_c_empty_n),
    .last_blk_width_read(AxiStream2MatStream_U0_last_blk_width_read)
);

houghlines_accel_fifo_w8_d2_S p_read_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2Mat_entry3_U0_p_read_out_din),
    .if_full_n(p_read_c_full_n),
    .if_write(Axi2Mat_entry3_U0_p_read_out_write),
    .if_dout(p_read_c_dout),
    .if_empty_n(p_read_c_empty_n),
    .if_read(Axi2Mat_entry21_U0_p_read_read)
);

houghlines_accel_fifo_w6_d2_S rows_c1_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2Mat_entry3_U0_rows_out_din),
    .if_full_n(rows_c1_full_n),
    .if_write(Axi2Mat_entry3_U0_rows_out_write),
    .if_dout(rows_c1_dout),
    .if_empty_n(rows_c1_empty_n),
    .if_read(Axi2Mat_entry21_U0_rows_read)
);

houghlines_accel_fifo_w10_d2_S cols_c2_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2Mat_entry3_U0_cols_out_din),
    .if_full_n(cols_c2_full_n),
    .if_write(Axi2Mat_entry3_U0_cols_out_write),
    .if_dout(cols_c2_dout),
    .if_empty_n(cols_c2_empty_n),
    .if_read(Axi2Mat_entry21_U0_cols_read)
);

houghlines_accel_fifo_w8_d4_S img_in_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2Mat_entry21_U0_img_in_out_din),
    .if_full_n(img_in_c_full_n),
    .if_write(Axi2Mat_entry21_U0_img_in_out_write),
    .if_dout(img_in_c_dout),
    .if_empty_n(img_in_c_empty_n),
    .if_read(Axi2AxiStream_U0_img_in_read)
);

houghlines_accel_fifo_w6_d2_S rows_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2Mat_entry21_U0_rows_out_din),
    .if_full_n(rows_c_full_n),
    .if_write(Axi2Mat_entry21_U0_rows_out_write),
    .if_dout(rows_c_dout),
    .if_empty_n(rows_c_empty_n),
    .if_read(addrbound_U0_rows_read)
);

houghlines_accel_fifo_w10_d2_S cols_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2Mat_entry21_U0_cols_out_din),
    .if_full_n(cols_c_full_n),
    .if_write(Axi2Mat_entry21_U0_cols_out_write),
    .if_dout(cols_c_dout),
    .if_empty_n(cols_c_empty_n),
    .if_read(addrbound_U0_cols_read)
);

houghlines_accel_fifo_w4_d6_S last_blk_width_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(last_blk_pxl_width_U0_ret_out_din),
    .if_full_n(last_blk_width_c_full_n),
    .if_write(last_blk_pxl_width_U0_ret_out_write),
    .if_dout(last_blk_width_c_dout),
    .if_empty_n(last_blk_width_c_empty_n),
    .if_read(AxiStream2MatStream_U0_last_blk_width_read)
);

houghlines_accel_fifo_w19_d2_S p_channel_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(addrbound_U0_return_r),
    .if_full_n(p_channel_full_n),
    .if_write(addrbound_U0_ap_done),
    .if_dout(p_channel_dout),
    .if_empty_n(p_channel_empty_n),
    .if_read(Axi2Mat_Block_split15_proc_U0_ap_ready)
);

houghlines_accel_fifo_w6_d4_S rows_c13_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(addrbound_U0_rows_out_din),
    .if_full_n(rows_c13_full_n),
    .if_write(addrbound_U0_rows_out_write),
    .if_dout(rows_c13_dout),
    .if_empty_n(rows_c13_empty_n),
    .if_read(AxiStream2MatStream_U0_rows_read)
);

houghlines_accel_fifo_w10_d4_S cols_c14_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(addrbound_U0_cols_out_din),
    .if_full_n(cols_c14_full_n),
    .if_write(addrbound_U0_cols_out_write),
    .if_dout(cols_c14_dout),
    .if_empty_n(cols_c14_empty_n),
    .if_read(AxiStream2MatStream_U0_cols_bound_per_npc_read)
);

houghlines_accel_fifo_w19_d2_S axibound_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2Mat_Block_split15_proc_U0_ap_return),
    .if_full_n(axibound_V_full_n),
    .if_write(Axi2Mat_Block_split15_proc_U0_ap_done),
    .if_dout(axibound_V_dout),
    .if_empty_n(axibound_V_empty_n),
    .if_read(Axi2AxiStream_U0_ap_ready)
);

houghlines_accel_fifo_w8_d2_S ldata_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2AxiStream_U0_ldata1_din),
    .if_full_n(ldata_full_n),
    .if_write(Axi2AxiStream_U0_ldata1_write),
    .if_dout(ldata_dout),
    .if_empty_n(ldata_empty_n),
    .if_read(AxiStream2MatStream_U0_ldata1_read)
);

houghlines_accel_start_for_Axi2Mat_entry21_U0 start_for_Axi2Mat_entry21_U0_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(start_for_Axi2Mat_entry21_U0_din),
    .if_full_n(start_for_Axi2Mat_entry21_U0_full_n),
    .if_write(Axi2Mat_entry3_U0_start_write),
    .if_dout(start_for_Axi2Mat_entry21_U0_dout),
    .if_empty_n(start_for_Axi2Mat_entry21_U0_empty_n),
    .if_read(Axi2Mat_entry21_U0_ap_ready)
);

houghlines_accel_start_for_addrbound_U0 start_for_addrbound_U0_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(start_for_addrbound_U0_din),
    .if_full_n(start_for_addrbound_U0_full_n),
    .if_write(Axi2Mat_entry21_U0_start_write),
    .if_dout(start_for_addrbound_U0_dout),
    .if_empty_n(start_for_addrbound_U0_empty_n),
    .if_read(addrbound_U0_ap_ready)
);

houghlines_accel_start_for_AxiStream2MatStream_U0 start_for_AxiStream2MatStream_U0_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(start_for_AxiStream2MatStream_U0_din),
    .if_full_n(start_for_AxiStream2MatStream_U0_full_n),
    .if_write(last_blk_pxl_width_U0_start_write),
    .if_dout(start_for_AxiStream2MatStream_U0_dout),
    .if_empty_n(start_for_AxiStream2MatStream_U0_empty_n),
    .if_read(AxiStream2MatStream_U0_ap_ready)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_sync_reg_Axi2Mat_entry3_U0_ap_ready <= 1'b0;
    end else begin
        if (((ap_sync_ready & ap_start) == 1'b1)) begin
            ap_sync_reg_Axi2Mat_entry3_U0_ap_ready <= 1'b0;
        end else begin
            ap_sync_reg_Axi2Mat_entry3_U0_ap_ready <= ap_sync_Axi2Mat_entry3_U0_ap_ready;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_sync_reg_last_blk_pxl_width_U0_ap_ready <= 1'b0;
    end else begin
        if (((ap_sync_ready & ap_start) == 1'b1)) begin
            ap_sync_reg_last_blk_pxl_width_U0_ap_ready <= 1'b0;
        end else begin
            ap_sync_reg_last_blk_pxl_width_U0_ap_ready <= ap_sync_last_blk_pxl_width_U0_ap_ready;
        end
    end
end

assign Axi2AxiStream_U0_ap_continue = 1'b1;

assign Axi2AxiStream_U0_ap_start = axibound_V_empty_n;

assign Axi2AxiStream_U0_start_full_n = 1'b1;

assign Axi2AxiStream_U0_start_write = 1'b0;

assign Axi2Mat_Block_split15_proc_U0_ap_continue = axibound_V_full_n;

assign Axi2Mat_Block_split15_proc_U0_ap_start = p_channel_empty_n;

assign Axi2Mat_Block_split15_proc_U0_start_full_n = 1'b1;

assign Axi2Mat_Block_split15_proc_U0_start_write = 1'b0;

assign Axi2Mat_entry21_U0_ap_continue = 1'b1;

assign Axi2Mat_entry21_U0_ap_start = start_for_Axi2Mat_entry21_U0_empty_n;

assign Axi2Mat_entry3_U0_ap_continue = 1'b1;

assign Axi2Mat_entry3_U0_ap_start = ((ap_sync_reg_Axi2Mat_entry3_U0_ap_ready ^ 1'b1) & ap_start);

assign AxiStream2MatStream_U0_ap_continue = ap_continue;

assign AxiStream2MatStream_U0_ap_start = start_for_AxiStream2MatStream_U0_empty_n;

assign AxiStream2MatStream_U0_start_full_n = 1'b1;

assign AxiStream2MatStream_U0_start_write = 1'b0;

assign addrbound_U0_ap_continue = p_channel_full_n;

assign addrbound_U0_ap_start = start_for_addrbound_U0_empty_n;

assign addrbound_U0_start_full_n = 1'b1;

assign addrbound_U0_start_write = 1'b0;

assign ap_channel_done_axibound_V = Axi2Mat_Block_split15_proc_U0_ap_done;

assign ap_channel_done_p_channel = addrbound_U0_ap_done;

assign ap_done = AxiStream2MatStream_U0_ap_done;

assign ap_idle = (last_blk_pxl_width_U0_ap_idle & (axibound_V_empty_n ^ 1'b1) & (p_channel_empty_n ^ 1'b1) & addrbound_U0_ap_idle & AxiStream2MatStream_U0_ap_idle & Axi2Mat_entry3_U0_ap_idle & Axi2Mat_entry21_U0_ap_idle & Axi2Mat_Block_split15_proc_U0_ap_idle & Axi2AxiStream_U0_ap_idle);

assign ap_ready = ap_sync_ready;

assign ap_sync_Axi2Mat_entry3_U0_ap_ready = (ap_sync_reg_Axi2Mat_entry3_U0_ap_ready | Axi2Mat_entry3_U0_ap_ready);

assign ap_sync_continue = ap_continue;

assign ap_sync_done = AxiStream2MatStream_U0_ap_done;

assign ap_sync_last_blk_pxl_width_U0_ap_ready = (last_blk_pxl_width_U0_ap_ready | ap_sync_reg_last_blk_pxl_width_U0_ap_ready);

assign ap_sync_ready = (ap_sync_last_blk_pxl_width_U0_ap_ready & ap_sync_Axi2Mat_entry3_U0_ap_ready);

assign imgInput_44_din = AxiStream2MatStream_U0_imgInput_44_din;

assign imgInput_44_write = AxiStream2MatStream_U0_imgInput_44_write;

assign last_blk_pxl_width_U0_ap_continue = 1'b1;

assign last_blk_pxl_width_U0_ap_start = ((ap_sync_reg_last_blk_pxl_width_U0_ap_ready ^ 1'b1) & ap_start);

assign start_for_Axi2Mat_entry21_U0_din = 1'b1;

assign start_for_AxiStream2MatStream_U0_din = 1'b1;

assign start_for_addrbound_U0_din = 1'b1;

endmodule //houghlines_accel_Axi2Mat
