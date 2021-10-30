`timescale 1ns / 1ps

module dec_74LS138(

    input   G,G2A,G2B,[2:0] D,
    output   logic   [7:0] Y
    
    );                            
    
    reg       [7:0] Y=0;                 //作为变量要声明为reg
    always_comb begin
        
         if(G && ~G2A && ~G2B) 
             case(D)
              7:Y= 8'b01111111;
              6:Y= 8'b10111111;
              5:Y= 8'b11011111;
              4:Y= 8'b11101111;
              3:Y= 8'b11110111;
              2:Y= 8'b11111011;
              1:Y= 8'b11111101;
              0:Y= 8'b11111110;
              default: Y= 8'b11111111;              
             endcase
         else
             Y= 8'b11111111;
    end
endmodule
