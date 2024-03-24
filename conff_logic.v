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
	reg branch_flag;
	
	assign equal = (bus_in == 32'd0) ? 1'b1 : 1'b0;
	assign not_equal = (bus_in != 32'd0) ? 1'b1 : 1'b0;
	assign positive	= (bus_in[31] == 0) ? 1'b1 : 1'b0;
	assign negative = (bus_in[31] == 1) ? 1'b1 : 1'b0;
	
	decoder_2_to_4	decode(IR_bits, decoder_output);
	always @ (*) begin
		case (decoder_output)
			4'b0001 : begin
				branch_flag = equal;
			end
			4'b0010 : begin
				branch_flag = not_equal;
			end
			4'b0100 : begin
				branch_flag = positive;
			end
			4'b1000 : begin
				branch_flag = negative;
			end
			default : begin
				branch_flag = 0;
			end
		endcase
	end
	ff_logic conff(.clk(CON_in), .D(branch_flag), .Q(CON_out));

endmodule