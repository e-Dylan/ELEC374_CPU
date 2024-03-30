module select_encode(
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

	reg [3:0] Ra, Rb, Rc;
	
	reg [3:0] encoder_in;
	reg [15:0] encoder_out;
	
	initial begin
		{R0in, R1in, R2in, R3in,
		R4in, R5in, R6in, R7in,
		R8in, R9in, R10in, R11in,
		R12in, R13in, R14in, R15in,
		R0out, R1out, R2out, R3out,
		R4out, R5out, R6out, R7out,
		R8out, R9out, R10out, R11out,
		R12out, R13out, R14out, R15out} = 32'b0;
	end
	
	always @ (*) begin
		Ra <= IR[26:23];
		Rb <= IR[22:19];
		Rc <= IR[18:15];
		
		// 4 to 16 encoder
		if (Gra)
			encoder_in <= Ra;
		else if (Grb)
			encoder_in <= Rb;
		else if (Grc)
			encoder_in <= Rc;
		
		case (encoder_in)
			4'b0000 : begin
				encoder_out <= 16'b0000_0000_0000_0001;
			end
			4'b0001 : begin
				encoder_out <= 16'b0000_0000_0000_0010;
			end
			4'b0010 : begin
				encoder_out <= 16'b0000_0000_0000_0100;
			end
			4'b0011 : begin
				encoder_out <= 16'b0000_0000_0000_1000;
			end
			4'b0100 : begin
				encoder_out <= 16'b0000_0000_0001_0000;
			end
			4'b0101 : begin
				encoder_out <= 16'b0000_0000_0010_0000;
			end
			4'b0110 : begin
				encoder_out <= 16'b0000_0000_0100_0000;
			end
			4'b0111 : begin
				encoder_out <= 16'b0000_0000_1000_0000;
			end
			4'b1000 : begin
				encoder_out <= 16'b0000_0001_0000_0000;
			end
			4'b1001 : begin
				encoder_out <= 16'b0000_0010_0000_0000;
			end
			4'b1010 : begin
				encoder_out <= 16'b0000_0100_0000_0000;
			end
			4'b1011 : begin
				encoder_out <= 16'b0000_1000_0000_0000;
			end
			4'b1100 : begin
				encoder_out <= 16'b0001_0000_0000_0000;
			end
			4'b1101 : begin
				encoder_out <= 16'b0010_0000_0000_0000;
			end
			4'b1110 : begin
				encoder_out <= 16'b0100_0000_0000_0000;
			end
			4'b1111 : begin
				encoder_out <= 16'b1000_0000_0000_0000;
			end
			default : 
				encoder_out <= 16'b0000_0000_0000_0000;
			endcase
		
		// control signals
		
		if (Rin) begin
			R0in = encoder_out[0];
			R1in = encoder_out[1];
			R2in = encoder_out[2];
			R3in = encoder_out[3];
			
			R4in = encoder_out[4];
			R5in = encoder_out[5];
			R6in = encoder_out[6];
			R7in = encoder_out[7];
			
			R8in = encoder_out[8];
			R9in = encoder_out[9];
			R10in = encoder_out[10];
			R11in = encoder_out[11];
			
			R12in = encoder_out[12];
			R13in = encoder_out[13];
			R14in = encoder_out[14];
			R15in = encoder_out[15];
		end
		else if (BAout || Rout) begin
			R0out = encoder_out[0];
			R1out = encoder_out[1];
			R2out = encoder_out[2];
			R3out = encoder_out[3];
			
			R4out = encoder_out[4];
			R5out = encoder_out[5];
			R6out = encoder_out[6];
			R7out = encoder_out[7];
		
			R8out = encoder_out[8];
			R9out = encoder_out[9];
			R10out = encoder_out[10];
			R11out = encoder_out[11];
			
			R12out = encoder_out[12];
			R13out = encoder_out[13];
			R14out = encoder_out[14];
			R15out = encoder_out[15];
			if (BAout) begin
				R0out = 1;
			end
		end
		else begin
			R0in = 0;
			R1in = 0;
			R2in = 0;
			R3in = 0;
			
			R4in = 0;
			R5in = 0;
			R6in = 0;
			R7in = 0;
			
			R8in = 0;
			R9in = 0;
			R10in = 0;
			R11in = 0;
			
			R12in = 0;
			R13in = 0;
			R14in = 0;
			R15in = 0;
			R0out = 0;
			R1out = 0;
			R2out = 0;
			R3out = 0;
			
			R4out = 0;
			R5out = 0;
			R6out = 0;
			R7out = 0;
		
			R8out = 0;
			R9out = 0;
			R10out = 0;
			R11out = 0;
			
			R12out = 0;
			R13out = 0;
			R14out = 0;
			R15out = 0;
		end	
	end
endmodule
