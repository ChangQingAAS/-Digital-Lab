`timescale 1ns / 1ps

module dec_74LS139(

    input   S,[1:0] D,
    output   logic   [3:0] Y
    );                            
    
    reg       [3:0] Y=0;                 //作为变量要声明为reg
    always_comb begin
        
        if(~S) 
             case(D)
                  2'b11:Y= 4'b0111;
                  2'b10:Y= 4'b1011;
                  2'b01:Y= 4'b1101;
                  2'b00:Y= 4'b1110;
                  default: Y= 4'b1111;              
             endcase
         else
             Y= 4'b1111;
            
    end
endmodule
