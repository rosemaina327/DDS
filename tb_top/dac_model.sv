module DACR2R_8BITV1_PWRRING(

    input wire [7:0] dac,
    output real dacout
);


    // Statically compute comp_ref, DAC of vdac to analog value
    always_comb begin
        dacout = (dac * 1.8) / (2 ** 8 - 1);
    end

endmodule
