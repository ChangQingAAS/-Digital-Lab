`timescale 1ns / 1ps
module test_for_138;
    reg        g1;
    reg        g2;
    reg        g3;
    reg  [2:0] a;
    wire [7:0] y;
    
    dec_74LS138 u1(g1,g2,g3,a,y);
     initial begin
         g1=0;
         g2=0;
         g3=0;
         a=0;
         #100;
         g1=1;
         g2=0;
         g3=0;
     end
     always #100 a=a+1;
endmodule