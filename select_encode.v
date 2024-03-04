module select_encode(
	input wire [31:0] BusMuxOut,
	input wire [31:0] IR,
	input wire Gra, Grb, Grc, Rin, Rout, BAout,
	
	output reg	R0in, R1in, R2in, R3in,
					R4in, R5in, R6in, R7in,
					R8in, R9in, R10in, R11in,
					R12in, R13in, R14in, R15in,
					
	output reg	R0out, R1out, R2out, R3out,
					R4out, R5out, R6out, R7out,
					R8out, R9out, R10out, R11out,
					R12out, R13out, R14out, R15out
);

	reg [31:0] C_sign_extended;
	reg [3:0] Ra, Rb, Rc;
	
	reg [3:0] encoder_in;
	reg [15:0] encoder_out;
	
	
	always @ (*) begin
		if (IR)
			C_sign_extended[0:17] <= IR[16:31];
			C_sign_extended[18:31] <= IR[18] ? 15'b1 : 15'b0;
			Ra <= IR[5:8];
			Rb <= IR[9:12];
			Rc <= IR[13:15];
		end
		
		// 4 to 16 encoder
		encoder_in <= (Ra && Gra) || (Rb && Grb) || (Rc && Grc);
		
		case (encoder_in)
			4'b0000 : begin
			
			end
			
			4'b0001 : begin
			
			end
			default : 
			end
		endcase
		
	end

endmodule
