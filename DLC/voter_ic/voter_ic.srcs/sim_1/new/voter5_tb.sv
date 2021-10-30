`timescale 1ns / 1ps

module test_for_voter5();
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
