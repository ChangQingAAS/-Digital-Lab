`timescale 1ns / 1ps

module alu(
    input [3 : 0] A,
    input [3 : 0] B,
    input [3 : 0] aluop,
    output logic [7 : 0] alures,
    output logic ZF,
    output logic OF
    );
    
    longint B_low_3;
    logic x0,x1,x2,x3,A_lt_B;
    logic type_flag ;
    
   logic [3:0] sum;
   logic Cout;
   logic [3:0] Cin;
   assign Cin = aluop[2]==0 ? 4'b0000 : 4'b1111;
//   �ӷ�ʱCin[0]=0�� ����ʱCin[0]=1
   rca rrr(.A(A),.B((~B&Cin)|(B&(~Cin))),.Cin(Cin[0]),.S(sum),.Cout(Cout));
    
    always_comb begin
        OF = 0;
        case(aluop)
//          0000 AND ��λ�� alures0 = A & B��alures 1 = 0
            4'b0000: begin
                alures[3:0] = A & B;
                alures[7:4] = 4'b0000;
            end
//          0001 OR ��λ�� alures0 = A | B��alures1 = 0
            4'b0001: begin
                alures[3:0] = A | B;
                alures[7:4] = 4'b0000;
            end
//          0010 XOR ��λ��� alures0 = A ? B��alures1 = 0
            4'b0010: begin
                alures[7:4] = 4'b0000;
                alures[3:0] = A ^ B;
//              ��һ�д����дΪ��
//                alures[3] = ((~A[3]) &  B[3]) | (A[3] & (~B[3]));
//                alures[2] = ((~A[2]) &  B[2]) | (A[2] & (~B[2]));
//                alures[1] = ((~A[1]) &  B[1]) | (A[1] & (~B[1]));
//                alures[0] = ((~A[0]) &  B[0]) | (A[0] & (~B[0]));
            end
//          0011 NAND ��λ��� alures0 = ~(A & B)��alures1 = 0
            4'b0011: begin
                alures[3:0] = ~(A & B);
                alures[7:4] = 4'b0000;
            end
//          0100 NOT �߼��� alures0 = ~A��alures1 = 0
            4'b0100: begin
                alures[3:0] = ~A;
                alures[7:4] = 4'b0000;
            end
//          0101 SLL �߼����� alures0 = A << B��B ȡ�� 3 λ����alures1 = 0
            4'b0101: begin
                alures[7:4] = 4'b0000;
//                B_low_3 = longint'(B[2:0]);
                //��Ϊ�����Ƶ�λ��= A�ĳ��ȼ�4λ����Ҫ���B�ĵ���λʹ�������ƶ�7λ����˲��������ж�
//                alures[3:0] = A[3:0];
//                repeat(B_low_3) begin
//                    alures[3:0] = {alures[2:0],1'b0};
//                end
                // Ҳ��дΪ��
                 alures[3:0] = A << B[2:0];
            end
//          0110 SRL �߼����� alures0 = A >> B��B ȡ�� 3 λ����alures1 = 0
            4'b0110: begin
                alures[7:4] = 4'b0000;
//                B_low_3 = longint'(B[2:0]);
//                //��Ϊ�����Ƶ�λ��= A�ĳ��ȼ�4λ����Ҫ���B�ĵ���λʹ�������ƶ�7λ����˲��������ж�
//                 alures[3:0] = A[3:0];
//                repeat(B_low_3) begin
//                    alures[3:0] = {1'b0,alures[3:1]};
//                end
                // Ҳ��дΪ��
                 alures[3:0] = A >> B[2:0];
            end
//          0111 SRA �������� alures0 = A>>>B��B ȡ�� 3 λ����alures1 = 0

            4'b0111: begin
                alures[7:4] = 4'b0000;
//            //��Ϊ�����Ƶ�λ��= A�ĳ��ȼ�4λ����Ҫ���B�ĵ���λʹ�������ƶ�7λ����˲��������ж�
//                B_low_3 = longint'(B[2:0]);
//                type_flag = A[3];
//                alures[3:0] = A[3:0];
//                repeat(B_low_3) begin
//                    alures[3:0] = {type_flag,alures[3:1]};
//                end
                //Ҳ��дΪ��
                alures[3:0] = $signed(A) >>> B[2:0];
            end
//          1000 MULU �޷������˷� alures0 = (A * B)[3:0]��alures1 = (A * B)[7:4]
            4'b1000: begin
                alures[7:0] = A * B;
            end
//          1001 MUL �з������˷� alures0 = (A * B)[3:0]��alures1 = (A * B)[7:4]
            4'b1001: begin
                alures[7:0]={{4{A[3]}},A}*{{4{B[3]}},B};
            end
//          1010 ADD �з������ӷ� alures0 = A + B��alures1 = 0����Ҫ���� ov
            4'b1010: begin
                alures[3:0]=sum;
                alures[7:4]=4'b0000;
                // ������
                if((A[3]==B[3])&&(A[3] != sum[3]))  begin 
                    OF=1;
                 end
            end
//          1011 ADDU �޷������ӷ� alures0 = A + B��alures1 = 0
            4'b1011: begin
                alures[3:0] = sum[3:0]; 
                alures[7:4] = 0;
            end
//          1100 SUB �з��������� alures0 = A - B��alures1 = 0����Ҫ���� ov
            4'b1100: begin
               alures[3:0]=sum[3:0];
               alures[7:4]=4'b0000; 
               // ������
               if((A[3]!=B[3]) && (sum[3] != A[3]))begin 
                 OF=1;
               end 
            end
//          1101 SUBU �޷��������� alures0 = A - B��alures1 = 0
            4'b1101: begin
                alures[3:0] = sum[3:0]; 
                alures[7:4] = 4'b0000;
            end
//          1110 SLT �з������Ƚ� alures0 = (A < B)? 1 : 0��alures1 = 0
            4'b1110: begin;
                alures = $signed(A) < $signed(B) ? 8'b00000001: 8'b00000000;
            end
//          1111 SLTU �޷������Ƚ� alures0 = (A < B)? 1 : 0��alures1 = 0
            4'b1111: begin
                alures = A < B ? 8'b00000001: 8'b00000000;
                //�Ƚ�������дΪ��
                x0=((A[0])&(B[0]))||((!A[0])&(!B[0])); 
                x1=((A[1])&(B[1]))||((!A[1])&(!B[1])); 
                x2=((A[2])&(B[2]))||((!A[2])&(!B[2])); 
                x3=((A[3])&(B[3]))||((!A[3])&(!B[3])); 
                A_lt_B =  ((!A[3])&B[3])||(x3&(!A[2])&B[2])||(x3&x2&(!A[1])&B[1])||(x3&x2&x1&(!A[0])&B[0]);
                if(A_lt_B)
                    alures[3:0] = 4'b0001;
                else
                    alures[3:0] = 4'b0000;
            end
//          Ĭ�����
            default: begin
            end
        endcase
        
        ZF = !alures;
    end
endmodule


