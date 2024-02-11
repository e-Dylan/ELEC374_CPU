// datapath testbench template
`timescale 1ns/10ps
module datapath_tbtemplate;	
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
					T0=4'b0111, T1=4'b1000, T2=4'b1010,
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
				Reg_load1a 	:	Present_state = Reg_load1b;
				Reg_load1b	:	Present_state = Reg_load2a;
				Reg_load2a	:	Present_state = Reg_load2b;
				Reg_load2b	:	Present_state = Reg_load3a;
				Reg_load3a	:	Present_state = Reg_load3b;
				Reg_load3b	:	Present_state = T0;
				T0				:	Present_state = T1;
				T1				:	Present_state = T2;
				T2				:	Present_state = T3;
				T3				:	Present_state = T4;
				T4				:	Present_state = T5;
			endcase
		end
		
	always @ (Present_state)
		begin
			case (Present_state)
				Default : begin
				
				end
				Reg_load1a : begin
				
				end
				Reg_load1b : begin
				
				end
				Reg_load2a : begin
				
				end
				Reg_load2b : begin
				
				end
				Reg_load3a : begin
				
				end
				Reg_load3b : begin
				
				end
				T0 : begin
				
				end
				T1 : begin
				
				end
				T2 : begin
				
				end
				T3 : begin
				
				end
				T4 : begin
				
				end
				T5 : begin
				
				end
			endcase
		end
		
endmodule
	