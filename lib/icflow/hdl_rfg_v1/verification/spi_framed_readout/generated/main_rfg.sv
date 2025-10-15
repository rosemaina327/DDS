module main_rfg(
    // IO
    // RFG R/W Interface,
    // --------------------,
    input  wire                clk,
    input  wire                resn,
    input  wire  [7:0]         rfg_address,
    input  wire  [7:0]         rfg_write_value,
    input  wire                rfg_write,
    input  wire                rfg_read,
    output reg                 rfg_read_valid,
    output reg  [7:0]          rfg_read_value,

    output wire [7:0]            scratchpad0,
    output wire [7:0]            scratchpad1
    );
    
    
    
    
    // Registers I/O assignments
    // ---------------
    reg [7:0] scratchpad0_reg;
    assign scratchpad0 = scratchpad0_reg;
    
    reg [7:0] scratchpad1_reg;
    assign scratchpad1 = scratchpad1_reg;
    
    
    
    // Register Bits assignments
    // ---------------
    
    
    // Register Writes
    // ---------------
    always@(posedge clk) begin
        if (!resn) begin
            scratchpad0_reg <= 0;
            scratchpad1_reg <= 0;
        end else begin
            
            
            // Single in bits are always sampled
            
            
            // Write for simple registers
            case({rfg_write,rfg_address})
                {1'b1,8'h0}: begin
                    scratchpad0_reg[7:0] <= rfg_write_value;
                end
                {1'b1,8'h1}: begin
                    scratchpad1_reg[7:0] <= rfg_write_value;
                end
                default: begin
                end
            endcase
            
            // Write for FIFO Master
            
            // Write for HW Write only
            // Write for Counter
        end
    end
    
    
    // Read for FIFO Slave
    
    
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
                    rfg_read_value <= scratchpad0_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,8'h1}: begin
                    rfg_read_value <= scratchpad1_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                default: begin
                rfg_read_valid <= 0 ;
                end
            endcase
            
        end
    end
    
    
endmodule
