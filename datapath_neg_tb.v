`timescale 1ns/10ps
module datapath_neg_tb;	
	reg 	Clock, clear, Read, IncPC;
	reg [4:0] opcode;
	reg	R0in, R1in, R2in, R3in,
			R4in, R5in, R6in, R7in,
			R8in, R9in, R10in, R11in,
			R12in, R13in, R14in, R15in;

	reg	HIin, LOin,
			Yin, Zin,
			PCin, IRin, MARin, MDRin, Inportin, Cin;
						
	reg 	R0out, R1out, R2out, R3out,
			R4out, R5out, R6out, R7out,
			R8out, R9out, R10out, R11out,
			R12out, R13out, R14out, R15out;
					
	reg	HIout, LOout,
			Yout, Zhighout, Zlowout,
			PCout, IRout, MARout, MDRout, Inportout, Cout;
			
	reg [31:0] Mdatain;
	
	parameter 	Default=4'b0000, Reg_load1a=4'b0001, Reg_load1b=4'b0010, 
					Reg_load2a=4'b0011, Reg_load2b=4'b0100,
					Reg_load3a=4'b0101, Reg_load3b=4'b0110,
					T0=4'b0111, T1=4'b1000, T2=4'b1001,
					T3=4'b1010, T4=4'b1011, T5=4'b1100;
	reg [3:0] Present_state = Default;

	datapath DUT(	Clock, clear, Read, IncPC, opcode,
						R0in, R1in, R2in, R3in,
						R4in, R5in, R6in, R7in,
						R8in, R9in, R10in, R11in,
						R12in, R13in, R14in, R15in,
						
						HIin, LOin,
						Yin, Zin,
						PCin, IRin, MARin, MDRin, Inportin, Cin,
						
						R0out, R1out, R2out, R3out,
						R4out, R5out, R6out, R7out,
						R8out, R9out, R10out, R11out,
						R12out, R13out, R14out, R15out,
					
						HIout, LOout,
						Yout, Zhighout, Zlowout,
						PCout, IRout, MARout, MDRout, Inportout, Cout,
					
						Mdatain);
	
	initial
		begin
			Clock = 0;
			forever #10 Clock = ~Clock;
	end
	
	always @ (posedge Clock)
		begin
			case (Present_state)
				Default		:	Present_state = Reg_load1a;
				Reg_load1a 	:	#40 Present_state = Reg_load1b;
				Reg_load1b	:	#40 Present_state = Reg_load2a;
				Reg_load2a	:	#40 Present_state = Reg_load2b;
				Reg_load2b	:	#40 Present_state = Reg_load3a;
				Reg_load3a	:	#40 Present_state = Reg_load3b;
				Reg_load3b	:	#40 Present_state = T0;
				T0				:	#40 Present_state = T1;
				T1				:	#40 Present_state = T2;
				T2				:	#40 Present_state = T3;
				T3				:	#40 Present_state = T4;
				T4				:	#40 Present_state = T5;
			endcase
		end
		
	always @ (Present_state)
		begin
			case (Present_state)
				Default : begin
					PCout <= 0; Zlowout <= 0; MDRout <=0;
					R2out <= 0; R3out <= 0; MARin <= 0; Zin <= 0;
					PCin <= 0; MDRin <= 0; IRin <= 0; Yin <= 0;
					IncPC <= 0; Read <= 0; opcode <= 0;
					R1in <= 0; R2in <= 0; R3in <= 0; Mdatain <= 32'b0;
					Read = 0; MDRin = 0; clear = 0;
				end
				Reg_load1a : begin
					Mdatain <= 32'b0100;		// 4, value for R2
					Read <= 1; MDRin <= 1;
					#25 Read <= 0; MDRin <= 0;
				end
				Reg_load1b : begin
					MDRout <= 1; R2in <= 1;
					#25 MDRout <= 0; R2in <= 0;
				end
				Reg_load2a : begin
					Mdatain <= 32'b0101;		// 5, value for R3
					Read <= 1; MDRin <= 1;
					#25 Read <= 0; MDRin <= 0;
				end
				Reg_load2b : begin
					MDRout <= 1; R3in <= 1;
					#25 MDRout <= 0; R3in <= 0;
				end
				Reg_load3a : begin
					Mdatain <= 32'b1000;		// 8
					Read <= 1; MDRin <= 1;
					#25 Read <= 0; MDRin <= 0;
				end
				Reg_load3b : begin
					MDRout <= 1; R1in <= 1;
					#25 MDRout <= 0; R1in <= 0;
				end
				T0 : begin
					PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
					#25 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
				end
				T1 : begin
					Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
					Mdatain <= 32'b00011_0001_0010_0011_000000000000000; // opcode for "add R1, R2, R3"
													 // 00011 0001 0010 0011 000000000000000
					#25 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
				end
				T2 : begin
					MDRout <= 1; IRin <=1;
					#25 MDRout <= 0; IRin <=0;
				end
				T3 : begin
					R2out <= 1; Yin <= 1;
					#25 R2out <= 0; Yin <= 0;
				end
				T4 : begin
					R3out <= 1; opcode <= 5'b10000; Zin <= 1; // opcode for neg
					#25 R3out <= 0; Zin <= 0;
				end
				T5 : begin
					Zlowout <= 1; R1in <= 1;
					#25 Zlowout <= 0; R1in <= 0;
				end
			endcase
		end
		
endmodule

