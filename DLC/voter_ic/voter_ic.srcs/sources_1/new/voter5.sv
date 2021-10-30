`timescale 1ns / 1ps

module voter5(
    input logic [4:0] vote,
    output  logic pass
); 
    
    logic [7:0] out_3_8_00;
    logic [7:0] out_3_8_01;
    logic [7:0] out_3_8_10;
    logic [7:0] out_3_8_11;

    logic [3:0] out_2_4;
    // pass_number 为pass的不同部分，通过操作，可得到pass
    logic pass_3;
    logic pass_2;
    logic pass_1;
    logic pass_0;
        
    dec_74LS139  LS_2_4 (.S(1'b0),.D(vote[4:3]),.Y(out_2_4));
    
//    dec_74LS138 LS_3_8_00 (.G(~out_2_4[0]),.G2A(1'b0),.G2B(1'b0),.D(I[2:0]),.Y(out_3_8_00));
//    dec_74LS138 LS_3_8_01 (.G(~out_2_4[1]),.G2A(1'b0),.G2B(1'b0),.D(I[2:0]),.Y(out_3_8_01));
//    dec_74LS138 LS_3_8_10 (.G(~out_2_4[2]),.G2A(1'b0),.G2B(1'b0),.D(I[2:0]),.Y(out_3_8_10));
//    dec_74LS138 LS_3_8_11 (.G(~out_2_4[3]),.G2A(1'b0),.G2B(1'b0),.D(I[2:0]),.Y(out_3_8_11));
//   上述代码可以转为：
    dec_74LS138 LS_3_8_00 (.G(1'b1),.G2A(out_2_4[0]),.G2B(out_2_4[0]),.D(vote[2:0]),.Y(out_3_8_00));
    dec_74LS138 LS_3_8_01 (.G(1'b1),.G2A(out_2_4[1]),.G2B(out_2_4[1]),.D(vote[2:0]),.Y(out_3_8_01));
    dec_74LS138 LS_3_8_10 (.G(1'b1),.G2A(out_2_4[2]),.G2B(out_2_4[2]),.D(vote[2:0]),.Y(out_3_8_10));
    dec_74LS138 LS_3_8_11 (.G(1'b1),.G2A(out_2_4[3]),.G2B(out_2_4[3]),.D(vote[2:0]),.Y(out_3_8_11));
    
//    assign pass = (~out_3_8_00[7]
//                |~out_3_8_01[3]|~out_3_8_01[5]|~out_3_8_01[6]|~out_3_8_01[7]
//                |~out_3_8_10[3]|~out_3_8_10[5]|~out_3_8_10[6]|~out_3_8_10[7]
//                |~out_3_8_11[1]|~out_3_8_11[2]|~out_3_8_11[3]|~out_3_8_11[4]|~out_3_8_11[5]|~out_3_8_11[6]|~out_3_8_11[7]);  
//     上述代码可以转为：
//     assign pass = ~(out_3_8_00[7]
//                   & out_3_8_01[3] & out_3_8_01[5]&out_3_8_01[6]&out_3_8_01[7]
//                   &out_3_8_10[3]&out_3_8_10[5]&out_3_8_10[6]&out_3_8_10[7]
//                   &out_3_8_11[1]&out_3_8_11[2]&out_3_8_11[3]&out_3_8_11[4]&out_3_8_11[5]&out_3_8_11[6]&out_3_8_11[7]);  
//    为简化电路，可写为：
//     assign pass = ~(out_3_8_00[7]
//                  & out_3_8_01[3] & out_3_8_01[5]&out_3_8_01[6]&out_3_8_01[7]
//                  &out_3_8_10[3]&out_3_8_10[5]&out_3_8_10[6]&out_3_8_10[7]
//                  &(~out_3_8_11[0] | out_2_4[3])); 

//      拆解
    assign pass_0 = out_3_8_00[7];
    assign pass_1 = out_3_8_01[3] & out_3_8_01[5] & out_3_8_01[6] & out_3_8_01[7];
    assign pass_2 = out_3_8_10[3] & out_3_8_10[5] & out_3_8_10[6] & out_3_8_10[7];
  	assign pass_3 = (~out_3_8_11[0] | out_2_4[3]);
    assign pass = ~(pass_0 & pass_1 & pass_2 & pass_3);
    
endmodule