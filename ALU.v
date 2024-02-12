`timescale 1ns/10ps

module alu(
	input wire [31:0] Y_reg,
	input wire [31:0] B_reg,

	input wire [4:0] opcode,

	output reg [63:0] C_reg
);
	parameter Addition = 5'b00011, Subtraction = 5'b00100, Multiplication = 5'b01111, Division = 5'b10000, 
				 Shift_right = 5'b00101, Shift_right_ar = 5'b00110, Shift_left = 5'b00111, Rotate_right = 5'b01000, Rotate_left = 5'b01001, 
				 AND = 5'b01010, OR = 5'b01011, Negate = 5'b10001, _Not = 5'b10010;
				 
	wire [31:0] IncPC_out, shr_out, shra_out, shl_out, lor_out, land_out, neg_out, not_out, adder_sum, adder_cout, sub_sum, sub_cout, rol_out, ror_out;
	wire [63:0] mul_out, div_out;
	
	always @(*)
		begin
			case (opcode)
				
				Addition: begin
					C_reg[31:0] <= adder_sum[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Subtraction: begin
					C_reg[31:0] <= sub_sum[31:0];	
					C_reg[63:32] <= 32'd0;
				end
				
				Multiplication: begin
					C_reg[63:32] <= mul_out[63:32];
					C_reg[31:0] <= mul_out[31:0];
				end
				
				Division: begin
					C_reg[63:0] <= div_out[63:0];
				end
				
				OR: begin
					C_reg[31:0] <= lor_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				AND: begin
					C_reg[31:0] <= land_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Negate: begin
					C_reg[31:0] <= neg_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				_Not: begin
					C_reg[31:0] <= not_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Shift_right: begin
					C_reg[31:0] <= shr_out[31:0];
					C_reg[63:32] <= 32'd0;
				end

				Shift_right_ar: begin
					C_reg[31:0] <= shra_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Shift_left: begin
					C_reg[31:0] <= shl_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Rotate_right: begin
					C_reg[31:0] <= ror_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Rotate_left: begin
					C_reg[31:0] <= rol_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				default: begin
					C_reg[63:0] <= 64'd0;
				end

			endcase
	end
	
	//ALU Operations
	or32 lor(Y_reg,B_reg,lor_out);
	and32 land(Y_reg,B_reg,land_out);
	negate32 neg(B_reg,neg_out);
	not32 not_module(B_reg,not_out);
	adder adder(Y_reg, B_reg,adder_sum);
	sub32 subtractor(Y_reg, B_reg, sub_sum);
	ror ror_op(Y_reg,B_reg,ror_out);
	rol rol_op(Y_reg,B_reg,rol_out);
	shiftleft32 shl(Y_reg,B_reg,shl_out);
	shiftright32 shr(Y_reg,B_reg,shr_out);
	shiftrightari32 shra(Y_reg, B_reg, shra_out);
	div32 div(Y_reg,B_reg, div_out);
	mul32 mul(Y_reg,B_reg,mul_out);

endmodule