//brzr r2, 35:  91000023
//brnz r2, 35:  91080023
//brpl r2, 35:  91100023
//brmi r2, 35:  91180023

`timescale 1ns/10ps
module datapath_brzr_tb;	
	reg 	Clock, clear, Read, Write, IncPC;
	reg [4:0] opcode;
	reg	Gra, Grb, Grc, Rin, Rout, BAout;

	reg	HIin, LOin,
			Yin, Zin,
			PCin, IRin, MARin, MDRin, Inportin, Outportin, CONin;
					
	reg	HIout, LOout,
			Yout, Zhighout, Zlowout,
			PCout, MARout, MDRout, Inportout, Outportout, Cout;
			
	reg [31:0] Mdatain;
	reg [31:0] InPort_input;
	
	parameter 	Default=4'b0000, Reg_load1a=4'b0001, Reg_load1b=4'b0010, 
					Reg_load2a=4'b0011, Reg_load2b=4'b0100,
					Reg_load3a=4'b0101, Reg_load3b=4'b0110,
					T0=4'b0111, T1=4'b1000, T2=4'b1001,
					T3=4'b1010, T4=4'b1011, T5=4'b1100, T6=4'b1101, T7=4'b1110;
	reg [3:0] Present_state = Default;

	datapath DUT(	Clock, clear, Read, Write, IncPC, opcode,
						Gra, Grb, Grc, Rin, Rout, BAout,
						
						HIin, LOin,
						Yin, Zin,
						PCin, IRin, MARin, MDRin, Inportin, Outportin, CONin,
					
						HIout, LOout,
						Yout, Zhighout, Zlowout,
						PCout, MARout, MDRout, Inportout, Outportout, Cout, InPort_input);
	
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
				T5				:  #40 Present_state = T6;
				T6				: 	#40 Present_state = T7;
			endcase
		end
		
	always @(Present_state) 
		begin
			case (Present_state) //assert the required signals in each clockcycle
				Default: begin // initialize the signals
					PCout <= 0; Zlowout <= 0; MDRout <= 0;
					MARin <= 0; HIin <= 0; LOin <= 0; CONin<=0; 
					Inportin<=0; Outportin<=0;
					PCin <=0; MDRin <= 0; IRin <= 0; 
					Yin <= 0;
					IncPC <= 0; Write<=0;
					MDRin <= 0; Gra<=0; Grb<=0; Grc<=0;
					BAout<=0; Cout<=0;
					Inportout<=0; Zhighout<=0; LOout<=0; HIout<=0; 
					HIin <=0; LOin <=0;
					Rout<=0;Rin <=0;Read<=0;
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
					#25 Cout <= 0; opcode <= 5'b0; Zin <= 0;
				end
				Reg_load3b : begin
					Zlowout <= 1; Gra <= 1; Rin <= 1;
					#25 Zlowout <= 0; Gra <= 0; Rin <= 0;
				end	
				T0: begin 
					PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
					#25 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
				end

				T1: begin
					Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
					#25 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0; 
				end

				T2: begin
					MDRout <= 1; IRin <=1;
					#25 MDRout <= 0; IRin <=0;
					Gra <= 1; Rout <= 1; 
					#10 CONin <= 1;		
				end
				
				T3: begin
					#25 Gra <= 0; Rout <= 0; CONin <= 0;
				end
				
				T4: begin
					PCout <= 1; Yin <= 1;
					#25 PCout <= 0; Yin <= 0;
				end
				
				T5: begin
					Cout <= 1; opcode <= 5'b10011; Zin <= 1;
					#25 Cout <= 0; opcode <= 5'b0; Zin <= 0;
				end
				
				T6: begin
					Zlowout <= 1; PCin <= 1;
					#25 Zlowout <= 0; PCin <= 0;
				end
			endcase

end

endmodule