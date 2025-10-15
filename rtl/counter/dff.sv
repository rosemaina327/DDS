module dff(
    input logic clk,
    input logic reset, //ative synchronous reset
    input logic enable, /*load new data only when en
able 1*/
    input logic d,
    output logic q
);
  always_ff@(posedge clk)begin
     if (reset) 
         q<=1'b0;    //reset output to 0
     else if (enable)
         q <=d; /*non-blocking assignment: upate q only when enable is high*/
                 //else:q holds its value
  end


endmodule 
