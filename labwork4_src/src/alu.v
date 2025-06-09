module alu(
    input [31:0] A, 
    input [31:0] B,
    output reg [31:0] C,
    input clk,
    input [1:0] opcode
);

    always @(posedge clk) begin
        case(opcode)
            2'b00: C <= A + B;
            2'b01: C <= A - B;
            2'b10: C <= A << B;
            2'b11: C <= A >> B;
        endcase
    end
endmodule