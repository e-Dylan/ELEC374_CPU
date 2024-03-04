module register0(
	input wire clr, clk, enable, BAout,
	input wire [31:0] d,
	output reg [31:0] q
);

	always @ (posedge clk) begin
		if (clr) begin
			q <= 0;
		end
		else if (enable) begin
			q <= !BAout && d;
		end
	end
endmodule
