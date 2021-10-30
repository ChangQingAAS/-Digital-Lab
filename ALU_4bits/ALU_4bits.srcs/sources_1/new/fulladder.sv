`timescale 1ns / 1ps

module fulladder(
    input A,
    input B,
    input Cin,
    output logic S,
    output logic Cout
    );
    always_comb begin
    
        case({Cin, A, B})
            3'b000 : {Cout, S} = 2'b00;
            3'b001 : {Cout, S} = 2'b01;
            3'b010 : {Cout, S} = 2'b01;
            3'b011 : {Cout, S} = 2'b10;
            3'b100 : {Cout, S} = 2'b01;
            3'b101 : {Cout, S} = 2'b10;
            3'b110 : {Cout, S} = 2'b10;
            3'b111 : {Cout, S} = 2'b11;
            default : {Cout, S} = 2'b11;
        endcase
        
    end
    // 上面的always 语句可以写成：
//    assign S = a ^ b ^ Cin;
//    assign Cout = a& b | (Cin & (a ^ b));
endmodule