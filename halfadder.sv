
module halfadder(
    input  logic a,     // input A
    input  logic b,     // input B
    output logic sum,   // Sum = A ^ B
    output logic carry  // Carry = A & B
);

  always_comb begin
    sum   = a ^ b;   // XOR
    carry = a & b;   // AND
endmodule

