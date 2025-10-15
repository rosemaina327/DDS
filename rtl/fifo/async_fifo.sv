/*
    DUAL CLOCK FIFO

    For FSM and I2C synchronisation, but can be used as building block.

    Readout FSM writes to memory with wr_clk, if WR and FIFO is !full,
    if RD is high and !empty, data is shifted out with rd_clk.

    Defaults to fallthrough mode, first word falls through, without having to clock in RD.

    Read/write pointers to keep track of fifo occupancy.
    Pointers are gray encoded, so only one bit changes at a time.
    Single bit metastability is prevented by synchronizing gray encoded pointers
    with double D-FF to each other clock domain.

    Based on: "Simulation and Synthesis Techniques for Asynchronous FIFO Design" from Cliff Cummings, Sunburst Design, Inc.

    WIP
*/

module async_fifo #(
    parameter WIDTH = 30,
    parameter PTR_WIDTH = 3,

    parameter FALLTROUGH = 1
)(
    // CLK1
    //------------------
    // Write clock
    input logic wr_clk,

    // Data in
    input logic [WIDTH-1:0] data_in,

    // CLK2
    //------------------
    // Read clock
    input logic rd_clk,

    // Data out
    output logic [WIDTH-1:0] data_out,
    
    // Reset
    input logic wr_res_n,
    input logic rd_res_n,

    // Enable
    input logic wr,
    input logic rd,

    // FIFO Status
    output logic full,
    output logic empty
);

    // Memory
    logic [WIDTH-1:0] memory [0:(1 << PTR_WIDTH)-1];

    // Pointer
    logic [PTR_WIDTH:0] wptr_bin, wptr_gry, wptr_bin_next, wptr_gry_next;
    logic [PTR_WIDTH:0] rptr_bin, rptr_gry, rptr_bin_next, rptr_gry_next;

    // R/W address
    logic [PTR_WIDTH-1:0] w_addr, r_addr;

    // Pointer sync
    logic [PTR_WIDTH:0] wptr_synced_to_rdclk, rptr_synced_to_wrclk;
    logic [PTR_WIDTH:0] rptr_to_wrclk [1:0];
    logic [PTR_WIDTH:0] wptr_to_rdclk [1:0];

    // Full/empty flags
    //--------------------------------
    always_ff @(posedge wr_clk, negedge wr_res_n) begin
        if (!wr_res_n)
            full <= 1'b0;
        else
            full <= wptr_gry_next == {~rptr_synced_to_wrclk[PTR_WIDTH:PTR_WIDTH-1], rptr_synced_to_wrclk[PTR_WIDTH-2:0]};
    end

    always_ff @(posedge rd_clk, negedge rd_res_n) begin
        if (!rd_res_n)
            empty <= 1'b1;
        else
            empty <= rptr_gry_next == wptr_synced_to_rdclk;
    end

    // Memory access
    //--------------------------------
    always_ff @( posedge wr_clk ) begin
        if(wr && !full)
            memory[w_addr] <= data_in;
    end

    generate
    if (FALLTROUGH)
        assign data_out = memory[r_addr];
    else
        always_ff @( posedge rd_clk ) begin
            if (rd && !empty)
                data_out <= memory[r_addr];
        end
    endgenerate

    // Synchronise Pointers to each other clock domain
    // ---------------------------------------------------

    always_comb begin: synced_ptr
        wptr_synced_to_rdclk = wptr_to_rdclk[1][PTR_WIDTH:0];
        rptr_synced_to_wrclk = rptr_to_wrclk[1][PTR_WIDTH:0];
    end

    always_ff @( posedge wr_clk, negedge wr_res_n) begin
        if (!wr_res_n)
            rptr_to_wrclk <= '{default:2'b00};
        else
            rptr_to_wrclk <= {rptr_to_wrclk[0], rptr_gry};
    end

    always_ff @( posedge rd_clk, negedge rd_res_n) begin
        if (!rd_res_n)
            wptr_to_rdclk <= '{default:2'b00};
        else
            wptr_to_rdclk <= {wptr_to_rdclk[0], wptr_gry};
    end

    // Write Pointer
    // ---------------------------------------------------

    always_comb begin : wrptr_bingray
        w_addr = wptr_bin[PTR_WIDTH-1:0];

        wptr_bin_next = wptr_bin + (wr & ~full);
        wptr_gry_next = (wptr_bin_next >> 1) ^ wptr_bin_next;
    end

    always_ff @ ( posedge wr_clk, negedge wr_res_n ) begin
        if(!wr_res_n) begin
            wptr_gry <= '0;
            wptr_bin <= '0;
        end
        else begin
            wptr_gry <= wptr_gry_next;
            wptr_bin <= wptr_bin_next;
        end
    end

    // Read Pointer
    // ---------------------------------------------------

    always_comb begin : rdptr_bingray
        r_addr = rptr_bin[PTR_WIDTH-1:0];

        rptr_bin_next = rptr_bin + (rd & ~empty);
        rptr_gry_next = (rptr_bin_next >> 1) ^ rptr_bin_next;
    end

    always_ff @ ( posedge rd_clk, negedge rd_res_n ) begin
        if(!rd_res_n) begin
            rptr_gry <= '0;
            rptr_bin <= '0;
        end
        else begin
            rptr_gry <= rptr_gry_next;
            rptr_bin <= rptr_bin_next;
        end
    end

endmodule