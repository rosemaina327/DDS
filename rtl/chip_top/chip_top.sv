/**

This module wires together the SPI Interface and the ADC
*/
module chip_top (

    input wire clk,
    input wire resn,

    inout wire VDD,
    inout wire GND,

    input  wire spi_clk,
    input  wire spi_csn,
    input  wire spi_mosi,
    output wire spi_miso,

    input `ANALOG_NET_TYPE VIN,
    input `ANALOG_NET_TYPE VREF

);


    wire internal_clk;

    // SPI Interface
    // ------------------
    //

    wire [15:0] rfg_address;
    wire [7:0] rfg_write_value, rfg_read_value;
    spi_rfg_if spi_if (
        .spi_clk(spi_clk),
        .spi_csn(spi_csn),
        .spi_miso(spi_miso),
        .spi_mosi(spi_mosi),
        .rfg_address(rfg_address),
        .rfg_read(rfg_read),
        .rfg_read_valid(rfg_read_valid),
        .rfg_read_value(rfg_read_value),
        .rfg_write(rfg_write),
        .rfg_write_last(rfg_write_last),
        .rfg_write_value(rfg_write_value)
    );

    // Internal modules are using the SPI clock

    // Register File
    // --------------------
    //

    wire  [ 7:0] osc_divider;
    wire  [ 7:0] TEST_DAC_VALUE;
    wire  [31:0] ADC_WAITTIME;
    wire  [ 7:0] ADC_FIFO_DATA_s_axis_tdata;  // cadence keep_signal_name ADC_FIFO_DATA_s_axis_tdata
    wire         ADC_FIFO_DATA_s_axis_tready; // cadence keep_signal_name ADC_FIFO_DATA_s_axis_tready
    wire         ADC_FIFO_DATA_s_axis_tvalid;// cadence keep_signal_name ADC_FIFO_DATA_s_axis_tvalid
    wire         ADC_CTRL_RESET;
    wire         ADC_CTRL_RESETN = !ADC_CTRL_RESET;
    logic        ADC_CTRL_BUSY;

    main_rfg rfg (
        .clk(spi_clk),
        .resn(!spi_csn),
        .rfg_address(rfg_address),
        .rfg_address_valid(rfg_address_valid),
        .rfg_write_value(rfg_write_value),
        .rfg_write_valid(rfg_write_valid),
        .rfg_write(rfg_write),
        .rfg_write_last(rfg_write_last),
        .rfg_read(rfg_read),
        .rfg_read_valid(rfg_read_valid),
        .rfg_read_value(rfg_read_value),
        .ADC_CTRL(),
        .ADC_CTRL_START(ADC_CTRL_START),
        .ADC_CTRL_BUSY(ADC_CTRL_BUSY),
        .ADC_CTRL_RESET(ADC_CTRL_RESET),
        .ADC_WAITTIME(ADC_WAITTIME),
        .ADC_FIFO_DATA_s_axis_tdata(ADC_FIFO_DATA_s_axis_tdata),
        .ADC_FIFO_DATA_s_axis_tvalid(ADC_FIFO_DATA_s_axis_tvalid),
        .ADC_FIFO_DATA_s_axis_tready(ADC_FIFO_DATA_s_axis_tready),

        .OSC_CTRL(),
        .OSC_CTRL_EN(OSC_CTRL_EN),
        .OSC_DIVIDER(osc_divider),
        .TEST_DAC_CTRL(),
        .TEST_DAC_CTRL_EN(TEST_DAC_CTRL_EN),
        .TEST_DAC_VALUE(TEST_DAC_VALUE)
    );


    // Simple Logic to convert values from clock domain of SPI to ADC and back
    // -------------

    // ADC System
    // -------------------

    // -- Ring oscillator based internal clock
    // -- Divide by 7 to get roughly 50Mhz, configurable via SPI
    // --------
    //

    // Add the Ring oscillator, clock divider and reset here


    // -- ADC
    // --------
    //

    // Control signal is comming from SPI Clock domain
    // Make a simple logic to synchronise the status between both
    logic adc_start_internal;
    logic adc_busy;
    always_ff @(posedge divided_clock) begin
        if (!divided_clock_resn) begin
            adc_start_internal <= 'd0;
        end else begin
            adc_start_internal <= ADC_CTRL_START;
        end
    end

    // ADC Busy -> SPI Clk
    always_ff @(posedge spi_clk or negedge ADC_CTRL_RESETN) begin
        if (!ADC_CTRL_RESETN) begin
            ADC_CTRL_BUSY <= 'd1;
        end else begin
            ADC_CTRL_BUSY <= adc_busy;
        end
    end


    logic [7:0] adc_value;
    adc_system_top adc_system_top (
        .clk(divided_clock),
        .resn(divided_clock_resn),
        .VDD(VDD),
        .GND(GND),
        .VIN(VIN),
        .VREF(VREF),
        .test_dac_enable(TEST_DAC_CTRL_EN),
        .test_dac_value(TEST_DAC_VALUE),
        .adc_start(adc_start_internal),
        .adc_busy(adc_busy),
        .adc_value(adc_value),
        .adc_valid(adc_valid),
        .adc_config_waittime(ADC_WAITTIME)
    );

    // FIFO Output
    //-------------
    wire fifo_empty;
    assign ADC_FIFO_DATA_s_axis_tvalid = !fifo_empty;
    async_fifo #(
        .WIDTH(8)
    ) adc_fifo_out (

        // Write from ADC
        // ---
        //
        .wr_clk(divided_clock),
        .wr_res_n(divided_clock_resn),
        .data_in(adc_value),
        .wr(adc_valid),
        .full(),

        // Read from SPI
        // ----
        .rd_clk(spi_clk),
        .rd_res_n(ADC_CTRL_RESETN),
        .data_out(ADC_FIFO_DATA_s_axis_tdata),
        .rd(ADC_FIFO_DATA_s_axis_tready),
        .empty(fifo_empty)

    );


endmodule
