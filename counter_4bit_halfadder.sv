module counter_4bit(
    input  wire clk, 
    input  wire resn,       // active-low reset
    output logic [3:0] cnt  // counter output
);

  // internal wires
  logic [3:0] d;      // DFF inputs
  logic [3:0] q;      // DFF outputs
  logic [3:0] carry;  // carries from half-adders

  // LSB half-adder: q[0] + 1
  halfadder ha0 (.a(q[0]), .b(1'b1),     .sum(d[0]), .carry(carry[0]));

  // Next bits: q[n] + carry[n-1]
  halfadder ha1 (.a(q[1]), .b(carry[0]), .sum(d[1]), .carry(carry[1]));
  halfadder ha2 (.a(q[2]), .b(carry[1]), .sum(d[2]), .carry(carry[2]));
  halfadder ha3 (.a(q[3]), .b(carry[2]), .sum(d[3]), .carry(carry[3]));

  // Flip-flops with synchronous reset
  genvar i;
  generate
    for (i = 0; i < 4; i++) begin : dffs
      always_ff @(posedge clk) begin
        if (!resn)
          q[i] <= 1'b0;
        else
          q[i] <= d[i];
      end
    end
  endgenerate

  // Drive output
  assign cnt = q;

endmodule

