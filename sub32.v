`timescale 1ns / 1ps

module sub32(
	input wire [31:0] Ra, 
	input wire [31:0] Rb, 
	output wire [31:0] sum
);

	wire [31:0] temp; 
	negate32 negate(Rb, temp);
	adder add(Ra, temp, sum);
endmodule