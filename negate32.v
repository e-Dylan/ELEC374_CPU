`timescale 1ns / 1ps

module negate32(
	input wire [31:0] Ra,
	output wire [31:0] Rz
	);
	
	wire [31:0] temp; 
	wire cout;
	not32 not_op(.Ra(Ra),.Rz(temp));
	adder add_op(.A(temp), .B(32'd1),.Result(Rz));
	
endmodule
