

module ftdi_sync_test(

    input wire sysclk,
    input wire cpu_resetn,

    inout  [7:0] ftdi_data,
    input        ftdi_rxf_n,
    input        ftdi_txe_n,
    output       ftdi_rd_n,
    output       ftdi_wr_n,
    output       ftdi_siwun,
    output       ftdi_oe_n,
    input        ftdi_clko,

    output wire [7:0] led
);


    assign ftdi_siwun = 1'b1;

    // Clocking
    //---------------
    wire locked;
    wire core_clk;
    clock_module clock_wizard
    (   
        .clk_in1(sysclk),      // input clk_in1
        // Clock out ports
        .clk_core(core_clk),     // output clk_core
        // Status and control signals
        .resetn(cpu_resetn), // input resetn
        .locked(locked)       // output locked
    // Clock in ports
        
    );
    wire core_resn;
    wire ftdi_resn;
    reset_sync # ( .RESET_DELAY(15) ) ftdi_res_sync ( .clk(ftdi_clko), .resn_in(cpu_resetn && locked), .resn_out(ftdi_resn) );
    reset_sync # ( .RESET_DELAY(15) ) core_res_sync ( .clk(core_clk),   .resn_in(cpu_resetn && locked), .resn_out(core_resn) );


    // FTDI Interface
    //-------------------
    wire [7:0] ftdi_egress_s_axis_tdata;
    wire [7:0] ftdi_igress_m_axis_tdata;
    ftdi_sync_fifo_axis  ftdi_sync_fifo_axis_inst (
        .ftdi_clko(ftdi_clko),
        .resn(ftdi_resn),
        .ftdi_txe_n(ftdi_txe_n),
        .ftdi_rxf_n(ftdi_rxf_n),
        .ftdi_rd_n(ftdi_rd_n),
        .ftdi_oe_n(ftdi_oe_n),
        .ftdi_wr_n(ftdi_wr_n),
        .ftdi_data(ftdi_data),

        .m_axis_tdata(ftdi_igress_m_axis_tdata),
        .m_axis_tvalid(ftdi_igress_m_axis_tvalid),
        .m_axis_tready(ftdi_igress_m_axis_tready),
        .m_axis_almost_full(ftdi_igress_m_axis_almost_full),

        .s_axis_tdata(ftdi_egress_s_axis_tdata),
        .s_axis_tvalid(ftdi_egress_s_axis_tvalid),
        .s_axis_tready(ftdi_egress_s_axis_tready),
        .s_axis_almost_empty(ftdi_egress_s_axis_almost_empty)
    );
    
    // FIFOS
    //---------------
    wire [7:0] ftdi_fifo_m_axis_tdata;
    wire [7:0] ftdi_fifo_s_axis_tdata;
    wire ftdi_fifo_m_axis_tvalid;
    ftdio_io_fifo ftdi_igress (
        .s_axis_aresetn(ftdi_resn),  // input wire s_axis_aresetn
        .s_axis_aclk(ftdi_clko),        // input wire s_axis_aclk
        .s_axis_tvalid(ftdi_igress_m_axis_tvalid),    // input wire s_axis_tvalid
        .s_axis_tready(ftdi_igress_m_axis_tready),    // output wire s_axis_tready
        .s_axis_tdata(ftdi_igress_m_axis_tdata),      // input wire [7 : 0] s_axis_tdata

        .m_axis_aclk(core_clk),        // input wire m_axis_aclk
        .m_axis_tvalid(ftdi_fifo_m_axis_tvalid),    // output wire m_axis_tvalid
        .m_axis_tready(ftdi_fifo_m_axis_tready),    // input wire m_axis_tready
        .m_axis_tdata(ftdi_fifo_m_axis_tdata),      // output wire [7 : 0] m_axis_tdata

        .almost_full(ftdi_igress_m_axis_almost_full),
        .almost_empty()
    );

    ftdio_io_fifo ftdi_egress (

        .s_axis_aresetn(core_resn),  // input wire s_axis_aresetn
        .s_axis_aclk(core_clk),        // input wire s_axis_aclk
        .s_axis_tvalid(ftdi_fifo_s_axis_tvalid),    // input wire s_axis_tvalid
        .s_axis_tready(ftdi_fifo_s_axis_tready),    // output wire s_axis_tready
        .s_axis_tdata(ftdi_fifo_s_axis_tdata),      // input wire [7 : 0] s_axis_tdata

        .m_axis_aclk(ftdi_clko),        // input wire m_axis_aclk
        .m_axis_tvalid(ftdi_egress_s_axis_tvalid),    // output wire m_axis_tvalid
        .m_axis_tready(ftdi_egress_s_axis_tready),    // input wire m_axis_tready
        .m_axis_tdata(ftdi_egress_s_axis_tdata),      // output wire [7 : 0] m_axis_tdata

        .almost_full(),
        .almost_empty(ftdi_egress_s_axis_almost_empty)
    );

    // RFG Protocol
    //------------------
    wire [7:0] rfg_write_value;
    wire [7:0] rfg_read_value;
    wire [7:0] rfg_address;
    rfg_axis_protocol rfg_protocol (
        .aclk(core_clk),
        .aresetn(core_resn),

        .m_axis_tdata(ftdi_fifo_s_axis_tdata),
        .m_axis_tvalid(ftdi_fifo_s_axis_tvalid),
        .m_axis_tready(ftdi_fifo_s_axis_tready),
        .m_axis_tlast(),
        .m_axis_tid(),
        .m_axis_tdest(),
        .m_axis_tuser(),

        .s_axis_tdata(ftdi_fifo_m_axis_tdata),
        .s_axis_tvalid(ftdi_fifo_m_axis_tvalid),
        .s_axis_tready(ftdi_fifo_m_axis_tready),
        .s_axis_tid(8'h00),
        .s_axis_tdest(8'h00),
        .s_axis_tuser(8'h00),

        .rfg_address(rfg_address),
        .rfg_write_value(rfg_write_value),
        .rfg_write(rfg_write),
        .rfg_write_last(rfg_write_last),
        .rfg_read(rfg_read),
        .rfg_read_valid(rfg_read_valid),
        .rfg_read_value(rfg_read_value)
    );

    // RFG
    //-------------

    reg data_in_detected;
    reg blink_led;
    assign led[0] = data_in_detected;
    assign led[1] = blink_led;

    wire blink;
    always @(posedge core_clk) begin 
        if (!core_resn) begin 
            data_in_detected <= 1'b0;
            blink_led <= 1'b0;
        end
        else begin 
            if (ftdi_fifo_m_axis_tvalid) begin 
                data_in_detected <= 1'b1;
            end

            if (blink) begin 
                blink_led <= !blink_led;
            end
        end
    end

    wire [7:0] rfg_led;
    assign led[7:2] = rfg_led[5:0];

    wire [7:0] loopback_fifo_r_s_axis_tdata;
    wire [7:0] loopback_fifo_w_m_axis_tdata;

    main_rfg  main_rfg_inst (
        .clk(core_clk),
        .resn(core_resn),

        .rfg_address(rfg_address),
        .rfg_write_value(rfg_write_value),
        .rfg_write(rfg_write),
        .rfg_write_last(rfg_write_last),
        .rfg_read(rfg_read),
        .rfg_read_valid(rfg_read_valid),
        .rfg_read_value(rfg_read_value),

        .io_led(rfg_led),
        .blink(),
        .blink_interrupt(blink),
        .blink_match(),

        .loopback_fifo_w_m_axis_tdata(loopback_fifo_w_m_axis_tdata),
        .loopback_fifo_w_m_axis_tvalid(loopback_fifo_w_m_axis_tvalid),
        .loopback_fifo_w_m_axis_tready(loopback_fifo_w_m_axis_tready),
        .loopback_fifo_r_s_axis_tdata(loopback_fifo_r_s_axis_tdata),
        .loopback_fifo_r_s_axis_tvalid(loopback_fifo_r_s_axis_tvalid),
        .loopback_fifo_r_s_axis_tready(loopback_fifo_r_s_axis_tready)
    );

    // Loopback AXIS Interface
    //---------------
    loopback_fifo loopback_fifo_I (

        .s_axis_aresetn(core_resn),  
        .s_axis_aclk(core_clk),        

        .s_axis_tvalid(loopback_fifo_w_m_axis_tvalid),   
        .s_axis_tready(loopback_fifo_w_m_axis_tready),   
        .s_axis_tdata(loopback_fifo_w_m_axis_tdata),     

        .m_axis_tvalid(loopback_fifo_r_s_axis_tvalid),    
        .m_axis_tready(loopback_fifo_r_s_axis_tready),    
        .m_axis_tdata(loopback_fifo_r_s_axis_tdata)    

    );

endmodule 