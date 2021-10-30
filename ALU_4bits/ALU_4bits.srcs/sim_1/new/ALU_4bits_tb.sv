`timescale 1ns / 1ps

module ALU_4bits_tb();
logic [3:0] A ;
logic [3:0] B ;
logic [3:0] aluop;
logic [7:0] alures;
logic ZF,OF;
logic [7:0] right_alures;
logic right_ZF,right_OF;
reg [21:0] stim[0:3856];
reg[16:0] i;
reg[16:0] right_amounts = 0;
alu DUT(.A(A),.B(B),.aluop(aluop),.alures(alures),.ZF(ZF),.OF(OF));

initial begin
    $readmemb("C:/Users/admin/Desktop/codeivado_project/ALU_4bits_stu/ALU_4bits/ALU_4bits.sim/sim_1/behavim/testcase.txt",stim);
    for(i=0;i<3856;i=i+1) begin
       {A,B,aluop,right_alures,right_ZF,right_OF}=stim[i];#1;
       if(alures==right_alures && ZF==right_ZF && OF==right_OF) begin 
            $display("time:",$time,": test pass!");
            right_amounts = right_amounts + 1;
       end
       else begin
          $display("time:",$time,": Error:A=%b£¬B=%b,aluop=%b,alures=%b,ZF=%b,OF=%b,right_alures=%b,right_ZF=%b,right_OF=%b",A,B,aluop,alures,ZF,OF,right_alures,right_ZF,right_OF);
       end
     end
     $display("the amounts of right compution is %d",right_amounts);
end 
        
endmodule