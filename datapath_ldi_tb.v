`timescale 1ns/10ps
module datapath_ldi_tb;	
	reg 	Clock, clear, Read, Write, IncPC;
	reg [4:0] opcode;
	reg	Gra, Grb, Grc, Rin, Rout, BAout;

	reg	HIin, LOin,
			Yin, Zin,
			PCin, IRin, MARin, MDRin, Inportin, Outportin, CONin;
					
	reg	HIout, LOout,
			Yout, Zhighout, Zlowout,
			PCout, MARout, MDRout, Inportout, Outportout, Cout, InPort_input, OutPort_output;
			
	reg [31:0] Mdatain;
	
	parameter 	Default=4'b0000, Reg_load1a=4'b0001, Reg_load1b=4'b0010, 
					Reg_load2a=4'b0011, Reg_load2b=4'b0100,
					Reg_load3a=4'b0101, Reg_load3b=4'b0110,
					Reg_load4a=5'b1110, Reg_load4b=5'b1111,
					T0=4'b0111, T1=4'b1000, T2=4'b1001,
					T3=4'b1010, T4=4'b1011, T5=4'b1100, T6=4'b1101;
	reg [3:0] Present_state = Default;

	datapath DUT(	Clock, clear, Read, Write, IncPC, opcode,
						Gra, Grb, Grc, Rin, Rout, BAout,
						
						HIin, LOin,
						Yin, Zin,
						PCin, IRin, MARin, MDRin, Inportin, Outportin, CONin,
					
						HIout, LOout,
						Yout, Zhighout, Zlowout,
						PCout, MARout, MDRout, Inportout, Outportout, Cout, InPort_input, OutPort_output);
	
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
				Reg_load3b	:	#40 Present_state = Reg_load4a;
				Reg_load4a	:	#40 Present_state = Reg_load4b;
				Reg_load4b	:	#40 Present_state = T0;
				T0				:	#40 Present_state = T1;
				T1				:	#40 Present_state = T2;
				T2				:	#40 Present_state = T3;
				T3				:	#40 Present_state = T4;
				T4				:	#40 Present_state = T5;
				T5				:  #40 Present_state = T6;
				// T6				: 	#40 Present_state = T7;
			endcase
		end
		
	always @ (Present_state)
		begin
			case (Present_state)
				Default : begin
					PCout <= 0; Zlowout <= 0; MDRout <=0;
					MARin <= 0; Zin <= 0; Cout <= 0;
					PCin <= 0; MDRin <= 0; IRin <= 0; Yin <= 0;
					IncPC <= 0; Read <= 0; opcode <= 0;
					LOin <= 0; HIin <= 0; Mdatain <= 32'b0;
					Read = 0; MDRin = 0; clear = 0;
					Gra = 0; Grb = 0; Grc = 0;
				end
				Reg_load1a : begin
					PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
					#25 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
				end
				Reg_load1b : begin
					Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
					#25 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
				end
				Reg_load2a : begin
					MDRout <= 1; IRin <=1;
					#25 MDRout <= 0; IRin <=0;
					Yin <= 1; Grb <= 1; BAout <= 1;
				end
				Reg_load2b : begin
					#25 Grb <= 0; BAout <= 0; Yin <= 0;
				end
				Reg_load3a : begin
					Cout <= 1; opcode <= 5'b00011; Zin <= 1; // opcode for add
					#25 Cout <= 0; Zin <= 0;
				end
				Reg_load3b : begin
					Zlowout <= 1; Gra <= 1; Rin <= 1;
					#25 Zlowout <= 0; Gra <= 0; Rin <= 0;
				end
				T0 : begin
					PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
					#25 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
				end
				T1 : begin
					Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
					#25 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
					// ld instruction : 32'b00011_0010_0000_00000000_00001011_110;
				end
				T2 : begin
					MDRout <= 1; IRin <=1;
					#25 MDRout <= 0; IRin <=0;
					Yin <= 1; Grb <= 1; Rout <= 1;
				end
				T3 : begin
					#25 Grb <= 0; Rout <= 0; Yin <= 0;
				end
				T4 : begin
					Cout <= 1; opcode <= 5'b00011; Zin <= 1; // opcode for add
					#25 Cout <= 0; Zin <= 0;
				end
				T5 : begin
					Zlowout <= 1; Gra <= 1; Rin <= 1;
					#25 Zlowout <= 0; Gra <= 0; Rin <= 0;
				end
			endcase
		end
		
endmodule

