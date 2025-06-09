`timescale 1ns / 1ps

module topModule (
    input clk,
    input [31:0] A,
    input [31:0] B,
    input [1:0] opcode,
    input WE3,
    input [4:0] A1, 
    input [4:0] A2, 
    input [4:0] A3,
    input [31:0] WD3,
    output [31:0] C,
    output [31:0] RD1, 
    output [31:0] RD2
);

    alu alu_inst (
        .A(A),
        .B(B),
        .C(C),
        .clk(clk),
        .opcode(opcode)
    );

    registerFile regfile_inst (
        .clk(clk),
        .WE3(WE3),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .RD1(RD1),
        .RD2(RD2),
        .WD3(WD3)
    );

endmodule