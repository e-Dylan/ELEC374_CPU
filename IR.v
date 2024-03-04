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
			C_sign_extended[0:17] <= IR[16:31];
			C_sign_extended[18:31] <= IR[18] ? 15'b1 : 15'b0;
		end
	end
endmodule
