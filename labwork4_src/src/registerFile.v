module registerFile(
    output reg [31:0] RD1, 
    output reg [31:0] RD2,
    input [31:0] WD3,
    input [4:0] A1, 
    input [4:0] A2, 
    input [4:0] A3,   
    input clk, 
    input WE3
);

    reg [31:0] registerFile[31:0]; 

    always @(posedge clk) begin
        if (WE3) begin 
            registerFile[A3] <= WD3; 
        end else begin 
            RD1 <= registerFile[A1]; 
            RD2 <= registerFile[A2]; 
        end
    end 
endmodule