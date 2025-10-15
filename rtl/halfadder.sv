 module halfadder(
     input a, // A
     input b, // B
     output logic sum, // Sum out
     output logic carry // Carry Out
 );

     always_comb begin
         sum = a ^ b;
          carry = a & b;
     end


 endmodule
