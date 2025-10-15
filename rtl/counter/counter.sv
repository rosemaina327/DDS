module counter #(parameter WIDTH=8) (
    input wire clk,
    input wire resn,
    input wire enable,
    output logic [WIDTH-1:0] cnt
);
   always_ff@(posedge clk)begin
    if(!resn)
       cnt<= '0;
    else if(enable)
       cnt <= cnt + 1;
     //else:hold value automatically
   end

endmodule
