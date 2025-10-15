module main_rfg(
    // IO
    // RFG R/W Interface,
    // --------------------,
    input  wire                clk,
    input  wire                resn,
    input  wire  [7:0]         rfg_address,
    input  wire  [7:0]         rfg_write_value,
    input  wire                rfg_write,
    input  wire                rfg_write_last,
    input  wire                rfg_read,
    output reg                 rfg_read_valid,
    output reg  [7:0]          rfg_read_value,

    output wire [7:0]            io_led,
    output wire [31:0]            blink,
    output  reg                  blink_interrupt,
    // AXIS Master interface to write to FIFO loopback_fifo_w,
    // --------------------,
    output reg [7:0]             loopback_fifo_w_m_axis_tdata,
    output reg                   loopback_fifo_w_m_axis_tvalid,
    input  wire                  loopback_fifo_w_m_axis_tready,
    // AXIS Slave interface to read from FIFO loopback_fifo_r,
    // --------------------,
    input  wire [7:0]            loopback_fifo_r_s_axis_tdata,
    input  wire                  loopback_fifo_r_s_axis_tvalid,
    output wire                  loopback_fifo_r_s_axis_tready,
    output wire [31:0]            blink_match
    );
    
    
    reg blink_up;
    
    
    // Registers I/O assignments
    // ---------------
    reg [7:0] io_led_reg;
    assign io_led = io_led_reg;
    
    reg [31:0] blink_reg;
    assign blink = blink_reg;
    
    reg [31:0] blink_match_reg;
    assign blink_match = blink_match_reg;
    
    
    
    // Register Bits assignments
    // ---------------
    
    
    // Register Writes
    // ---------------
    always@(posedge clk) begin
        if (!resn) begin
            io_led_reg <= 0;
            blink_reg <= 0;
            blink_up <= 1'b1;
            loopback_fifo_w_m_axis_tvalid <= 1'b0;
            blink_match_reg <= 32'd40000000;
        end else begin
            
            
            // Single in bits are always sampled
            
            
            // Write for simple registers
            case({rfg_write,rfg_address})
                {1'b1,8'h0}: begin
                    io_led_reg[7:0] <= rfg_write_value;
                end
                {1'b1,8'h1}: begin
                    blink_reg[7:0] <= rfg_write_value;
                end
                {1'b1,8'h2}: begin
                    blink_reg[15:8] <= rfg_write_value;
                end
                {1'b1,8'h3}: begin
                    blink_reg[23:16] <= rfg_write_value;
                end
                {1'b1,8'h4}: begin
                    blink_reg[31:24] <= rfg_write_value;
                end
                {1'b1,8'h7}: begin
                    blink_match_reg[7:0] <= rfg_write_value;
                end
                {1'b1,8'h8}: begin
                    blink_match_reg[15:8] <= rfg_write_value;
                end
                {1'b1,8'h9}: begin
                    blink_match_reg[23:16] <= rfg_write_value;
                end
                {1'b1,8'ha}: begin
                    blink_match_reg[31:24] <= rfg_write_value;
                end
                default: begin
                end
            endcase
            
            // Write for FIFO Master
            if(rfg_write && rfg_address==8'h5) begin
                loopback_fifo_w_m_axis_tvalid <= 1'b1;
                loopback_fifo_w_m_axis_tdata  <= rfg_write_value;
            end else begin
                loopback_fifo_w_m_axis_tvalid <= 1'b0;
            end
            
            // Write for HW Write only
            // Write for Counter
            if(!(rfg_write && rfg_address==8'h1)) begin
                blink_reg <= blink_up ? blink_reg + 1 : blink_reg -1 ;
            end
            if(( (blink_up && blink_reg == (blink_match_reg - 1)) || (!blink_up && blink_reg==1 )) ) begin
                blink_interrupt <= 1'b1;
                blink_up <= !blink_up;
            end else begin
                blink_interrupt <= 1'b0;
            end
        end
    end
    
    
    // Read for FIFO Slave
    assign loopback_fifo_r_s_axis_tready = rfg_read && rfg_address==8'h6;
    
    
    // Register Read
    // ---------------
    always@(posedge clk) begin
        if (!resn) begin
            rfg_read_valid <= 0;
            rfg_read_value <= 0;
        end else begin
            // Read for simple registers
            case({rfg_read,rfg_address})
                {1'b1,8'h0}: begin
                    rfg_read_value <= io_led_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,8'h1}: begin
                    rfg_read_value <= blink_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,8'h2}: begin
                    rfg_read_value <= blink_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,8'h3}: begin
                    rfg_read_value <= blink_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,8'h4}: begin
                    rfg_read_value <= blink_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,8'h6}: begin
                    rfg_read_value <= loopback_fifo_r_s_axis_tvalid ? loopback_fifo_r_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,8'h7}: begin
                    rfg_read_value <= blink_match_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,8'h8}: begin
                    rfg_read_value <= blink_match_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,8'h9}: begin
                    rfg_read_value <= blink_match_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,8'ha}: begin
                    rfg_read_value <= blink_match_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                default: begin
                rfg_read_valid <= 0 ;
                end
            endcase
            
        end
    end
    
    
endmodule
