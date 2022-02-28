// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module houghlines_accel_Array2xfMat_8_0_480_640_1_s (
        ap_clk,
        ap_rst,
        ap_start,
        start_full_n,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        start_out,
        start_write,
        img_in_dout,
        img_in_empty_n,
        img_in_read,
        imgInput_44_din,
        imgInput_44_full_n,
        imgInput_44_write,
        dstMat_rows_dout,
        dstMat_rows_empty_n,
        dstMat_rows_read,
        dstMat_cols_dout,
        dstMat_cols_empty_n,
        dstMat_cols_read,
        dstMat_rows_out_din,
        dstMat_rows_out_full_n,
        dstMat_rows_out_write,
        dstMat_cols_out_din,
        dstMat_cols_out_full_n,
        dstMat_cols_out_write
);

parameter    ap_ST_fsm_state1 = 2'd1;
parameter    ap_ST_fsm_state2 = 2'd2;

input   ap_clk;
input   ap_rst;
input   ap_start;
input   start_full_n;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
output   start_out;
output   start_write;
input  [7:0] img_in_dout;
input   img_in_empty_n;
output   img_in_read;
output  [7:0] imgInput_44_din;
input   imgInput_44_full_n;
output   imgInput_44_write;
input  [5:0] dstMat_rows_dout;
input   dstMat_rows_empty_n;
output   dstMat_rows_read;
input  [9:0] dstMat_cols_dout;
input   dstMat_cols_empty_n;
output   dstMat_cols_read;
output  [5:0] dstMat_rows_out_din;
input   dstMat_rows_out_full_n;
output   dstMat_rows_out_write;
output  [9:0] dstMat_cols_out_din;
input   dstMat_cols_out_full_n;
output   dstMat_cols_out_write;

reg ap_done;
reg ap_idle;
reg start_write;
reg img_in_read;
reg imgInput_44_write;
reg dstMat_rows_read;
reg dstMat_cols_read;
reg dstMat_rows_out_write;
reg dstMat_cols_out_write;

reg    real_start;
reg    start_once_reg;
reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    internal_ap_ready;
reg    img_in_blk_n;
reg    dstMat_rows_blk_n;
reg    dstMat_cols_blk_n;
reg    dstMat_rows_out_blk_n;
reg    dstMat_cols_out_blk_n;
reg   [7:0] img_in_read_reg_88;
reg   [5:0] dstMat_rows_read_reg_93;
reg   [9:0] dstMat_cols_read_reg_98;
wire   [7:0] grp_Axi2Mat_fu_76_imgInput_44_din;
wire    grp_Axi2Mat_fu_76_imgInput_44_write;
wire    grp_Axi2Mat_fu_76_ap_start;
wire    grp_Axi2Mat_fu_76_ap_done;
wire    grp_Axi2Mat_fu_76_ap_ready;
wire    grp_Axi2Mat_fu_76_ap_idle;
reg    grp_Axi2Mat_fu_76_ap_continue;
reg    grp_Axi2Mat_fu_76_ap_start_reg;
reg    ap_block_state1_ignore_call12;
wire    ap_CS_fsm_state2;
wire    ap_sync_grp_Axi2Mat_fu_76_ap_ready;
wire    ap_sync_grp_Axi2Mat_fu_76_ap_done;
reg    ap_block_state2_on_subcall_done;
reg    ap_sync_reg_grp_Axi2Mat_fu_76_ap_ready;
reg    ap_sync_reg_grp_Axi2Mat_fu_76_ap_done;
reg    ap_block_state1;
reg   [1:0] ap_NS_fsm;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 start_once_reg = 1'b0;
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 2'd1;
#0 grp_Axi2Mat_fu_76_ap_start_reg = 1'b0;
#0 ap_sync_reg_grp_Axi2Mat_fu_76_ap_ready = 1'b0;
#0 ap_sync_reg_grp_Axi2Mat_fu_76_ap_done = 1'b0;
end

houghlines_accel_Axi2Mat grp_Axi2Mat_fu_76(
    .p_read(img_in_read_reg_88),
    .imgInput_44_din(grp_Axi2Mat_fu_76_imgInput_44_din),
    .imgInput_44_full_n(imgInput_44_full_n),
    .imgInput_44_write(grp_Axi2Mat_fu_76_imgInput_44_write),
    .rows(dstMat_rows_read_reg_93),
    .cols(dstMat_cols_read_reg_98),
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .p_read_ap_vld(1'b1),
    .rows_ap_vld(1'b1),
    .cols_ap_vld(1'b1),
    .ap_start(grp_Axi2Mat_fu_76_ap_start),
    .ap_done(grp_Axi2Mat_fu_76_ap_done),
    .ap_ready(grp_Axi2Mat_fu_76_ap_ready),
    .ap_idle(grp_Axi2Mat_fu_76_ap_idle),
    .ap_continue(grp_Axi2Mat_fu_76_ap_continue)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b1 == ap_CS_fsm_state2) & (1'b0 == ap_block_state2_on_subcall_done))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_sync_reg_grp_Axi2Mat_fu_76_ap_done <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_state2) & (1'b0 == ap_block_state2_on_subcall_done))) begin
            ap_sync_reg_grp_Axi2Mat_fu_76_ap_done <= 1'b0;
        end else if ((grp_Axi2Mat_fu_76_ap_done == 1'b1)) begin
            ap_sync_reg_grp_Axi2Mat_fu_76_ap_done <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_sync_reg_grp_Axi2Mat_fu_76_ap_ready <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_state2) & (1'b0 == ap_block_state2_on_subcall_done))) begin
            ap_sync_reg_grp_Axi2Mat_fu_76_ap_ready <= 1'b0;
        end else if ((grp_Axi2Mat_fu_76_ap_ready == 1'b1)) begin
            ap_sync_reg_grp_Axi2Mat_fu_76_ap_ready <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_Axi2Mat_fu_76_ap_start_reg <= 1'b0;
    end else begin
        if ((((1'b1 == ap_CS_fsm_state2) & (ap_sync_grp_Axi2Mat_fu_76_ap_ready == 1'b0)) | (~((real_start == 1'b0) | (dstMat_cols_out_full_n == 1'b0) | (dstMat_rows_out_full_n == 1'b0) | (dstMat_cols_empty_n == 1'b0) | (dstMat_rows_empty_n == 1'b0) | (img_in_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1)))) begin
            grp_Axi2Mat_fu_76_ap_start_reg <= 1'b1;
        end else if ((grp_Axi2Mat_fu_76_ap_ready == 1'b1)) begin
            grp_Axi2Mat_fu_76_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        start_once_reg <= 1'b0;
    end else begin
        if (((real_start == 1'b1) & (internal_ap_ready == 1'b0))) begin
            start_once_reg <= 1'b1;
        end else if ((internal_ap_ready == 1'b1)) begin
            start_once_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        dstMat_cols_read_reg_98 <= dstMat_cols_dout;
        dstMat_rows_read_reg_93 <= dstMat_rows_dout;
        img_in_read_reg_88 <= img_in_dout;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) & (1'b0 == ap_block_state2_on_subcall_done))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((real_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstMat_cols_blk_n = dstMat_cols_empty_n;
    end else begin
        dstMat_cols_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstMat_cols_out_blk_n = dstMat_cols_out_full_n;
    end else begin
        dstMat_cols_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (dstMat_cols_out_full_n == 1'b0) | (dstMat_rows_out_full_n == 1'b0) | (dstMat_cols_empty_n == 1'b0) | (dstMat_rows_empty_n == 1'b0) | (img_in_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstMat_cols_out_write = 1'b1;
    end else begin
        dstMat_cols_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (dstMat_cols_out_full_n == 1'b0) | (dstMat_rows_out_full_n == 1'b0) | (dstMat_cols_empty_n == 1'b0) | (dstMat_rows_empty_n == 1'b0) | (img_in_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstMat_cols_read = 1'b1;
    end else begin
        dstMat_cols_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstMat_rows_blk_n = dstMat_rows_empty_n;
    end else begin
        dstMat_rows_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstMat_rows_out_blk_n = dstMat_rows_out_full_n;
    end else begin
        dstMat_rows_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (dstMat_cols_out_full_n == 1'b0) | (dstMat_rows_out_full_n == 1'b0) | (dstMat_cols_empty_n == 1'b0) | (dstMat_rows_empty_n == 1'b0) | (img_in_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstMat_rows_out_write = 1'b1;
    end else begin
        dstMat_rows_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (dstMat_cols_out_full_n == 1'b0) | (dstMat_rows_out_full_n == 1'b0) | (dstMat_cols_empty_n == 1'b0) | (dstMat_rows_empty_n == 1'b0) | (img_in_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstMat_rows_read = 1'b1;
    end else begin
        dstMat_rows_read = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) & (1'b0 == ap_block_state2_on_subcall_done))) begin
        grp_Axi2Mat_fu_76_ap_continue = 1'b1;
    end else begin
        grp_Axi2Mat_fu_76_ap_continue = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        imgInput_44_write = grp_Axi2Mat_fu_76_imgInput_44_write;
    end else begin
        imgInput_44_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        img_in_blk_n = img_in_empty_n;
    end else begin
        img_in_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (dstMat_cols_out_full_n == 1'b0) | (dstMat_rows_out_full_n == 1'b0) | (dstMat_cols_empty_n == 1'b0) | (dstMat_rows_empty_n == 1'b0) | (img_in_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        img_in_read = 1'b1;
    end else begin
        img_in_read = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) & (1'b0 == ap_block_state2_on_subcall_done))) begin
        internal_ap_ready = 1'b1;
    end else begin
        internal_ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((start_full_n == 1'b0) & (start_once_reg == 1'b0))) begin
        real_start = 1'b0;
    end else begin
        real_start = ap_start;
    end
end

always @ (*) begin
    if (((real_start == 1'b1) & (start_once_reg == 1'b0))) begin
        start_write = 1'b1;
    end else begin
        start_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((real_start == 1'b0) | (dstMat_cols_out_full_n == 1'b0) | (dstMat_rows_out_full_n == 1'b0) | (dstMat_cols_empty_n == 1'b0) | (dstMat_rows_empty_n == 1'b0) | (img_in_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((1'b1 == ap_CS_fsm_state2) & (1'b0 == ap_block_state2_on_subcall_done))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

always @ (*) begin
    ap_block_state1 = ((real_start == 1'b0) | (dstMat_cols_out_full_n == 1'b0) | (dstMat_rows_out_full_n == 1'b0) | (dstMat_cols_empty_n == 1'b0) | (dstMat_rows_empty_n == 1'b0) | (img_in_empty_n == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state1_ignore_call12 = ((real_start == 1'b0) | (dstMat_cols_out_full_n == 1'b0) | (dstMat_rows_out_full_n == 1'b0) | (dstMat_cols_empty_n == 1'b0) | (dstMat_rows_empty_n == 1'b0) | (img_in_empty_n == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state2_on_subcall_done = ((ap_sync_grp_Axi2Mat_fu_76_ap_ready & ap_sync_grp_Axi2Mat_fu_76_ap_done) == 1'b0);
end

assign ap_ready = internal_ap_ready;

assign ap_sync_grp_Axi2Mat_fu_76_ap_done = (grp_Axi2Mat_fu_76_ap_done | ap_sync_reg_grp_Axi2Mat_fu_76_ap_done);

assign ap_sync_grp_Axi2Mat_fu_76_ap_ready = (grp_Axi2Mat_fu_76_ap_ready | ap_sync_reg_grp_Axi2Mat_fu_76_ap_ready);

assign dstMat_cols_out_din = dstMat_cols_dout;

assign dstMat_rows_out_din = dstMat_rows_dout;

assign grp_Axi2Mat_fu_76_ap_start = grp_Axi2Mat_fu_76_ap_start_reg;

assign imgInput_44_din = grp_Axi2Mat_fu_76_imgInput_44_din;

assign start_out = real_start;

endmodule //houghlines_accel_Array2xfMat_8_0_480_640_1_s
