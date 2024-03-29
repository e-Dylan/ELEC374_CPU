`timescale 1ns / 1ps

module not32(
	input wire [31:0] Ra,
	output wire [31:0] Rz
	);
	
	genvar i;
	generate
		for (i=0; i<32; i=i+1) begin : loop
			assign Rz[i] = !Ra[i];
		end
	endgenerate
endmodule 