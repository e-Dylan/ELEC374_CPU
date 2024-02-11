`timescale 1ns / 1ps

module sub32(input wire [31:0] Ra, input wire [31:0] Rb, input wire cin, 
            output wire [31:0] sum, output wire cout);

	wire [31:0] temp; 
	negate32 negate(Rb);
	adder add(Ra, temp, sum);
endmodule