// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module houghlines_accel_HoughLines_1u_2u_32_800_0_180_0_480_640_1_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        imgInput_44_dout,
        imgInput_44_empty_n,
        imgInput_44_read,
        theta_array_address0,
        theta_array_ce0,
        theta_array_we0,
        theta_array_d0,
        p_src_mat_rows_dout,
        p_src_mat_rows_empty_n,
        p_src_mat_rows_read,
        p_src_mat_cols_dout,
        p_src_mat_cols_empty_n,
        p_src_mat_cols_read
);

parameter    ap_ST_fsm_state1 = 2'd1;
parameter    ap_ST_fsm_state2 = 2'd2;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [7:0] imgInput_44_dout;
input   imgInput_44_empty_n;
output   imgInput_44_read;
output  [4:0] theta_array_address0;
output   theta_array_ce0;
output   theta_array_we0;
output  [31:0] theta_array_d0;
input  [5:0] p_src_mat_rows_dout;
input   p_src_mat_rows_empty_n;
output   p_src_mat_rows_read;
input  [9:0] p_src_mat_cols_dout;
input   p_src_mat_cols_empty_n;
output   p_src_mat_cols_read;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg imgInput_44_read;
reg p_src_mat_rows_read;
reg p_src_mat_cols_read;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    p_src_mat_rows_blk_n;
reg    p_src_mat_cols_blk_n;
reg   [5:0] p_src_mat_rows_read_reg_68;
reg   [9:0] p_src_mat_cols_read_reg_73;
wire    grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_start;
wire    grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_done;
wire    grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_idle;
wire    grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_ready;
wire    grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_imgInput_44_read;
wire   [4:0] grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_theta_array_address0;
wire    grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_theta_array_ce0;
wire    grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_theta_array_we0;
wire   [31:0] grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_theta_array_d0;
reg    grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_start_reg;
reg    ap_block_state1_ignore_call9;
wire    ap_CS_fsm_state2;
reg    ap_block_state1;
reg   [1:0] ap_NS_fsm;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 2'd1;
#0 grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_start_reg = 1'b0;
end

houghlines_accel_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_start),
    .ap_done(grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_done),
    .ap_idle(grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_idle),
    .ap_ready(grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_ready),
    .imgInput_44_dout(imgInput_44_dout),
    .imgInput_44_empty_n(imgInput_44_empty_n),
    .imgInput_44_read(grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_imgInput_44_read),
    .theta_array_address0(grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_theta_array_address0),
    .theta_array_ce0(grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_theta_array_ce0),
    .theta_array_we0(grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_theta_array_we0),
    .theta_array_d0(grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_theta_array_d0),
    .height(p_src_mat_rows_read_reg_68),
    .width(p_src_mat_cols_read_reg_73)
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
        end else if (((grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_start_reg <= 1'b0;
    end else begin
        if ((~((ap_start == 1'b0) | (p_src_mat_cols_empty_n == 1'b0) | (p_src_mat_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
            grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_start_reg <= 1'b1;
        end else if ((grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_ready == 1'b1)) begin
            grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        p_src_mat_cols_read_reg_73 <= p_src_mat_cols_dout;
        p_src_mat_rows_read_reg_68 <= p_src_mat_rows_dout;
    end
end

always @ (*) begin
    if (((grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        imgInput_44_read = grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_imgInput_44_read;
    end else begin
        imgInput_44_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        p_src_mat_cols_blk_n = p_src_mat_cols_empty_n;
    end else begin
        p_src_mat_cols_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (p_src_mat_cols_empty_n == 1'b0) | (p_src_mat_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        p_src_mat_cols_read = 1'b1;
    end else begin
        p_src_mat_cols_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        p_src_mat_rows_blk_n = p_src_mat_rows_empty_n;
    end else begin
        p_src_mat_rows_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (p_src_mat_cols_empty_n == 1'b0) | (p_src_mat_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        p_src_mat_rows_read = 1'b1;
    end else begin
        p_src_mat_rows_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_start == 1'b0) | (p_src_mat_cols_empty_n == 1'b0) | (p_src_mat_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
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
    ap_block_state1 = ((ap_start == 1'b0) | (p_src_mat_cols_empty_n == 1'b0) | (p_src_mat_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state1_ignore_call9 = ((ap_start == 1'b0) | (p_src_mat_cols_empty_n == 1'b0) | (p_src_mat_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1));
end

assign grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_start = grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_ap_start_reg;

assign theta_array_address0 = grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_theta_array_address0;

assign theta_array_ce0 = grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_theta_array_ce0;

assign theta_array_d0 = grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_theta_array_d0;

assign theta_array_we0 = grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56_theta_array_we0;

endmodule //houghlines_accel_HoughLines_1u_2u_32_800_0_180_0_480_640_1_s
