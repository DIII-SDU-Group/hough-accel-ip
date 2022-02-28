// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1ns/1ps
module houghlines_accel_BUS_A_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 20,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    output wire                          interrupt,
    input  wire [4:0]                    theta_array_address0,
    input  wire                          theta_array_ce0,
    input  wire                          theta_array_we0,
    input  wire [31:0]                   theta_array_d0,
    input  wire [18:0]                   img_in_address0,
    input  wire                          img_in_ce0,
    output wire [7:0]                    img_in_q0,
    output wire                          ap_start,
    input  wire                          ap_done,
    input  wire                          ap_ready,
    input  wire                          ap_idle
);
//------------------------Address Info-------------------
// 0x00000 : Control signals
//           bit 0  - ap_start (Read/Write/COH)
//           bit 1  - ap_done (Read/COR)
//           bit 2  - ap_idle (Read)
//           bit 3  - ap_ready (Read)
//           bit 7  - auto_restart (Read/Write)
//           others - reserved
// 0x00004 : Global Interrupt Enable Register
//           bit 0  - Global Interrupt Enable (Read/Write)
//           others - reserved
// 0x00008 : IP Interrupt Enable Register (Read/Write)
//           bit 0  - enable ap_done interrupt (Read/Write)
//           bit 1  - enable ap_ready interrupt (Read/Write)
//           others - reserved
// 0x0000c : IP Interrupt Status Register (Read/TOW)
//           bit 0  - ap_done (COR/TOW)
//           bit 1  - ap_ready (COR/TOW)
//           others - reserved
// 0x00080 ~
// 0x000ff : Memory 'theta_array' (32 * 32b)
//           Word n : bit [31:0] - theta_array[n]
// 0x80000 ~
// 0xfffff : Memory 'img_in' (307200 * 8b)
//           Word n : bit [ 7: 0] - img_in[4n]
//                    bit [15: 8] - img_in[4n+1]
//                    bit [23:16] - img_in[4n+2]
//                    bit [31:24] - img_in[4n+3]
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

//------------------------Parameter----------------------
localparam
    ADDR_AP_CTRL          = 20'h00000,
    ADDR_GIE              = 20'h00004,
    ADDR_IER              = 20'h00008,
    ADDR_ISR              = 20'h0000c,
    ADDR_THETA_ARRAY_BASE = 20'h00080,
    ADDR_THETA_ARRAY_HIGH = 20'h000ff,
    ADDR_IMG_IN_BASE      = 20'h80000,
    ADDR_IMG_IN_HIGH      = 20'hfffff,
    WRIDLE                = 2'd0,
    WRDATA                = 2'd1,
    WRRESP                = 2'd2,
    WRRESET               = 2'd3,
    RDIDLE                = 2'd0,
    RDDATA                = 2'd1,
    RDRESET               = 2'd2,
    ADDR_BITS                = 20;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [C_S_AXI_DATA_WIDTH-1:0] wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [C_S_AXI_DATA_WIDTH-1:0] rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
    reg                           int_ap_idle;
    reg                           int_ap_ready;
    reg                           int_ap_done = 1'b0;
    reg                           int_ap_start = 1'b0;
    reg                           int_auto_restart = 1'b0;
    reg                           int_gie = 1'b0;
    reg  [1:0]                    int_ier = 2'b0;
    reg  [1:0]                    int_isr = 2'b0;
    // memory signals
    wire [4:0]                    int_theta_array_address0;
    wire                          int_theta_array_ce0;
    wire                          int_theta_array_we0;
    wire [3:0]                    int_theta_array_be0;
    wire [31:0]                   int_theta_array_d0;
    wire [31:0]                   int_theta_array_q0;
    wire [4:0]                    int_theta_array_address1;
    wire                          int_theta_array_ce1;
    wire                          int_theta_array_we1;
    wire [3:0]                    int_theta_array_be1;
    wire [31:0]                   int_theta_array_d1;
    wire [31:0]                   int_theta_array_q1;
    reg                           int_theta_array_read;
    reg                           int_theta_array_write;
    wire [16:0]                   int_img_in_address0;
    wire                          int_img_in_ce0;
    wire                          int_img_in_we0;
    wire [3:0]                    int_img_in_be0;
    wire [31:0]                   int_img_in_d0;
    wire [31:0]                   int_img_in_q0;
    wire [16:0]                   int_img_in_address1;
    wire                          int_img_in_ce1;
    wire                          int_img_in_we1;
    wire [3:0]                    int_img_in_be1;
    wire [31:0]                   int_img_in_d1;
    wire [31:0]                   int_img_in_q1;
    reg                           int_img_in_read;
    reg                           int_img_in_write;
    reg  [1:0]                    int_img_in_shift;

//------------------------Instantiation------------------
// int_theta_array
houghlines_accel_BUS_A_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_theta_array (
    .clk0     ( ACLK ),
    .address0 ( int_theta_array_address0 ),
    .ce0      ( int_theta_array_ce0 ),
    .we0      ( int_theta_array_we0 ),
    .be0      ( int_theta_array_be0 ),
    .d0       ( int_theta_array_d0 ),
    .q0       ( int_theta_array_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_theta_array_address1 ),
    .ce1      ( int_theta_array_ce1 ),
    .we1      ( int_theta_array_we1 ),
    .be1      ( int_theta_array_be1 ),
    .d1       ( int_theta_array_d1 ),
    .q1       ( int_theta_array_q1 )
);
// int_img_in
houghlines_accel_BUS_A_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 76800 )
) int_img_in (
    .clk0     ( ACLK ),
    .address0 ( int_img_in_address0 ),
    .ce0      ( int_img_in_ce0 ),
    .we0      ( int_img_in_we0 ),
    .be0      ( int_img_in_be0 ),
    .d0       ( int_img_in_d0 ),
    .q0       ( int_img_in_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_img_in_address1 ),
    .ce1      ( int_img_in_ce1 ),
    .we1      ( int_img_in_we1 ),
    .be1      ( int_img_in_be1 ),
    .d1       ( int_img_in_d1 ),
    .q1       ( int_img_in_q1 )
);


//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA) && (!ar_hs);
assign BRESP   = 2'b00;  // OKAY
assign BVALID  = (wstate == WRRESP);
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (w_hs)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= AWADDR[ADDR_BITS-1:0];
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA) & !int_theta_array_read & !int_img_in_read;
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 'b0;
            case (raddr)
                ADDR_AP_CTRL: begin
                    rdata[0] <= int_ap_start;
                    rdata[1] <= int_ap_done;
                    rdata[2] <= int_ap_idle;
                    rdata[3] <= int_ap_ready;
                    rdata[7] <= int_auto_restart;
                end
                ADDR_GIE: begin
                    rdata <= int_gie;
                end
                ADDR_IER: begin
                    rdata <= int_ier;
                end
                ADDR_ISR: begin
                    rdata <= int_isr;
                end
            endcase
        end
        else if (int_theta_array_read) begin
            rdata <= int_theta_array_q1;
        end
        else if (int_img_in_read) begin
            rdata <= int_img_in_q1;
        end
    end
end


//------------------------Register logic-----------------
assign interrupt = int_gie & (|int_isr);
assign ap_start  = int_ap_start;
// int_ap_start
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_start <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0] && WDATA[0])
            int_ap_start <= 1'b1;
        else if (ap_ready)
            int_ap_start <= int_auto_restart; // clear on handshake/auto restart
    end
end

// int_ap_done
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_done <= 1'b0;
    else if (ACLK_EN) begin
        if (ap_done)
            int_ap_done <= 1'b1;
        else if (ar_hs && raddr == ADDR_AP_CTRL)
            int_ap_done <= 1'b0; // clear on read
    end
end

// int_ap_idle
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_idle <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_idle <= ap_idle;
    end
end

// int_ap_ready
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_ready <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_ready <= ap_ready;
    end
end

// int_auto_restart
always @(posedge ACLK) begin
    if (ARESET)
        int_auto_restart <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0])
            int_auto_restart <=  WDATA[7];
    end
end

// int_gie
always @(posedge ACLK) begin
    if (ARESET)
        int_gie <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_GIE && WSTRB[0])
            int_gie <= WDATA[0];
    end
end

// int_ier
always @(posedge ACLK) begin
    if (ARESET)
        int_ier <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_IER && WSTRB[0])
            int_ier <= WDATA[1:0];
    end
end

// int_isr[0]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[0] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[0] & ap_done)
            int_isr[0] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[0] <= int_isr[0] ^ WDATA[0]; // toggle on write
    end
end

// int_isr[1]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[1] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[1] & ap_ready)
            int_isr[1] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[1] <= int_isr[1] ^ WDATA[1]; // toggle on write
    end
end


//------------------------Memory logic-------------------
// theta_array
assign int_theta_array_address0 = theta_array_address0;
assign int_theta_array_ce0      = theta_array_ce0;
assign int_theta_array_we0      = theta_array_we0;
assign int_theta_array_be0      = {4{theta_array_we0}};
assign int_theta_array_d0       = theta_array_d0;
assign int_theta_array_address1 = ar_hs? raddr[6:2] : waddr[6:2];
assign int_theta_array_ce1      = ar_hs | (int_theta_array_write & WVALID);
assign int_theta_array_we1      = int_theta_array_write & w_hs;
assign int_theta_array_be1      = WSTRB;
assign int_theta_array_d1       = WDATA;
// img_in
assign int_img_in_address0      = img_in_address0 >> 2;
assign int_img_in_ce0           = img_in_ce0;
assign int_img_in_we0           = 1'b0;
assign int_img_in_be0           = 1'b0;
assign int_img_in_d0            = 1'b0;
assign img_in_q0                = int_img_in_q0 >> (int_img_in_shift * 8);
assign int_img_in_address1      = ar_hs? raddr[18:2] : waddr[18:2];
assign int_img_in_ce1           = ar_hs | (int_img_in_write & WVALID);
assign int_img_in_we1           = int_img_in_write & w_hs;
assign int_img_in_be1           = WSTRB;
assign int_img_in_d1            = WDATA;
// int_theta_array_read
always @(posedge ACLK) begin
    if (ARESET)
        int_theta_array_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_THETA_ARRAY_BASE && raddr <= ADDR_THETA_ARRAY_HIGH)
            int_theta_array_read <= 1'b1;
        else
            int_theta_array_read <= 1'b0;
    end
end

// int_theta_array_write
always @(posedge ACLK) begin
    if (ARESET)
        int_theta_array_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_THETA_ARRAY_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_THETA_ARRAY_HIGH)
            int_theta_array_write <= 1'b1;
        else if (w_hs)
            int_theta_array_write <= 1'b0;
    end
end

// int_img_in_read
always @(posedge ACLK) begin
    if (ARESET)
        int_img_in_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_IMG_IN_BASE && raddr <= ADDR_IMG_IN_HIGH)
            int_img_in_read <= 1'b1;
        else
            int_img_in_read <= 1'b0;
    end
end

// int_img_in_write
always @(posedge ACLK) begin
    if (ARESET)
        int_img_in_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_IMG_IN_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_IMG_IN_HIGH)
            int_img_in_write <= 1'b1;
        else if (w_hs)
            int_img_in_write <= 1'b0;
    end
end

// int_img_in_shift
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (img_in_ce0)
            int_img_in_shift <= img_in_address0[1:0];
    end
end


endmodule


`timescale 1ns/1ps

module houghlines_accel_BUS_A_s_axi_ram
#(parameter
    BYTES  = 4,
    DEPTH  = 256,
    AWIDTH = log2(DEPTH)
) (
    input  wire               clk0,
    input  wire [AWIDTH-1:0]  address0,
    input  wire               ce0,
    input  wire               we0,
    input  wire [BYTES-1:0]   be0,
    input  wire [BYTES*8-1:0] d0,
    output reg  [BYTES*8-1:0] q0,
    input  wire               clk1,
    input  wire [AWIDTH-1:0]  address1,
    input  wire               ce1,
    input  wire               we1,
    input  wire [BYTES-1:0]   be1,
    input  wire [BYTES*8-1:0] d1,
    output reg  [BYTES*8-1:0] q1
);
//------------------------Local signal-------------------
reg  [BYTES*8-1:0] mem[0:DEPTH-1];
//------------------------Task and function--------------
function integer log2;
    input integer x;
    integer n, m;
begin
    n = 1;
    m = 2;
    while (m < x) begin
        n = n + 1;
        m = m * 2;
    end
    log2 = n;
end
endfunction
//------------------------Body---------------------------
// read port 0
always @(posedge clk0) begin
    if (ce0) q0 <= mem[address0];
end

// read port 1
always @(posedge clk1) begin
    if (ce1) q1 <= mem[address1];
end

genvar i;
generate
    for (i = 0; i < BYTES; i = i + 1) begin : gen_write
        // write port 0
        always @(posedge clk0) begin
            if (ce0 & we0 & be0[i]) begin
                mem[address0][8*i+7:8*i] <= d0[8*i+7:8*i];
            end
        end
        // write port 1
        always @(posedge clk1) begin
            if (ce1 & we1 & be1[i]) begin
                mem[address1][8*i+7:8*i] <= d1[8*i+7:8*i];
            end
        end
    end
endgenerate

endmodule

