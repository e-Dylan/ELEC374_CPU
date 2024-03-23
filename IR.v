module IR(
	input wire clr, clk, enable,
	input wire [31:0] d,
	output reg [31:0] IR,
	output reg [31:0] C_sign_extended
);

	always @ (posedge clk) begin
		if (clr) begin
			IR <= 0;
		end
		else if (enable) begin
			IR <= d;	
			C_sign_extended[31:0] <= {{13{d[18]}}, d[18:0]};
		end
	end
endmodule
