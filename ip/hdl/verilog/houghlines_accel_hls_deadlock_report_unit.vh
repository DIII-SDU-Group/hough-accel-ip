   
    parameter PROC_NUM = 10;
    parameter ST_IDLE = 2'b0;
    parameter ST_DL_DETECTED = 2'b1;
    parameter ST_DL_REPORT = 2'b10;
   

    reg find_df_deadlock = 0;
    reg [1:0] CS_fsm;
    reg [1:0] NS_fsm;
    reg [PROC_NUM - 1:0] dl_detect_reg;
    reg [PROC_NUM - 1:0] dl_done_reg;
    reg [PROC_NUM - 1:0] origin_reg;
    reg [PROC_NUM - 1:0] dl_in_vec_reg;
    integer i;
    integer fp;

    // FSM State machine
    always @ (negedge reset or posedge clock) begin
        if (~reset) begin
            CS_fsm <= ST_IDLE;
        end
        else begin
            CS_fsm <= NS_fsm;
        end
    end
    always @ (CS_fsm or dl_in_vec or dl_detect_reg or dl_done_reg or dl_in_vec or origin_reg) begin
        NS_fsm = CS_fsm;
        case (CS_fsm)
            ST_IDLE : begin
                if (|dl_in_vec) begin
                    NS_fsm = ST_DL_DETECTED;
                end
            end
            ST_DL_DETECTED: begin
                // has unreported deadlock cycle
                if (dl_detect_reg != dl_done_reg) begin
                    NS_fsm = ST_DL_REPORT;
                end
            end
            ST_DL_REPORT: begin
                if (|(dl_in_vec & origin_reg)) begin
                    NS_fsm = ST_DL_DETECTED;
                end
            end
        endcase
    end

    // dl_detect_reg record the procs that first detect deadlock
    always @ (negedge reset or posedge clock) begin
        if (~reset) begin
            dl_detect_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_IDLE) begin
                dl_detect_reg <= dl_in_vec;
            end
        end
    end

    // dl_detect_out keeps in high after deadlock detected
    assign dl_detect_out = |dl_detect_reg;

    // dl_done_reg record the cycles has been reported
    always @ (negedge reset or posedge clock) begin
        if (~reset) begin
            dl_done_reg <= 'b0;
        end
        else begin
            if ((CS_fsm == ST_DL_REPORT) && (|(dl_in_vec & dl_detect_reg) == 'b1)) begin
                dl_done_reg <= dl_done_reg | dl_in_vec;
            end
        end
    end

    // clear token once a cycle is done
    assign token_clear = (CS_fsm == ST_DL_REPORT) ? ((|(dl_in_vec & origin_reg)) ? 'b1 : 'b0) : 'b0;

    // origin_reg record the current cycle start id
    always @ (negedge reset or posedge clock) begin
        if (~reset) begin
            origin_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                origin_reg <= origin;
            end
        end
    end
   
    // origin will be valid for only one cycle
    always @ (CS_fsm or dl_detect_reg or dl_done_reg) begin
        if (CS_fsm == ST_DL_DETECTED) begin
            for (i = 0; i < PROC_NUM; i = i + 1) begin
                if (dl_detect_reg[i] & ~dl_done_reg[i] & ~(|origin)) begin
                    origin = 'b1 << i;
                end
            end
        end
        else begin
            origin = 'b0;
        end
    end
    
    // dl_in_vec_reg record the current cycle dl_in_vec
    always @ (negedge reset or posedge clock) begin
        if (~reset) begin
            dl_in_vec_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                dl_in_vec_reg <= origin;
            end
            else if (CS_fsm == ST_DL_REPORT) begin
                dl_in_vec_reg <= dl_in_vec;
            end
        end
    end
    
    // get the first valid proc index in dl vector
    function integer proc_index(input [PROC_NUM - 1:0] dl_vec);
        begin
            proc_index = 0;
            for (i = 0; i < PROC_NUM; i = i + 1) begin
                if (dl_vec[i]) begin
                    proc_index = i;
                end
            end
        end
    endfunction

    // get the proc path based on dl vector
    function [920:0] proc_path(input [PROC_NUM - 1:0] dl_vec);
        integer index;
        begin
            index = proc_index(dl_vec);
            case (index)
                0 : begin
                    proc_path = "houghlines_accel_houghlines_accel.Block_split1_proc_U0";
                end
                1 : begin
                    proc_path = "houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0";
                end
                2 : begin
                    proc_path = "houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0";
                end
                3 : begin
                    proc_path = "houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0";
                end
                4 : begin
                    proc_path = "houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_pxl_width_U0";
                end
                5 : begin
                    proc_path = "houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0";
                end
                6 : begin
                    proc_path = "houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_Block_split15_proc_U0";
                end
                7 : begin
                    proc_path = "houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2AxiStream_U0";
                end
                8 : begin
                    proc_path = "houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0";
                end
                9 : begin
                    proc_path = "houghlines_accel_houghlines_accel.HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0";
                end
                default : begin
                    proc_path = "unknown";
                end
            endcase
        end
    endfunction

    // print the headlines of deadlock detection
    task print_dl_head;
        begin
            $display("\n//////////////////////////////////////////////////////////////////////////////");
            $display("// ERROR!!! DEADLOCK DETECTED at %0t ns! SIMULATION WILL BE STOPPED! //", $time);
            $display("//////////////////////////////////////////////////////////////////////////////");
            fp = $fopen("deadlock_db.dat", "w");
        end
    endtask

    // print the start of a cycle
    task print_cycle_start(input reg [920:0] proc_path, input integer cycle_id);
        begin
            $display("/////////////////////////");
            $display("// Dependence cycle %0d:", cycle_id);
            $display("// (1): Process: %0s", proc_path);
            $fdisplay(fp, "Dependence_Cycle_ID %0d", cycle_id);
            $fdisplay(fp, "Dependence_Process_ID 1");
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print the end of deadlock detection
    task print_dl_end(input integer num, input integer record_time);
        begin
            $display("////////////////////////////////////////////////////////////////////////");
            $display("// Totally %0d cycles detected!", num);
            $display("////////////////////////////////////////////////////////////////////////");
            $display("// ERROR!!! DEADLOCK DETECTED at %0t ns! SIMULATION WILL BE STOPPED! //", record_time);
            $display("//////////////////////////////////////////////////////////////////////////////");
            $fdisplay(fp, "Dependence_Cycle_Number %0d", num);
            $fclose(fp);
        end
    endtask

    // print one proc component in the cycle
    task print_cycle_proc_comp(input reg [920:0] proc_path, input integer cycle_comp_id);
        begin
            $display("// (%0d): Process: %0s", cycle_comp_id, proc_path);
            $fdisplay(fp, "Dependence_Process_ID %0d", cycle_comp_id);
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print one channel component in the cycle
    task print_cycle_chan_comp(input [PROC_NUM - 1:0] dl_vec1, input [PROC_NUM - 1:0] dl_vec2);
        reg [960:0] chan_path;
        integer index1;
        integer index2;
        begin
            index1 = proc_index(dl_vec1);
            index2 = proc_index(dl_vec2);
            case (index1)
                0 : begin
                    case(index2)
                    1: begin
                        if (~Block_split1_proc_U0.imgInput_rows_out_blk_n) begin
                            if (~imgInput_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.imgInput_rows_c_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~imgInput_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.imgInput_rows_c_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Block_split1_proc_U0.imgInput_cols_out_blk_n) begin
                            if (~imgInput_cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.imgInput_cols_c_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~imgInput_cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.imgInput_cols_c_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (ap_sync_Block_split1_proc_U0_ap_ready & Block_split1_proc_U0.ap_idle & ~ap_sync_Array2xfMat_8_0_480_640_1_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0'");
                        end
                    end
                    endcase
                end
                1 : begin
                    case(index2)
                    9: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0.imgInput_44_blk_n) begin
                            if (~imgInput_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.imgInput_data_U' written by process 'houghlines_accel_houghlines_accel.HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~imgInput_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.imgInput_data_U' read by process 'houghlines_accel_houghlines_accel.HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.dstMat_rows_out_blk_n) begin
                            if (~imgInput_rows_c7_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.imgInput_rows_c7_U' written by process 'houghlines_accel_houghlines_accel.HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_rows_c7_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~imgInput_rows_c7_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.imgInput_rows_c7_U' read by process 'houghlines_accel_houghlines_accel.HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_rows_c7_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.dstMat_cols_out_blk_n) begin
                            if (~imgInput_cols_c8_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.imgInput_cols_c8_U' written by process 'houghlines_accel_houghlines_accel.HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_cols_c8_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~imgInput_cols_c8_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.imgInput_cols_c8_U' read by process 'houghlines_accel_houghlines_accel.HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_cols_c8_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_U.if_full_n & Array2xfMat_8_0_480_640_1_U0.ap_start & ~Array2xfMat_8_0_480_640_1_U0.real_start & (trans_in_cnt_3 == trans_out_cnt_3) & ~start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'houghlines_accel_houghlines_accel.start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_U' read by process 'houghlines_accel_houghlines_accel.HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0',");
                        end
                    end
                    0: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.dstMat_rows_blk_n) begin
                            if (~imgInput_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.imgInput_rows_c_U' written by process 'houghlines_accel_houghlines_accel.Block_split1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~imgInput_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.imgInput_rows_c_U' read by process 'houghlines_accel_houghlines_accel.Block_split1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.dstMat_cols_blk_n) begin
                            if (~imgInput_cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.imgInput_cols_c_U' written by process 'houghlines_accel_houghlines_accel.Block_split1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~imgInput_cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.imgInput_cols_c_U' read by process 'houghlines_accel_houghlines_accel.Block_split1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (ap_sync_Array2xfMat_8_0_480_640_1_U0_ap_ready & Array2xfMat_8_0_480_640_1_U0.ap_idle & ~ap_sync_Block_split1_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'houghlines_accel_houghlines_accel.Block_split1_proc_U0'");
                        end
                    end
                    endcase
                end
                2 : begin
                    case(index2)
                    3: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0.rows_out_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c1_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c1_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c1_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c1_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c1_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c1_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0.cols_out_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c2_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c2_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c2_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c2_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c2_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c2_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_Axi2Mat_entry21_U0_U.if_full_n & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0.ap_start & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0.real_start & (trans_in_cnt_0 == trans_out_cnt_0) & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_Axi2Mat_entry21_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_Axi2Mat_entry21_U0_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0',");
                        end
                    end
                    4: begin
                        if (Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ap_sync_Axi2Mat_entry3_U0_ap_ready & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0.ap_idle & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ap_sync_last_blk_pxl_width_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_pxl_width_U0'");
                        end
                    end
                    7: begin
                        if (Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ap_sync_Axi2Mat_entry3_U0_ap_ready & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0.ap_idle & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ap_sync_Axi2AxiStream_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2AxiStream_U0'");
                        end
                    end
                    endcase
                end
                3 : begin
                    case(index2)
                    2: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0.rows_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c1_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c1_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c1_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c1_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c1_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c1_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0.cols_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c2_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c2_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c2_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c2_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c2_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c2_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_Axi2Mat_entry21_U0_U.if_empty_n & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0.ap_idle & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_Axi2Mat_entry21_U0_U.if_write) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_Axi2Mat_entry21_U0_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0',");
                        end
                    end
                    5: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0.rows_out_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0.cols_out_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_addrbound_U0_U.if_full_n & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0.ap_start & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0.real_start & (trans_in_cnt_1 == trans_out_cnt_1) & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_addrbound_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_addrbound_U0_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0',");
                        end
                    end
                    endcase
                end
                4 : begin
                    case(index2)
                    8: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_pxl_width_U0.ret_out_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_width_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_width_c_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_width_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_width_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_width_c_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_width_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_AxiStream2MatStream_U0_U.if_full_n & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_pxl_width_U0.ap_start & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_pxl_width_U0.real_start & (trans_in_cnt_2 == trans_out_cnt_2) & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_AxiStream2MatStream_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_AxiStream2MatStream_U0_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0',");
                        end
                    end
                    2: begin
                        if (Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ap_sync_last_blk_pxl_width_U0_ap_ready & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_pxl_width_U0.ap_idle & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ap_sync_Axi2Mat_entry3_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0'");
                        end
                    end
                    7: begin
                        if (Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ap_sync_last_blk_pxl_width_U0_ap_ready & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_pxl_width_U0.ap_idle & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ap_sync_Axi2AxiStream_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2AxiStream_U0'");
                        end
                    end
                    endcase
                end
                5 : begin
                    case(index2)
                    3: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0.rows_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0.cols_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_addrbound_U0_U.if_empty_n & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0.ap_idle & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_addrbound_U0_U.if_write) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_addrbound_U0_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry21_U0',");
                        end
                    end
                    8: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0.rows_out_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c13_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c13_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c13_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c13_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c13_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c13_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0.cols_out_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c14_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c14_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c14_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c14_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c14_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c14_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                6 : begin
                    case(index2)
                    5: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.p_channel_U.if_empty_n & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_Block_split15_proc_U0.ap_idle & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.p_channel_U.if_write) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.p_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.p_channel_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.p_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.p_channel_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                7 : begin
                    case(index2)
                    8: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2AxiStream_U0.ldata1_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ldata_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ldata_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ldata_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ldata_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    6: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.axibound_V_U.if_empty_n & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2AxiStream_U0.ap_idle & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.axibound_V_U.if_write) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.axibound_V_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.axibound_V_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_Block_split15_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.axibound_V_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.axibound_V_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.axibound_V_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_Block_split15_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.axibound_V_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    2: begin
                        if (Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ap_sync_Axi2AxiStream_U0_ap_ready & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2AxiStream_U0.ap_idle & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ap_sync_Axi2Mat_entry3_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2Mat_entry3_U0'");
                        end
                    end
                    4: begin
                        if (Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ap_sync_Axi2AxiStream_U0_ap_ready & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2AxiStream_U0.ap_idle & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ap_sync_last_blk_pxl_width_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_pxl_width_U0'");
                        end
                    end
                    endcase
                end
                8 : begin
                    case(index2)
                    7: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0.ldata1_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ldata_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ldata_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2AxiStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ldata_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ldata_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.Axi2AxiStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    5: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0.rows_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c13_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c13_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c13_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c13_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c13_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.rows_c13_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0.cols_bound_per_npc_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c14_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c14_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c14_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c14_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c14_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.cols_c14_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0.last_blk_width_blk_n) begin
                            if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_width_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_width_c_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_pxl_width_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_width_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_width_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_width_c_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_pxl_width_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_width_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_AxiStream2MatStream_U0_U.if_empty_n & Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.AxiStream2MatStream_U0.ap_idle & ~Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_AxiStream2MatStream_U0_U.if_write) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.start_for_AxiStream2MatStream_U0_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0.grp_Axi2Mat_fu_80.last_blk_pxl_width_U0',");
                        end
                    end
                    endcase
                end
                9 : begin
                    case(index2)
                    1: begin
                        if (~HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0.grp_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_fu_56.grp_xfVoting_0_480_640_0_1_1_2u_1u_180_800_0_s_fu_12888.imgInput_44_blk_n) begin
                            if (~imgInput_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.imgInput_data_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~imgInput_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.imgInput_data_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0.p_src_mat_rows_blk_n) begin
                            if (~imgInput_rows_c7_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.imgInput_rows_c7_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_rows_c7_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~imgInput_rows_c7_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.imgInput_rows_c7_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_rows_c7_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0.p_src_mat_cols_blk_n) begin
                            if (~imgInput_cols_c8_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'houghlines_accel_houghlines_accel.imgInput_cols_c8_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_cols_c8_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~imgInput_cols_c8_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'houghlines_accel_houghlines_accel.imgInput_cols_c8_U' read by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path houghlines_accel_houghlines_accel.imgInput_cols_c8_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_U.if_empty_n & HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0.ap_idle & ~start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_U.if_write) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'houghlines_accel_houghlines_accel.start_for_HoughLines_1u_2u_32_800_0_180_0_480_640_1_U0_U' written by process 'houghlines_accel_houghlines_accel.Array2xfMat_8_0_480_640_1_U0',");
                        end
                    end
                    endcase
                end
            endcase
        end
    endtask

    // report
    initial begin : report_deadlock
        integer cycle_id;
        integer cycle_comp_id;
        integer record_time;
        wait (reset == 1);
        cycle_id = 1;
        record_time = 0;
        while (1) begin
            @ (negedge clock);
            case (CS_fsm)
                ST_DL_DETECTED: begin
                    cycle_comp_id = 2;
                    if (dl_detect_reg != dl_done_reg) begin
                        if (dl_done_reg == 'b0) begin
                            print_dl_head;
                            record_time = $time;
                        end
                        print_cycle_start(proc_path(origin), cycle_id);
                        cycle_id = cycle_id + 1;
                    end
                    else begin
                        print_dl_end((cycle_id - 1),record_time);
                        find_df_deadlock = 1;
                        @(negedge clock);
                        $finish;
                    end
                end
                ST_DL_REPORT: begin
                    if ((|(dl_in_vec)) & ~(|(dl_in_vec & origin_reg))) begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                        print_cycle_proc_comp(proc_path(dl_in_vec), cycle_comp_id);
                        cycle_comp_id = cycle_comp_id + 1;
                    end
                    else begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                    end
                end
            endcase
        end
    end
 
