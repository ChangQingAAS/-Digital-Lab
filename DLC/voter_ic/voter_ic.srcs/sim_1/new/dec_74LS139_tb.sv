`timescale 1ns / 1ps

module test_for_139;
    reg        s;
    reg  [1:0] d;
    wire [3:0] y;
    
    dec_74LS139 u1(s,d,y);
     initial begin
         s=1;
         d=0;
         #100;
         s=0;
     end
     always #100 d=d+1;
endmodule
