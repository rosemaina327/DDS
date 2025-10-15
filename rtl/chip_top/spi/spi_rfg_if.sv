

`include "axi_ifs.sv"

/*
This module provides an SPI Slave interface to RFG for Read/Write
*/
module spi_rfg_if (

    input  wire				spi_clk,
    input  wire				spi_csn,
    output wire				spi_miso,
    input  wire				spi_mosi,


    output wire [15:0]		rfg_address,
    output wire				rfg_read,
    input  wire				rfg_read_valid,
    input  wire [7:0]		rfg_read_value,
    output wire				rfg_write,
    output wire				rfg_write_last,
    output wire [7:0]		rfg_write_value

);

    // AXIS Switch connections
    //--------------
    localparam NUM_INTERFACES = 3 ;
    wire [(NUM_INTERFACES*8)-1:0]   switch_m_tdata;
    wire [(NUM_INTERFACES*8)-1:0]   switch_m_tid;
    wire [(NUM_INTERFACES*8)-1:0]   switch_m_tdest;
    wire [NUM_INTERFACES-1:0]       switch_m_tready;
    wire [NUM_INTERFACES-1:0]       switch_m_tvalid;
    wire [NUM_INTERFACES-1:0]       switch_m_tlast;


    wire [(NUM_INTERFACES*8)-1:0]   switch_s_tdata;
    wire [(NUM_INTERFACES*8)-1:0]   switch_s_tid;
    wire [(NUM_INTERFACES*8)-1:0]   switch_s_tdest;
    wire [NUM_INTERFACES-1:0]       switch_s_tready;
    wire [NUM_INTERFACES-1:0]       switch_s_tvalid;
    wire [NUM_INTERFACES-1:0]       switch_s_tlast;




    //----------------------
    // SPI
    //----------------------
    byte_t spi_igress_m_axis_tdata;
    byte_t spi_igress_m_axis_tid;
    byte_t spi_igress_m_axis_tdest;

    byte_t protocol_m_axis_tdata;
    byte_t protocol_m_axis_tid;
    wire   protocol_m_axis_tvalid;
    wire   protocol_m_axis_tlast;
    wire   readout_framing_s_axis_tready;


    // IGRESS
    spi_slave_axis_igress #( .ASYNC_RES(1),.MSB_FIRST(0)) spi_igress(

        .spi_clk(spi_clk),
        .spi_csn(spi_csn),
        .spi_mosi(spi_mosi),

        .m_axis_tdata(spi_igress_m_axis_tdata),
        .m_axis_tdest(spi_igress_m_axis_tdest),
        .m_axis_tid(spi_igress_m_axis_tid),
        .m_axis_tready(spi_igress_m_axis_tready),
        .m_axis_tvalid(spi_igress_m_axis_tvalid),

        .err_overrun(/* WAIVED: Overrun not relevant when CS not used */)
    );


    // Egress

    byte_t readout_framing_m_axis_tdata;
    byte_t readout_framing_m_axis_tuser;

    rfg_axis_readout_framing #(.MTU_SIZE(16),.IDLE_BYTE(8'hBC),.START_BYTE(8'hEF)) readout_framing(

        .clk(spi_clk),
        .resn(!spi_csn),

        .s_axis_tdata(protocol_m_axis_tdata),
        .s_axis_tid(8'hEF),
        .s_axis_tlast(protocol_m_axis_tlast),
        .s_axis_tready(readout_framing_s_axis_tready),
        .s_axis_tvalid(protocol_m_axis_tvalid),

        .m_axis_tdata(readout_framing_m_axis_tdata),
        .m_axis_tready(readout_framing_m_axis_tready),
        .m_axis_tuser(readout_framing_m_axis_tuser),
        .m_axis_tvalid(readout_framing_m_axis_tvalid)

    );
    spi_slave_axis_egress #(.ASYNC_RES(1),.MSB_FIRST(0),.MISO_SIZE(1)) spi_egress(

        .spi_clk(spi_clk),
        .spi_csn(spi_csn),
        .spi_miso(spi_miso),

        .s_axis_tdata(readout_framing_m_axis_tdata),
        .s_axis_tready(readout_framing_m_axis_tready),
        .s_axis_tuser(readout_framing_m_axis_tuser),
        .s_axis_tvalid(readout_framing_m_axis_tvalid)
    );


    //-----------------------------
    // RFG
    //------------------------------
    rfg_axis_protocol  rfg_protocol(
        .aclk(spi_clk),
        .aresetn(!spi_csn),

        .m_axis_tdata(protocol_m_axis_tdata),
        .m_axis_tdest( ),
        .m_axis_tid( ),
        .m_axis_tlast(protocol_m_axis_tlast),
        .m_axis_tready(readout_framing_s_axis_tready),
        .m_axis_tvalid(protocol_m_axis_tvalid),

        .s_axis_tdata(spi_igress_m_axis_tdata),
        .s_axis_tid(spi_igress_m_axis_tid),
        .s_axis_tready(spi_igress_m_axis_tready),
        .s_axis_tvalid(spi_igress_m_axis_tvalid),

        .rfg_address(rfg_address),
        .rfg_read(rfg_read),
        .rfg_read_valid(rfg_read_valid),
        .rfg_read_value(rfg_read_value),
        .rfg_write(rfg_write),
        .rfg_write_last(rfg_write_last),
        .rfg_write_value(rfg_write_value),
        .debug_got_byte(rfg_debug_got_byte),
        .debug_state()
    );



endmodule
