`timescale 1ns / 1ps

module or32(
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	output reg [31:0] Rz
	);
	
	always @(*)
		assign Rz = Ra | Rb;
endmodule

	