module main_rfg(
    // IO
    // RFG R/W Interface,
    // --------------------,
    input  wire                  clk,
    input  wire                  resn,
    input  wire  [15:0]          rfg_address,
    output reg                   rfg_address_valid,
    input  wire  [7:0]           rfg_write_value,
    output reg                   rfg_write_valid,
    input  wire                  rfg_write,
    input  wire                  rfg_write_last,
    input  wire                  rfg_read,
    output reg                   rfg_read_valid,
    output reg  [7:0]            rfg_read_value,

    output wire [7:0]            OSC_CTRL,
    output wire                  OSC_CTRL_EN,
    output wire [7:0]            OSC_DIVIDER,
    output wire [7:0]            ADC_CTRL,
    output wire                  ADC_CTRL_START,
    input  wire                  ADC_CTRL_BUSY,
    output wire                  ADC_CTRL_RESET,
    output wire [31:0]            ADC_WAITTIME,
    output wire [7:0]            ADC_FIFO_STATUS,
    output wire                  ADC_FIFO_STATUS_empty,
    // AXIS Slave interface to read from FIFO ADC_FIFO_DATA,
    // --------------------,
    input  wire [7:0]            ADC_FIFO_DATA_s_axis_tdata,
    input  wire                  ADC_FIFO_DATA_s_axis_tvalid,
    output wire                  ADC_FIFO_DATA_s_axis_tready,
    output wire [7:0]            TEST_DAC_CTRL,
    output wire                  TEST_DAC_CTRL_EN,
    output wire [7:0]            TEST_DAC_VALUE
    );
    
    
    
    
    // Registers I/O assignments
    // ---------------
    logic [7:0] OSC_CTRL_reg;
    assign OSC_CTRL = OSC_CTRL_reg;
    
    logic [7:0] OSC_DIVIDER_reg;
    assign OSC_DIVIDER = OSC_DIVIDER_reg;
    
    logic [7:0] ADC_CTRL_reg;
    assign ADC_CTRL = ADC_CTRL_reg;
    
    logic [31:0] ADC_WAITTIME_reg;
    assign ADC_WAITTIME = ADC_WAITTIME_reg;
    
    logic [7:0] ADC_FIFO_STATUS_reg;
    assign ADC_FIFO_STATUS = ADC_FIFO_STATUS_reg;
    
    logic [7:0] TEST_DAC_CTRL_reg;
    assign TEST_DAC_CTRL = TEST_DAC_CTRL_reg;
    
    logic [7:0] TEST_DAC_VALUE_reg;
    assign TEST_DAC_VALUE = TEST_DAC_VALUE_reg;
    
    
    
    // Register Bits assignments
    // ---------------
    assign OSC_CTRL_EN = OSC_CTRL_reg[0];
    assign ADC_CTRL_START = ADC_CTRL_reg[0];
    assign ADC_CTRL_RESET = ADC_CTRL_reg[2];
    assign ADC_FIFO_STATUS_empty = ADC_FIFO_STATUS_reg[0];
    assign TEST_DAC_CTRL_EN = TEST_DAC_CTRL_reg[0];
    
    
    // TMR Registers (if any)
    // ---------------
    
    // Register Writes
    // ---------------
    always_ff @(posedge clk) begin
        if (!resn) begin
            rfg_write_valid <= 'd0;
            OSC_CTRL_reg <= '0;
            OSC_DIVIDER_reg <= 8'd3;
            ADC_CTRL_reg <= '0;
            ADC_WAITTIME_reg <= 32'd16;
            ADC_FIFO_STATUS_reg <= '0;
            TEST_DAC_CTRL_reg <= '0;
            TEST_DAC_VALUE_reg <= '0;
        end else begin
            
            
            // Single in bits are always sampled
            ADC_CTRL_reg[1] <= ADC_CTRL_BUSY;
            
            
            // Write for simple registers
            case({rfg_write,rfg_address})
                {1'b1,16'h0}: begin
                    OSC_CTRL_reg[7:0] <= rfg_write_value;
                    rfg_write_valid <= 'd1;
                end
                {1'b1,16'h1}: begin
                    OSC_DIVIDER_reg[7:0] <= rfg_write_value;
                    rfg_write_valid <= 'd1;
                end
                {1'b1,16'h2}: begin
                    ADC_CTRL_reg[7:0] <= rfg_write_value;
                    rfg_write_valid <= 'd1;
                end
                {1'b1,16'h3}: begin
                    ADC_WAITTIME_reg[7:0] <= rfg_write_value;
                    rfg_write_valid <= 'd1;
                end
                {1'b1,16'h4}: begin
                    ADC_WAITTIME_reg[15:8] <= rfg_write_value;
                    rfg_write_valid <= 'd1;
                end
                {1'b1,16'h5}: begin
                    ADC_WAITTIME_reg[23:16] <= rfg_write_value;
                    rfg_write_valid <= 'd1;
                end
                {1'b1,16'h6}: begin
                    ADC_WAITTIME_reg[31:24] <= rfg_write_value;
                    rfg_write_valid <= 'd1;
                end
                {1'b1,16'h7}: begin
                    ADC_FIFO_STATUS_reg[7:0] <= rfg_write_value;
                    rfg_write_valid <= 'd1;
                end
                {1'b1,16'h9}: begin
                    TEST_DAC_CTRL_reg[7:0] <= rfg_write_value;
                    rfg_write_valid <= 'd1;
                end
                {1'b1,16'ha}: begin
                    TEST_DAC_VALUE_reg[7:0] <= rfg_write_value;
                    rfg_write_valid <= 'd1;
                end
                default: begin
                    rfg_write_valid <= 'd0 ;
                end
            endcase
            
            // Write for FIFO Master
            
            // Writes for HW Write only
            // Writes for Counter
        end
    end
    
    
    // Read for FIFO Slave
    // ---------------
    assign ADC_FIFO_DATA_s_axis_tready = rfg_read && rfg_address==16'h8;
    
    
    // Register Read
    // ---------------
    always_ff@(posedge clk) begin
        if (!resn) begin
            rfg_read_valid <= 0;
            rfg_read_value <= 0;
        end else begin
            // Read for simple registers
            case({rfg_read,rfg_address})
                {1'b1,16'h0}: begin
                    rfg_read_value <= OSC_CTRL_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1}: begin
                    rfg_read_value <= OSC_DIVIDER_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2}: begin
                    rfg_read_value <= ADC_CTRL_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3}: begin
                    rfg_read_value <= ADC_WAITTIME_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4}: begin
                    rfg_read_value <= ADC_WAITTIME_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5}: begin
                    rfg_read_value <= ADC_WAITTIME_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6}: begin
                    rfg_read_value <= ADC_WAITTIME_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7}: begin
                    rfg_read_value <= ADC_FIFO_STATUS_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8}: begin
                    rfg_read_value <= ADC_FIFO_DATA_s_axis_tvalid ? ADC_FIFO_DATA_s_axis_tdata : 16'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9}: begin
                    rfg_read_value <= TEST_DAC_CTRL_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha}: begin
                    rfg_read_value <= TEST_DAC_VALUE_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                default: begin
                    rfg_read_valid <= 0 ;
                end
            endcase
            
        end
    end
    
    
    
    
    // Simple Address valid bit out
    always_ff@(posedge clk) begin
        if (!resn) begin
            rfg_address_valid <= 'd0;
        end else begin
            rfg_address_valid <= rfg_address >= 16'd0 && rfg_address <= 16'ha;
        end
    end
    
    
endmodule
