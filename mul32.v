module mul32(
    input wire [31:0] RegA, 
    input wire [31:0] RegB, 
    output wire [63:0] Z
);

   integer i;
   reg [31:0] A;
   reg [31:0] Q;
   reg [31:0] M;
   reg q0;

	always @ (*) begin
		M = RegA;
		Q = RegB;
		A = 32'b0;
		q0 = 0;
	
		for (i = 0; i < 32; i = i + 1) begin
			if (Q[0] == 1'b1 && q0 == 1'b0) begin
				A = A - M;
			end
			else if (Q[0] == 1'b0 && q0 == 1'b1) begin
				A = A + M;
			end
			
			q0 = Q[0];
			Q = Q >> 1;
			Q[31] = A[0];
			A = A >> 1;
			A[31] = A[30];
		end
	end

   assign Z = {A, Q};

endmodule