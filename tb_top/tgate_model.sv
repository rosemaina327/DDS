module TGATE(

    input wire EN,
    input wreal1driver A,
    inout wreal1driver Z
);

    assign Z = EN ? A : `wrealZState;

endmodule
