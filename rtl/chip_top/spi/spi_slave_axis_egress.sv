
/**
 * This Egress just sequentially loads a wide register to 8bit Egress Fifo interface
 * The data is made available through a simple FIFO Interface
 *
 * This module is compliant with 1 Byte Header
 *
 * ! Warning, this is QSPI with 2 bits on the MISO path, so outputs are done 2 bits at a time
 *  This module send LSB first
 */
 module spi_slave_axis_egress #(
        parameter ASYNC_RES = 1 ,
        parameter MSB_FIRST = 1,
        parameter MISO_SIZE = 1
        ) (


        input  wire                     spi_csn,
        input  wire                     spi_clk,
        output wire [MISO_SIZE-1:0]     spi_miso,



        input  wire [7:0]               s_axis_tdata,
        input  wire                     s_axis_tvalid,
        output reg                      s_axis_tready,
        // TUser Byte is used as placeholder if no data is available to be send
        input  wire [7:0]               s_axis_tuser
     );


     // State

    // Byte Output
    //----------
    reg  [7:0] egress_byte_in;
    reg  first_bit;
    reg  [7:0] egress_byte;
    reg  [2:0] egress_bit_counter;
    reg egress_bit_counter_last;
    //wire       egress_bit_counter_last = MISO_SIZE == 1  ?  (egress_bit_counter) == 7 : (egress_bit_counter) == 5;
    wire       egress_bit_counter_last_next = MISO_SIZE == 1  ?  (egress_bit_counter) == 6 : (egress_bit_counter) == 4;

    wire input_byte_valid = s_axis_tvalid & s_axis_tready;

    generate

        if (MISO_SIZE == 1) begin
            if (MSB_FIRST) begin
                assign spi_miso[0] = !spi_csn ? {egress_byte[7]} : 1'bz;
            end
            else begin
                assign spi_miso[0] = !spi_csn ? {egress_byte[0]} : 1'bz;
            end

        end
        else begin
            if (MSB_FIRST) begin
                assign spi_miso[1:0] = !spi_csn ? {egress_byte[7:6]} : 2'bzz;
            end
            else begin
                assign spi_miso[1:0] = !spi_csn ? {egress_byte[1:0]} : 2'bzz;
            end
        end


    endgenerate



     // State
     //-----------
     enum {WAIT,IDLE , DATA} state;

     // MTU Reach



     // MISO Out
     //---------------------
     task automatic reset();
        state                   <= WAIT;

        egress_byte             <= s_axis_tuser;
        egress_bit_counter      <= 3'b000;

        s_axis_tready           <= 1'b0;
        egress_bit_counter_last <= 1'b0;

    endtask
    task automatic send();

        egress_bit_counter_last <= egress_bit_counter_last_next;
        s_axis_tready           <= egress_bit_counter_last_next;



        // Output on Posedge
        //-----------------
        if (state==WAIT) begin
            state <= DATA;
        end
        else begin

            // Counter
            if (MISO_SIZE == 1) begin
                egress_bit_counter <= egress_bit_counter + 1'd1;
            end else begin
                egress_bit_counter <= egress_bit_counter + 2'd2;
            end

            if (egress_bit_counter_last & input_byte_valid) begin
                egress_byte <= s_axis_tdata;
            end
            else if (egress_bit_counter_last) begin
                egress_byte <= s_axis_tuser;
            end
            else begin
                if (MISO_SIZE == 1) begin

                    if (MSB_FIRST)
                        egress_byte <= {egress_byte[6:0],1'b0};
                    else
                        egress_byte <= {1'b0,egress_byte[7:1]};

                end else begin
                    if (MSB_FIRST)
                        egress_byte <= {egress_byte[5:0],2'b00};
                    else
                        egress_byte <= {2'b00,egress_byte[7:2]};
                end
            end

        end


    endtask


    always @(posedge spi_clk or posedge spi_csn) begin
        if ( spi_csn) begin
            reset();
        end else begin
            send();
        end
    end





 endmodule
