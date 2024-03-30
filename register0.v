module register0(
	input wire clr, clk, enable, BAout,
	input wire [31:0] d,
	output reg [31:0] q
);
	initial q = 32'b0;

	always @ (posedge clk) begin
		if (clr) begin
			q <= 0;
		end
		else if (enable) begin
			q <= d;
		end
		if (BAout) begin
			q <= BAout ? 32'b0 : q;
		end
	end
endmodule
