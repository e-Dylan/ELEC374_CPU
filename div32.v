`timescale 1ns / 1ps

module divl32(input wire [31:0] RegA, 
			input wire [31:0] RegB, 
            output wire [63:0] Z;
);


reg [31:0] A;
reg [31:0] Q;
reg [31:0] M;
reg q0;


Q = regA;
M = regB;
A = 32'b0;

genvar i

generate
	
	for (i = 0; i < 32; i = i + 1) begin
		{A,Q} = {A,Q} << 1;
		A = A - M;
		if (A[31] == 1'b0) begin
			Q[0] = 1;
		end
		else if (A[31] == 1'b1) begin
			Q[0] = 0;
			A = A + M;
		end
	end
endgenerate
	
	assign Z = {A, Q};

endmodule