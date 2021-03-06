-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Version: 2020.2
-- Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity houghlines_accel is
generic (
    C_S_AXI_BUS_A_ADDR_WIDTH : INTEGER := 20;
    C_S_AXI_BUS_A_DATA_WIDTH : INTEGER := 32 );
port (
    s_axi_BUS_A_AWVALID : IN STD_LOGIC;
    s_axi_BUS_A_AWREADY : OUT STD_LOGIC;
    s_axi_BUS_A_AWADDR : IN STD_LOGIC_VECTOR (C_S_AXI_BUS_A_ADDR_WIDTH-1 downto 0);
    s_axi_BUS_A_WVALID : IN STD_LOGIC;
    s_axi_BUS_A_WREADY : OUT STD_LOGIC;
    s_axi_BUS_A_WDATA : IN STD_LOGIC_VECTOR (C_S_AXI_BUS_A_DATA_WIDTH-1 downto 0);
    s_axi_BUS_A_WSTRB : IN STD_LOGIC_VECTOR (C_S_AXI_BUS_A_DATA_WIDTH/8-1 downto 0);
    s_axi_BUS_A_ARVALID : IN STD_LOGIC;
    s_axi_BUS_A_ARREADY : OUT STD_LOGIC;
    s_axi_BUS_A_ARADDR : IN STD_LOGIC_VECTOR (C_S_AXI_BUS_A_ADDR_WIDTH-1 downto 0);
    s_axi_BUS_A_RVALID : OUT STD_LOGIC;
    s_axi_BUS_A_RREADY : IN STD_LOGIC;
    s_axi_BUS_A_RDATA : OUT STD_LOGIC_VECTOR (C_S_AXI_BUS_A_DATA_WIDTH-1 downto 0);
    s_axi_BUS_A_RRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
    s_axi_BUS_A_BVALID : OUT STD_LOGIC;
    s_axi_BUS_A_BREADY : IN STD_LOGIC;
    s_axi_BUS_A_BRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    interrupt : OUT STD_LOGIC );
end;


architecture behav of houghlines_accel is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "houghlines_accel_houghlines_accel,hls_ip_2020_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu3eg-sbva484-1-i,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=dataflow,HLS_SYN_CLOCK=6.923278,HLS_SYN_LAT=258910,HLS_SYN_TPT=258909,HLS_SYN_MEM=439,HLS_SYN_DSP=0,HLS_SYN_FF=60600,HLS_SYN_LUT=1839183,HLS_VERSION=2020_2}";
    constant C_S_AXI_DATA_WIDTH : INTEGER range 63 downto 0 := 20;
    constant C_S_AXI_WSTRB_WIDTH : INTEGER range 63 downto 0 := 4;
    constant C_S_AXI_ADDR_WIDTH : INTEGER range 63 downto 0 := 20;
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_const_boolean_1 : BOOLEAN := true;

    signal ap_rst_n_inv : STD_LOGIC;
    signal img_in_q0 : STD_LOGIC_VECTOR (7 downto 0);
    signal ap_start : STD_LOGIC;
    signal ap_ready : STD_LOGIC;
    signal ap_done : STD_LOGIC;
    signal ap_idle : STD_LOGIC;
    signal Block_split1_proc_U0_ap_start : STD_LOGIC;
    signal Block_split1_proc_U0_ap_done : STD_LOGIC;
    signal Block_split1_proc_U0_ap_continue : STD_LOGIC;
    signal Block_split1_proc_U0_ap_idle : STD_LOGIC;
    signal Block_split1_proc_U0_ap_ready : STD_LOGIC;
    signal Block_split1_proc_U0_imgInput_rows_out_din : STD_LOGIC_VECTOR (5 downto 0);
    signal Block_split1_proc_U0_imgInput_rows_out_write : STD_LOGIC;
    signal Block_split1_proc_U0_imgInput_cols_out_din : STD_LOGIC_VECTOR (9 downto 0);
    signal Block_split1_proc_U0_imgInput_cols_out_write : STD_LOGIC;
    signal Array2xfMat_8_0_480_640_1_U0_ap_start : STD_LOGIC;
    signal Array2xfMat_8_0_480_640_1_U0_ap_done : STD_LOGIC;
    signal Array2xfMat_8_0_480_640_1_U0_ap_continue : STD_LOGIC;
    signal Array2xfMat_8_0_480_640_1_U0_ap_idle : STD_LOGIC;
    signal Array2xfMat_8_0_480_640_1_U0_ap_ready : STD_LOGIC;
    signal Array2xfMat_8_0_480_640_1_U0_start_out : STD_LOGIC;
    signal Array2xfMat_8_0_480_640_1_U0_start_write : STD_LOGIC;
    signal Array2xfMat_8_0_480_640_1_U0_img_in_address0 : STD_LOGIC_VECTOR (18 downto 0);
    signal Array2xfMat_8_0_480_640_1_U0_img_in_ce0 : STD_LOGIC;
    signal Array2xfMat_8_0_480_640_1_U0_imgInput_44_din : STD_LOGIC_VECTOR (7 downto 0);
    signal Array2xfMat_8_0_480_640_1_U0_imgInput_44_write : STD_LOGIC;
    signal Array2xfMat_8_0_480_640_1_U0_dstMat_rows_read : STD_LOGIC;
    signal Array2xfMat_8_0_480_640_1_U0_dstMat_cols_read : STD_LOGIC;
    signal Array2xfMat_8_0_480_640_1_U0_dstMat_rows_out_din : STD_LOGIC_VECTOR (5 downto 0);
    signal Array2xfMat_8_0_480_640_1_U0_dstMat_rows_out_write : STD_LOGIC;
    signal Array2xfMat_8_0_480_640_1_U0_dstMat_cols_out_din : STD_LOGIC_VECTOR (9 downto 0);
    signal Array2xfMat_8_0_480_640_1_U0_dstMat_cols_out_write : STD_LOGIC;
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_start : STD_LOGIC;
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_done : STD_LOGIC;
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_continue : STD_LOGIC;
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_idle : STD_LOGIC;
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_ready : STD_LOGIC;
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_imgInput_44_read : STD_LOGIC;
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_address0 : STD_LOGIC_VECTOR (4 downto 0);
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_ce0 : STD_LOGIC;
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_we0 : STD_LOGIC;
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_d0 : STD_LOGIC_VECTOR (31 downto 0);
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_p_src_mat_rows_read : STD_LOGIC;
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_p_src_mat_cols_read : STD_LOGIC;
    signal ap_sync_continue : STD_LOGIC;
    signal imgInput_rows_c_full_n : STD_LOGIC;
    signal imgInput_rows_c_dout : STD_LOGIC_VECTOR (5 downto 0);
    signal imgInput_rows_c_empty_n : STD_LOGIC;
    signal imgInput_cols_c_full_n : STD_LOGIC;
    signal imgInput_cols_c_dout : STD_LOGIC_VECTOR (9 downto 0);
    signal imgInput_cols_c_empty_n : STD_LOGIC;
    signal imgInput_data_full_n : STD_LOGIC;
    signal imgInput_data_dout : STD_LOGIC_VECTOR (7 downto 0);
    signal imgInput_data_empty_n : STD_LOGIC;
    signal imgInput_rows_c7_full_n : STD_LOGIC;
    signal imgInput_rows_c7_dout : STD_LOGIC_VECTOR (5 downto 0);
    signal imgInput_rows_c7_empty_n : STD_LOGIC;
    signal imgInput_cols_c8_full_n : STD_LOGIC;
    signal imgInput_cols_c8_dout : STD_LOGIC_VECTOR (9 downto 0);
    signal imgInput_cols_c8_empty_n : STD_LOGIC;
    signal ap_sync_done : STD_LOGIC;
    signal ap_sync_ready : STD_LOGIC;
    signal ap_sync_reg_Block_split1_proc_U0_ap_ready : STD_LOGIC := '0';
    signal ap_sync_Block_split1_proc_U0_ap_ready : STD_LOGIC;
    signal ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready : STD_LOGIC := '0';
    signal ap_sync_Array2xfMat_8_0_480_640_1_U0_ap_ready : STD_LOGIC;
    signal Block_split1_proc_U0_start_full_n : STD_LOGIC;
    signal Block_split1_proc_U0_start_write : STD_LOGIC;
    signal start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_din : STD_LOGIC_VECTOR (0 downto 0);
    signal start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_full_n : STD_LOGIC;
    signal start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_dout : STD_LOGIC_VECTOR (0 downto 0);
    signal start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_empty_n : STD_LOGIC;
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_start_full_n : STD_LOGIC;
    signal HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_start_write : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component houghlines_accel_Block_split1_proc IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        imgInput_rows_out_din : OUT STD_LOGIC_VECTOR (5 downto 0);
        imgInput_rows_out_full_n : IN STD_LOGIC;
        imgInput_rows_out_write : OUT STD_LOGIC;
        imgInput_cols_out_din : OUT STD_LOGIC_VECTOR (9 downto 0);
        imgInput_cols_out_full_n : IN STD_LOGIC;
        imgInput_cols_out_write : OUT STD_LOGIC );
    end component;


    component houghlines_accel_Array2xfMat_8_0_480_640_1_s IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        start_full_n : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        start_out : OUT STD_LOGIC;
        start_write : OUT STD_LOGIC;
        img_in_address0 : OUT STD_LOGIC_VECTOR (18 downto 0);
        img_in_ce0 : OUT STD_LOGIC;
        img_in_q0 : IN STD_LOGIC_VECTOR (7 downto 0);
        imgInput_44_din : OUT STD_LOGIC_VECTOR (7 downto 0);
        imgInput_44_full_n : IN STD_LOGIC;
        imgInput_44_write : OUT STD_LOGIC;
        dstMat_rows_dout : IN STD_LOGIC_VECTOR (5 downto 0);
        dstMat_rows_empty_n : IN STD_LOGIC;
        dstMat_rows_read : OUT STD_LOGIC;
        dstMat_cols_dout : IN STD_LOGIC_VECTOR (9 downto 0);
        dstMat_cols_empty_n : IN STD_LOGIC;
        dstMat_cols_read : OUT STD_LOGIC;
        dstMat_rows_out_din : OUT STD_LOGIC_VECTOR (5 downto 0);
        dstMat_rows_out_full_n : IN STD_LOGIC;
        dstMat_rows_out_write : OUT STD_LOGIC;
        dstMat_cols_out_din : OUT STD_LOGIC_VECTOR (9 downto 0);
        dstMat_cols_out_full_n : IN STD_LOGIC;
        dstMat_cols_out_write : OUT STD_LOGIC );
    end component;


    component houghlines_accel_HoughLines_1u_2u_32_800_0_180_0_480_640_1_s IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        imgInput_44_dout : IN STD_LOGIC_VECTOR (7 downto 0);
        imgInput_44_empty_n : IN STD_LOGIC;
        imgInput_44_read : OUT STD_LOGIC;
        theta_array_address0 : OUT STD_LOGIC_VECTOR (4 downto 0);
        theta_array_ce0 : OUT STD_LOGIC;
        theta_array_we0 : OUT STD_LOGIC;
        theta_array_d0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        p_src_mat_rows_dout : IN STD_LOGIC_VECTOR (5 downto 0);
        p_src_mat_rows_empty_n : IN STD_LOGIC;
        p_src_mat_rows_read : OUT STD_LOGIC;
        p_src_mat_cols_dout : IN STD_LOGIC_VECTOR (9 downto 0);
        p_src_mat_cols_empty_n : IN STD_LOGIC;
        p_src_mat_cols_read : OUT STD_LOGIC );
    end component;


    component houghlines_accel_fifo_w6_d2_S_x IS
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        if_read_ce : IN STD_LOGIC;
        if_write_ce : IN STD_LOGIC;
        if_din : IN STD_LOGIC_VECTOR (5 downto 0);
        if_full_n : OUT STD_LOGIC;
        if_write : IN STD_LOGIC;
        if_dout : OUT STD_LOGIC_VECTOR (5 downto 0);
        if_empty_n : OUT STD_LOGIC;
        if_read : IN STD_LOGIC );
    end component;


    component houghlines_accel_fifo_w10_d2_S_x IS
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        if_read_ce : IN STD_LOGIC;
        if_write_ce : IN STD_LOGIC;
        if_din : IN STD_LOGIC_VECTOR (9 downto 0);
        if_full_n : OUT STD_LOGIC;
        if_write : IN STD_LOGIC;
        if_dout : OUT STD_LOGIC_VECTOR (9 downto 0);
        if_empty_n : OUT STD_LOGIC;
        if_read : IN STD_LOGIC );
    end component;


    component houghlines_accel_fifo_w8_d2_S_x IS
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        if_read_ce : IN STD_LOGIC;
        if_write_ce : IN STD_LOGIC;
        if_din : IN STD_LOGIC_VECTOR (7 downto 0);
        if_full_n : OUT STD_LOGIC;
        if_write : IN STD_LOGIC;
        if_dout : OUT STD_LOGIC_VECTOR (7 downto 0);
        if_empty_n : OUT STD_LOGIC;
        if_read : IN STD_LOGIC );
    end component;


    component houghlines_accel_start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0 IS
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        if_read_ce : IN STD_LOGIC;
        if_write_ce : IN STD_LOGIC;
        if_din : IN STD_LOGIC_VECTOR (0 downto 0);
        if_full_n : OUT STD_LOGIC;
        if_write : IN STD_LOGIC;
        if_dout : OUT STD_LOGIC_VECTOR (0 downto 0);
        if_empty_n : OUT STD_LOGIC;
        if_read : IN STD_LOGIC );
    end component;


    component houghlines_accel_BUS_A_s_axi IS
    generic (
        C_S_AXI_ADDR_WIDTH : INTEGER;
        C_S_AXI_DATA_WIDTH : INTEGER );
    port (
        AWVALID : IN STD_LOGIC;
        AWREADY : OUT STD_LOGIC;
        AWADDR : IN STD_LOGIC_VECTOR (C_S_AXI_ADDR_WIDTH-1 downto 0);
        WVALID : IN STD_LOGIC;
        WREADY : OUT STD_LOGIC;
        WDATA : IN STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
        WSTRB : IN STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH/8-1 downto 0);
        ARVALID : IN STD_LOGIC;
        ARREADY : OUT STD_LOGIC;
        ARADDR : IN STD_LOGIC_VECTOR (C_S_AXI_ADDR_WIDTH-1 downto 0);
        RVALID : OUT STD_LOGIC;
        RREADY : IN STD_LOGIC;
        RDATA : OUT STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
        RRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        BVALID : OUT STD_LOGIC;
        BREADY : IN STD_LOGIC;
        BRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        ACLK : IN STD_LOGIC;
        ARESET : IN STD_LOGIC;
        ACLK_EN : IN STD_LOGIC;
        theta_array_address0 : IN STD_LOGIC_VECTOR (4 downto 0);
        theta_array_ce0 : IN STD_LOGIC;
        theta_array_we0 : IN STD_LOGIC;
        theta_array_d0 : IN STD_LOGIC_VECTOR (31 downto 0);
        img_in_address0 : IN STD_LOGIC_VECTOR (18 downto 0);
        img_in_ce0 : IN STD_LOGIC;
        img_in_q0 : OUT STD_LOGIC_VECTOR (7 downto 0);
        ap_start : OUT STD_LOGIC;
        interrupt : OUT STD_LOGIC;
        ap_ready : IN STD_LOGIC;
        ap_done : IN STD_LOGIC;
        ap_idle : IN STD_LOGIC );
    end component;



begin
    BUS_A_s_axi_U : component houghlines_accel_BUS_A_s_axi
    generic map (
        C_S_AXI_ADDR_WIDTH => C_S_AXI_BUS_A_ADDR_WIDTH,
        C_S_AXI_DATA_WIDTH => C_S_AXI_BUS_A_DATA_WIDTH)
    port map (
        AWVALID => s_axi_BUS_A_AWVALID,
        AWREADY => s_axi_BUS_A_AWREADY,
        AWADDR => s_axi_BUS_A_AWADDR,
        WVALID => s_axi_BUS_A_WVALID,
        WREADY => s_axi_BUS_A_WREADY,
        WDATA => s_axi_BUS_A_WDATA,
        WSTRB => s_axi_BUS_A_WSTRB,
        ARVALID => s_axi_BUS_A_ARVALID,
        ARREADY => s_axi_BUS_A_ARREADY,
        ARADDR => s_axi_BUS_A_ARADDR,
        RVALID => s_axi_BUS_A_RVALID,
        RREADY => s_axi_BUS_A_RREADY,
        RDATA => s_axi_BUS_A_RDATA,
        RRESP => s_axi_BUS_A_RRESP,
        BVALID => s_axi_BUS_A_BVALID,
        BREADY => s_axi_BUS_A_BREADY,
        BRESP => s_axi_BUS_A_BRESP,
        ACLK => ap_clk,
        ARESET => ap_rst_n_inv,
        ACLK_EN => ap_const_logic_1,
        theta_array_address0 => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_address0,
        theta_array_ce0 => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_ce0,
        theta_array_we0 => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_we0,
        theta_array_d0 => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_d0,
        img_in_address0 => Array2xfMat_8_0_480_640_1_U0_img_in_address0,
        img_in_ce0 => Array2xfMat_8_0_480_640_1_U0_img_in_ce0,
        img_in_q0 => img_in_q0,
        ap_start => ap_start,
        interrupt => interrupt,
        ap_ready => ap_ready,
        ap_done => ap_done,
        ap_idle => ap_idle);

    Block_split1_proc_U0 : component houghlines_accel_Block_split1_proc
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        ap_start => Block_split1_proc_U0_ap_start,
        ap_done => Block_split1_proc_U0_ap_done,
        ap_continue => Block_split1_proc_U0_ap_continue,
        ap_idle => Block_split1_proc_U0_ap_idle,
        ap_ready => Block_split1_proc_U0_ap_ready,
        imgInput_rows_out_din => Block_split1_proc_U0_imgInput_rows_out_din,
        imgInput_rows_out_full_n => imgInput_rows_c_full_n,
        imgInput_rows_out_write => Block_split1_proc_U0_imgInput_rows_out_write,
        imgInput_cols_out_din => Block_split1_proc_U0_imgInput_cols_out_din,
        imgInput_cols_out_full_n => imgInput_cols_c_full_n,
        imgInput_cols_out_write => Block_split1_proc_U0_imgInput_cols_out_write);

    Array2xfMat_8_0_480_640_1_U0 : component houghlines_accel_Array2xfMat_8_0_480_640_1_s
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        ap_start => Array2xfMat_8_0_480_640_1_U0_ap_start,
        start_full_n => start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_full_n,
        ap_done => Array2xfMat_8_0_480_640_1_U0_ap_done,
        ap_continue => Array2xfMat_8_0_480_640_1_U0_ap_continue,
        ap_idle => Array2xfMat_8_0_480_640_1_U0_ap_idle,
        ap_ready => Array2xfMat_8_0_480_640_1_U0_ap_ready,
        start_out => Array2xfMat_8_0_480_640_1_U0_start_out,
        start_write => Array2xfMat_8_0_480_640_1_U0_start_write,
        img_in_address0 => Array2xfMat_8_0_480_640_1_U0_img_in_address0,
        img_in_ce0 => Array2xfMat_8_0_480_640_1_U0_img_in_ce0,
        img_in_q0 => img_in_q0,
        imgInput_44_din => Array2xfMat_8_0_480_640_1_U0_imgInput_44_din,
        imgInput_44_full_n => imgInput_data_full_n,
        imgInput_44_write => Array2xfMat_8_0_480_640_1_U0_imgInput_44_write,
        dstMat_rows_dout => imgInput_rows_c_dout,
        dstMat_rows_empty_n => imgInput_rows_c_empty_n,
        dstMat_rows_read => Array2xfMat_8_0_480_640_1_U0_dstMat_rows_read,
        dstMat_cols_dout => imgInput_cols_c_dout,
        dstMat_cols_empty_n => imgInput_cols_c_empty_n,
        dstMat_cols_read => Array2xfMat_8_0_480_640_1_U0_dstMat_cols_read,
        dstMat_rows_out_din => Array2xfMat_8_0_480_640_1_U0_dstMat_rows_out_din,
        dstMat_rows_out_full_n => imgInput_rows_c7_full_n,
        dstMat_rows_out_write => Array2xfMat_8_0_480_640_1_U0_dstMat_rows_out_write,
        dstMat_cols_out_din => Array2xfMat_8_0_480_640_1_U0_dstMat_cols_out_din,
        dstMat_cols_out_full_n => imgInput_cols_c8_full_n,
        dstMat_cols_out_write => Array2xfMat_8_0_480_640_1_U0_dstMat_cols_out_write);

    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0 : component houghlines_accel_HoughLines_1u_2u_32_800_0_180_0_480_640_1_s
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        ap_start => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_start,
        ap_done => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_done,
        ap_continue => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_continue,
        ap_idle => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_idle,
        ap_ready => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_ready,
        imgInput_44_dout => imgInput_data_dout,
        imgInput_44_empty_n => imgInput_data_empty_n,
        imgInput_44_read => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_imgInput_44_read,
        theta_array_address0 => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_address0,
        theta_array_ce0 => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_ce0,
        theta_array_we0 => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_we0,
        theta_array_d0 => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_theta_array_d0,
        p_src_mat_rows_dout => imgInput_rows_c7_dout,
        p_src_mat_rows_empty_n => imgInput_rows_c7_empty_n,
        p_src_mat_rows_read => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_p_src_mat_rows_read,
        p_src_mat_cols_dout => imgInput_cols_c8_dout,
        p_src_mat_cols_empty_n => imgInput_cols_c8_empty_n,
        p_src_mat_cols_read => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_p_src_mat_cols_read);

    imgInput_rows_c_U : component houghlines_accel_fifo_w6_d2_S_x
    port map (
        clk => ap_clk,
        reset => ap_rst_n_inv,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => Block_split1_proc_U0_imgInput_rows_out_din,
        if_full_n => imgInput_rows_c_full_n,
        if_write => Block_split1_proc_U0_imgInput_rows_out_write,
        if_dout => imgInput_rows_c_dout,
        if_empty_n => imgInput_rows_c_empty_n,
        if_read => Array2xfMat_8_0_480_640_1_U0_dstMat_rows_read);

    imgInput_cols_c_U : component houghlines_accel_fifo_w10_d2_S_x
    port map (
        clk => ap_clk,
        reset => ap_rst_n_inv,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => Block_split1_proc_U0_imgInput_cols_out_din,
        if_full_n => imgInput_cols_c_full_n,
        if_write => Block_split1_proc_U0_imgInput_cols_out_write,
        if_dout => imgInput_cols_c_dout,
        if_empty_n => imgInput_cols_c_empty_n,
        if_read => Array2xfMat_8_0_480_640_1_U0_dstMat_cols_read);

    imgInput_data_U : component houghlines_accel_fifo_w8_d2_S_x
    port map (
        clk => ap_clk,
        reset => ap_rst_n_inv,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => Array2xfMat_8_0_480_640_1_U0_imgInput_44_din,
        if_full_n => imgInput_data_full_n,
        if_write => Array2xfMat_8_0_480_640_1_U0_imgInput_44_write,
        if_dout => imgInput_data_dout,
        if_empty_n => imgInput_data_empty_n,
        if_read => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_imgInput_44_read);

    imgInput_rows_c7_U : component houghlines_accel_fifo_w6_d2_S_x
    port map (
        clk => ap_clk,
        reset => ap_rst_n_inv,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => Array2xfMat_8_0_480_640_1_U0_dstMat_rows_out_din,
        if_full_n => imgInput_rows_c7_full_n,
        if_write => Array2xfMat_8_0_480_640_1_U0_dstMat_rows_out_write,
        if_dout => imgInput_rows_c7_dout,
        if_empty_n => imgInput_rows_c7_empty_n,
        if_read => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_p_src_mat_rows_read);

    imgInput_cols_c8_U : component houghlines_accel_fifo_w10_d2_S_x
    port map (
        clk => ap_clk,
        reset => ap_rst_n_inv,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => Array2xfMat_8_0_480_640_1_U0_dstMat_cols_out_din,
        if_full_n => imgInput_cols_c8_full_n,
        if_write => Array2xfMat_8_0_480_640_1_U0_dstMat_cols_out_write,
        if_dout => imgInput_cols_c8_dout,
        if_empty_n => imgInput_cols_c8_empty_n,
        if_read => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_p_src_mat_cols_read);

    start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_U : component houghlines_accel_start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0
    port map (
        clk => ap_clk,
        reset => ap_rst_n_inv,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_din,
        if_full_n => start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_full_n,
        if_write => Array2xfMat_8_0_480_640_1_U0_start_write,
        if_dout => start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_dout,
        if_empty_n => start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_empty_n,
        if_read => HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_ready);





    ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready <= ap_const_logic_0;
            else
                if (((ap_sync_ready and ap_start) = ap_const_logic_1)) then 
                    ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready <= ap_const_logic_0;
                else 
                    ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready <= ap_sync_Array2xfMat_8_0_480_640_1_U0_ap_ready;
                end if; 
            end if;
        end if;
    end process;


    ap_sync_reg_Block_split1_proc_U0_ap_ready_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_sync_reg_Block_split1_proc_U0_ap_ready <= ap_const_logic_0;
            else
                if (((ap_sync_ready and ap_start) = ap_const_logic_1)) then 
                    ap_sync_reg_Block_split1_proc_U0_ap_ready <= ap_const_logic_0;
                else 
                    ap_sync_reg_Block_split1_proc_U0_ap_ready <= ap_sync_Block_split1_proc_U0_ap_ready;
                end if; 
            end if;
        end if;
    end process;

    Array2xfMat_8_0_480_640_1_U0_ap_continue <= ap_const_logic_1;
    Array2xfMat_8_0_480_640_1_U0_ap_start <= ((ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready xor ap_const_logic_1) and ap_start);
    Block_split1_proc_U0_ap_continue <= ap_const_logic_1;
    Block_split1_proc_U0_ap_start <= ((ap_sync_reg_Block_split1_proc_U0_ap_ready xor ap_const_logic_1) and ap_start);
    Block_split1_proc_U0_start_full_n <= ap_const_logic_1;
    Block_split1_proc_U0_start_write <= ap_const_logic_0;
    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_continue <= ap_const_logic_1;
    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_start <= start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_empty_n;
    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_start_full_n <= ap_const_logic_1;
    HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_start_write <= ap_const_logic_0;
    ap_done <= HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_done;
    ap_idle <= (HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_idle and Block_split1_proc_U0_ap_idle and Array2xfMat_8_0_480_640_1_U0_ap_idle);
    ap_ready <= ap_sync_ready;

    ap_rst_n_inv_assign_proc : process(ap_rst_n)
    begin
                ap_rst_n_inv <= not(ap_rst_n);
    end process;

    ap_sync_Array2xfMat_8_0_480_640_1_U0_ap_ready <= (ap_sync_reg_Array2xfMat_8_0_480_640_1_U0_ap_ready or Array2xfMat_8_0_480_640_1_U0_ap_ready);
    ap_sync_Block_split1_proc_U0_ap_ready <= (ap_sync_reg_Block_split1_proc_U0_ap_ready or Block_split1_proc_U0_ap_ready);
    ap_sync_continue <= ap_const_logic_1;
    ap_sync_done <= HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_ap_done;
    ap_sync_ready <= (ap_sync_Block_split1_proc_U0_ap_ready and ap_sync_Array2xfMat_8_0_480_640_1_U0_ap_ready);
    start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_din <= (0=>ap_const_logic_1, others=>'-');
end behav;
