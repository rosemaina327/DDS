module TMRRegA #(
    parameter WIDTH = 8,
    parameter RESET_VAL = 8'd0,
    parameter ASYNC_REFRESH=0 // If 1, the refresh will be done with a latch on clock 
    ) (
    input   wire                clk,
    input   wire                resn,
    input   wire [WIDTH-1:0]    write_value,
    input   wire                write,
    output  wire [WIDTH-1:0]    reg_value_tmr
);


    // Register triplicated
    //---------
    reg [WIDTH-1:0] reg_A_tmr;
    reg [WIDTH-1:0] reg_B_tmr;
    reg [WIDTH-1:0] reg_C_tmr;


    // Majority Voter
    //--------
    bit error_tmr;
    majorityVoter #(.WIDTH(WIDTH)) reg_intVoter (
        .inA(reg_A_tmr),
        .inB(reg_B_tmr),
        .inC(reg_C_tmr),
        .out(reg_value_tmr),
        .tmrErr(error_tmr)
    );

    // Logic
    //-----------
    always_ff @(posedge clk) begin
        if (!resn) begin
            reg_A_tmr <= RESET_VAL;
            reg_B_tmr <= RESET_VAL;
            reg_C_tmr <= RESET_VAL;
        end
        else begin
            if (write) begin
                reg_A_tmr <= write_value;
                reg_B_tmr <= write_value;
                reg_C_tmr <= write_value;
            end
            else if (error_tmr) begin
                reg_A_tmr <= reg_value_tmr;
                reg_B_tmr <= reg_value_tmr;
                reg_C_tmr <= reg_value_tmr;
            end
        end
    end

endmodule 