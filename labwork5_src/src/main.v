`timescale 1ns / 1ps

module main(clk, next, rst, an, cx);
    input clk, next, rst;
    output [7:0] an, cx;
    
    reg [7:0] PC;
    wire [31:0] RD, instr;
    
    wire [6:0] op;
    wire [2:0] func3;
    wire [6:0] func7;
    wire [4:0] A1, A2, A3;
    wire [11:0] imm;
    wire [31:0] immExt;
    
    wire [31:0] RD1, RD2;
    wire [31:0] srcB;
    
    wire [2:0] aluControl;
    wire aluSrc, regWrite;
    
    wire [31:0] aluResult;
    
    wire slowClock;
    
    initial begin
        PC = 0;
    end
    
    always @(posedge next or negedge rst)
        if (!rst)
            PC <= 32'd0;
        else if (next)
            PC <= PC + 1;
    
    instructionMemory inst_mem(PC, RD);
    
    assign instr = RD & {32{next}};
    
    instructionDecoder inst_dec(RD, op, func3, func7, A1, A2, A3, imm);
    
    assign immExt = {{20{imm[11]}}, imm};
    
    controlUnit ctrl_unit(clk, op, func3, func7, aluControl, aluSrc, regWrite);
    
    assign srcB = (immExt & {32{aluSrc}}) | (RD2 & {32{~aluSrc}});
    
    alu alu(RD1, srcB, aluResult, aluControl);
    
    registerFile reg_file(clk, regWrite, A1, A2, A3, aluResult, RD1, RD2);
    
    clockDivider clk_div(clk, slowClock);
    
    sevenSegmentConverter seven_seg_conv(slowClock, aluResult, an, cx);
endmodule
