`timescale 1ns / 1ps

module rca(
    input [3 : 0] A,
    input [3 : 0] B,
    logic Cin,
    output [3 : 0] S,
    output Cout
    );
    
    logic C0;
    logic C1;
    logic C2;
    
    fulladder fuladd0(
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin),
        .S(S[0]),
        .Cout(C0)
    );
    
    fulladder fuladd1(
        .A(A[1]),
        .B(B[1]),
        .Cin(C0),
        .S(S[1]),
        .Cout(C1)
    );
    fulladder fuladd2(
        .A(A[2]),
        .B(B[2]),
        .Cin(C1),
        .S(S[2]),
        .Cout(C2)
    );
            
    fulladder fuladd3(
        .A(A[3]),
        .B(B[3]),
        .Cin(C2),
        .S(S[3]),
        .Cout(Cout)
    );
endmodule
