`timescale 1ns / 1ps

module not32(
	input wire [31:0] Ra,
	output reg [31:0] Rz
	);
	always @(*)
		assign Rz = !Ra;
endmodule 