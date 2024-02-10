module register64(
	input wire [63:0] d,
	input wire clk, clr, enable,
	output reg [31:0] q_high,
	output reg [31:0] q_low
);

	always @ (posedge clk, posedge clr) begin
		if (clr) begin
			q_high <= 0;
			q_low <= 0;
		end
		else if (enable) begin
			q_high <= d[63:32];
			q_low <= d[31:0];
		end
	end
endmodule