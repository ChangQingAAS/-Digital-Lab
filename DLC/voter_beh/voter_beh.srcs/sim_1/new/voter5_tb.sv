`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/16 20:18:09
// Design Name: 
// Module Name: voter5_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module voter5_tb();
    logic [4:0] vote;
    logic  pass;
    integer i;
    voter5 DUT(.vote(vote),.pass(pass));
    initial begin
        for(i=0;i<32;i=i+1) begin
            vote=i;
            #20;   
        end
    end
    initial begin
        $timeformat(-9,0,"ns",5);
        $monitor("At time %t: vote=%b,pass=%b",$time,vote,pass);
    end
endmodule

