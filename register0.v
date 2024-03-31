module register0(
	input wire clr, clk, enable, BAout,
	input wire [31:0] d,
	output reg [31:0] q
);
	reg [31:0] value;
	
	initial begin
		q = 32'b0;
		value = 32'b0;
	end
	
	always @ (posedge clk) begin
		if (clr) begin
			value <= 0;
		end
		else if (enable) begin
			value <= d;
			q <= value;
		end
		if (BAout) begin
			q <= 32'b0;
		end
		else begin
			q <= value;
		end
	end
endmodule
