`timescale 1ns/10ps

module conff_logic(input [1:0] IR_bits, 
                   input signed [31:0] bus_in, 
                   input CON_in, 
                   output CON_out);
                   
	wire [3:0] decoder_output;
	wire equal;
	wire not_equal;
	wire positive;
	wire negative;
	wire branch_flag;
	
	assign equal = (bus_in == 32'd0) ? 1'b1 : 1'b0;
	assign notEqual = (bus_in != 32'd0) ? 1'b1 : 1'b0;
	assign positive	= (bus_in[31] == 0) ? 1'b1 : 1'b0;
	assign negative = (bus_in[31] == 1) ? 1'b1 : 1'b0;
	
	decoder_2_to_4	decode(IR_input, decoder_output);
	assign branch_flag=(decoder_output[0]&equal|decoder_output[1]&notEqual|decoder_output[2]&positive|decoder_output[3]&negative);
	ff_logic conff(.clk(CON_in), .D(branchFlag), .Q(CON_out));

endmodule