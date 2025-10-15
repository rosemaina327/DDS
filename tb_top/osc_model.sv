/**
Simple model of Ring Oscillator

Output clock is roughly 350Mhz

*/
module OSC_RINGTOPV1_NOVAR(

    input wire EN,
    output logic CKOUT
);


    initial begin
        CKOUT = 0;
        forever begin
            wait(EN==1'b1);
            #1.43ns CKOUT = EN ? !CKOUT : CKOUT;
        end
    end



endmodule
