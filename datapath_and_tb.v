`timescale 1ns/10ps
module datapath_and_tb;	
	reg 	Clock, clear, opcode, Read, IncPC;
	reg	R0in, R1in, R2in, R3in,
			R4in, R5in, R6in, R7in,
			R8in, R9in, R10in, R11in,
			R12in, R13in, R14in, R15in;

	reg	HIin, LOin,
			Yin, Zhighin, Zlowin,
			PCin, IRin, MARin, MDRin, Inportin, Cin;
						
	reg 	R0out, R1out, R2out, R3out,
			R4out, R5out, R6out, R7out,
			R8out, R9out, R10out, R11out,
			R12out, R13out, R14out, R15out;
					
	reg	HIout, LOout,
			Yout, Zhighout, Zlowout,
			PCout, IRout, MARout, MDRout, Inportout, Cout;
			
	reg [31:0] Mdatain;
	
	parameter 	Default=4'b0000, Reg_load1a=4'b0001, Reg_load2a=4'b0011,
					Reg_load2b=4'b0100, Reg_load3a=4'b0101, Reg_load3b=4'b0110,
					T0=4'b0111, T1=4'b1000, T2=4'b1010, T3=4'b1010, T4=4'b1011,
					T5=4'b1100;
	reg [3:0] Present_state = Default;

	datapath DUT(	Clock, clear, opcode, Read, IncPC,
						R0in, R1in, R2in, R3in,
						R4in, R5in, R6in, R7in,
						R8in, R9in, R10in, R11in,
						R12in, R13in, R14in, R15in,
						
						HIin, LOin,
						Yin, Zhighin, Zlowin,
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
	