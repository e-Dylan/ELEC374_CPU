`timescale 1ns/10ps
module control_unit (
	input			[31:0] IR,
	input			clock, clear, stop,
	
	output reg	PCout, Zhighout, Zlowout, MDRout, MARin, PCin, MDRin, IRin, Yin, IncPC, Read, 
					HIin, LOin, HIout, LOout, Zin, Cout, Write, Gra, Grb, Grc, Rin, Rout, BAout, CONin,
					InPortin, OutPortin, InPortout, Run
);
	
	parameter reset_state= 8'b00000000, fetch0 = 8'b00000001, fetch1 = 8'b00000010, fetch2= 8'b00000011,
				 add3 = 8'b00000100, add4= 8'b00000101, add5= 8'b00000110, sub3 = 8'b00000111, sub4 = 8'b00001000, sub5 = 8'b00001001,
				 mul3 = 8'b00001010, mul4 = 8'b00001011, mul5 = 8'b00001100, mul6 = 8'b00001101, div3 = 8'b00001110, div4 = 8'b00001111,
				 div5 = 8'b00010000, div6 = 8'b00010001, or3 = 8'b00010010, or4 = 8'b00010011, or5 = 8'b00010100, and3 = 8'b00010101, 
				 and4 = 8'b00010110, and5 = 8'b00010111, shl3 = 8'b00011000, shl4 = 8'b00011001, shl5 = 8'b00011010, shr3 = 8'b00011011,
				 shr4 = 8'b00011100, shr5 = 8'b00011101, rol3 = 8'b00011110, rol4 = 8'b00011111, rol5 = 8'b00100000, ror3 = 8'b00100001,
				 ror4 = 8'b00100010, ror5 = 8'b00100011, neg3 = 8'b00100100, neg4 = 8'b00100101, neg5 = 8'b00100110, not3 = 8'b00100111,
				 not4 = 8'b00101000, not5 = 8'b00101001, ld3 = 8'b00101010, ld4 = 8'b00101011, ld5 = 8'b00101100, ld6 = 8'b00101101, 
				 ld7 = 8'b00101110, ldi3 = 8'b00101111, ldi4 = 8'b00110000, ldi5 = 8'b00110001, st3 = 8'b00110010, st4 = 8'b00110011,
				 st5 = 8'b00110100, st6 = 8'b00110101, st7 = 8'b00110110, addi3 = 8'b00110111, addi4 = 8'b00111000, addi5 = 8'b00111001,
				 andi3 = 8'b00111010, andi4 = 8'b00111011, andi5 = 8'b00111100, ori3 = 8'b00111101, ori4 = 8'b00111110, ori5 = 8'b00111111,
				 br3 = 8'b01000000, br4 = 8'b01000001, br5 = 8'b01000010, br6 = 8'b01000011, br7 = 8'b11111111, jr3 = 8'b01000100, jal3 = 8'b01000101, 
				 jal4 = 8'b01000110, mfhi3 = 8'b01000111, mflo3 = 8'b01001000, in3 = 8'b01001001, out3 = 8'b01001010, nop3 = 8'b01001011, 
				 halt3 = 8'b01001100;

	reg		[7:0] Present_state = reset_state;
	
	always @(posedge clock, posedge clear, posedge stop) begin
		if (clear == 1'b1) Present_state = reset_state;
		if (stop == 1'b1) Present_state = halt3;
		else case (Present_state)
			reset_state		:	#40 Present_state = fetch0;
			fetch0			:	#40 Present_state = fetch1;
			fetch1			:	#40 Present_state = fetch2;
			fetch2			:	begin	
										#40
										@(posedge clock);
										case	(IR[31:27])
											5'b00011		:		Present_state=add3;	
											5'b00100		: 		Present_state=sub3;
											5'b01111		:		Present_state=mul3;
											5'b10000		:		Present_state=div3;
											5'b00101		:		Present_state=shr3;
											5'b00111		:		Present_state=shl3;
											5'b01000		:		Present_state=ror3;
											5'b01001		:		Present_state=rol3;
											5'b01010		:		Present_state=and3;
											5'b01011		:		Present_state=or3;
											5'b10001		:		Present_state=neg3;
											5'b10010		:		Present_state=not3;
											5'b00000		:		Present_state=ld3;
											5'b00001		:		Present_state=ldi3;
											5'b00010		:		Present_state=st3;
											5'b01100		:		Present_state=addi3;
											5'b01101		:		Present_state=andi3;
											5'b01110		:		Present_state=ori3;
											5'b10011		:		Present_state=br3;
											5'b10100		:		Present_state=jr3;
											5'b10101		:		Present_state=jal3;
											5'b11000		:		Present_state=mfhi3;
											5'b11001		:		Present_state=mflo3;
											5'b10110		:		Present_state=in3;
											5'b10111		:		Present_state=out3;
											5'b11010		:		Present_state=nop3;
											5'b11011		:		Present_state=halt3;
										endcase
									end
									
				//Addition = 5'b00011, Subtraction = 5'b00100, Multiplication = 5'b01111, Division = 5'b10000, 
				 //Shift_right = 5'b00101, Shift_right_ar = 5'b00110, Shift_left = 5'b00111, Rotate_right = 5'b01000, Rotate_left = 5'b01001, 
				 //AND = 5'b01010, OR = 5'b01011, Negate = 5'b10001, _Not = 5'b10010, ld = 5'b00000 , ldi = 5'b00001, st = 5'b00010, br = 5'b10011, 
				 //jr = 5'b10100, jal = 5'b10101, in = 5'b10110, out = 5'b10111, mfhi = 5'b11000, mflo = 5'b11001, addi = 5'b01100, andi = 5'b01101, 
				 //ori = 5'b01110;
				 
			add3				: 	Present_state = add4;
			add4				:	Present_state = add5;
			add5 				:	Present_state = fetch0;
			
			addi3				: 	Present_state = addi4;
			addi4				:	Present_state = addi5;
			addi5 			:	Present_state = fetch0;
			
			sub3				: 	Present_state = sub4;
			sub4				: 	Present_state = sub5;
			sub5				:	Present_state = fetch0;
			
			mul3				: 	Present_state = mul4;
			mul4				: 	Present_state = mul5;
			mul5				: 	Present_state = mul6;
			mul6           :	Present_state = fetch0; 
			
			div3				: 	Present_state = div4;
			div4				: 	Present_state = div5;
			div5				: 	Present_state = div6;
			div6				:	Present_state = fetch0;
			
			or3				: 	Present_state = or4;
			or4				: 	Present_state = or5;
			or5				:	Present_state = fetch0;
			
			and3				: 	Present_state = and4;
			and4				: 	Present_state = and5;
			and5   			:	Present_state = fetch0;
			
			shl3				: 	Present_state = shl4;
			shl4				: 	Present_state = shl5;
			shl5 				:	Present_state = fetch0;
			
			shr3				: 	Present_state = shr4;
			shr4				: 	Present_state = shr5;
			shr5 				:	Present_state = fetch0;
			
			rol3				: 	Present_state = rol4;
			rol4				: 	Present_state = rol5;
			rol5 				:	Present_state = fetch0;
			
			ror3				: 	Present_state = ror4;
			ror4				: 	Present_state = ror5;
			ror5 				:	Present_state = fetch0;
			
			neg3				: 	Present_state = neg4;
			neg4				: 	Present_state = fetch0;
			
			not3				: 	Present_state = not4;
			not4				: 	Present_state = fetch0;
			
			ld3				: 	Present_state = ld4;
			ld4				: 	Present_state = ld5;
			ld5				: 	Present_state = ld6;
			ld6				: 	Present_state = ld7;
			ld7				:  Present_state = fetch0;
			
			ldi3				: 	Present_state = ldi4;
			ldi4				: 	Present_state = ldi5;
			ldi5 				:	Present_state = fetch0;
			
			st3				: 	Present_state = st4;
			st4				: 	Present_state = st5;
			st5				: 	Present_state = st6;
			st6				: 	Present_state = st7;
			st7 				:	Present_state = fetch0;
			
			andi3				: 	Present_state = andi4;
			andi4				: 	Present_state = andi5;
			andi5 			:	Present_state = fetch0;
			
			ori3				: 	Present_state = ori4;
			ori4				: 	Present_state = ori5;
			ori5 				:	Present_state = fetch0;
			
			jal3				: 	Present_state = jal4;
			jal4 				:	Present_state = fetch0;
			
			jr3 				:	Present_state = fetch0;
			
			br3				: 	Present_state = br4;
			br4				: 	Present_state = br5;
			br5				: 	Present_state = br6;
			br6  				:	Present_state = fetch0;
			
			out3 				:	Present_state = fetch0;
			
			in3 				:	Present_state = fetch0;
			
			mflo3 			:	Present_state = fetch0;
			
			mfhi3 			:	Present_state = fetch0;
			
			nop3 				:	Present_state = fetch0;
			
			endcase
		end

	always @(Present_state) begin
		case(Present_state)
		
			reset_state: begin 
				Run <= 1; // clear <= 1;
				Gra <= 0; Grb <= 0; Grc <= 0; Yin <= 0;	
				PCout <=  0; Zhighout <= 0; Zlowout <= 0; MDRout <= 0; MARin <= 0; PCin <= 0; MDRin <= 0; IRin <= 0; Yin <= 0; IncPC <= 0; Read <= 0;
				HIin <= 0; LOin <= 0; HIout <= 0; LOout <= 0; Zin <= 0; Cout <= 0; Write <= 0; 
				Rin <= 0; Rout <= 0; BAout <= 0; CONin <= 0; InPortin <= 0; OutPortin <= 0; InPortout <= 0;
			end
			
			/*-----------------------
						  FETCH
			-------------------------*/
			
			fetch0: begin
				PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
				#25 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
			end 
			fetch1: begin
				Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
				#25 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
			end 
			fetch2: begin
				MDRout <= 1; IRin <= 1;
				#25 MDRout <= 0; IRin <= 0;
			end 

			/*-----------------------
						 ADD SUB
			  OR AND SHL SHR ROL ROR
			-------------------------*/
			
			add3, sub3, or3, and3, shl3, shr3, rol3, ror3: begin	
				Grb <= 1; Rout <= 1; Yin <= 1;
				#25 Grb <= 0; Rout <= 0; Yin <= 0;
			end
			add4, sub4, or4, and4, shl4, shr4, rol4, ror4: begin
				Grc <= 1; Rout <= 1; Zin <= 1;
				#25 Grc <= 0; Rout <= 0; Zin <= 0;
			end
			add5, sub5, or5, and5, shl5, shr5, rol5, ror5: begin
				Gra <= 1; Rin <= 1; Zlowout <= 1;
				#25 Gra <= 0; Rin <= 0; Zlowout <= 0;
			end

			/*-----------------------
						 MUL DIV
			-------------------------*/
			
			mul3, div3: begin	
				Gra <= 1; Rout <= 1; Yin <= 1;
				#25 Gra <= 0; Rout <= 0; Yin <= 0;
			end
			mul4, div4: begin
				Grb <= 1; Rout <= 1; Zin <= 1;
				#25 Grb <= 0; Rout <= 0; Zin <= 0;
			end
			mul5, div5: begin
				LOin <= 1; Zlowout <= 1;
				#25 LOin <= 0; Zlowout <= 0;
			end
			mul6, div6: begin
				HIin <= 1; Zhighout <= 1;
				#25 HIin <= 0; Zhighout <= 0;
			end

			/*-----------------------
						 NOT NEG
			-------------------------*/
			
			not3, neg3: begin	
				Grb <= 1; Rout <= 1; Zin <= 1;
				#25 Grb <= 0; Rout <= 0; Zin <= 0;
			end
			not4, neg4: begin
				Gra <= 1; Rin <= 1; Zlowout <= 1;
				#25 Gra <= 0; Rin <= 0; Zlowout <= 0;
			end

			/*-----------------------
					 ANDI ADDI ORI
			-------------------------*/
			
			andi3, addi3, ori3: begin
				Grb <= 1; Rout <= 1; Yin <= 1;
				#25 Grb <= 0; Rout <= 0; Yin <= 0;
			end
			andi4, addi4, ori4: begin
				Cout <= 1; Zin <= 1;
				#25 Cout <= 0; Zin <= 0;
			end

			andi5, addi5, ori5: begin
				Gra <= 1; Rin <= 1; Zlowout <= 1;
				#25 Gra <= 0; Rin <= 0; Zlowout <= 0;
			end

			/*-----------------------
						  LOAD
			-------------------------*/

			ld3: begin
				Grb <= 1; BAout <= 1; Yin <= 1;
				#25 Grb <= 0; BAout <= 0; Yin <= 0;
			end

			ld4: begin
				Cout <= 1; Zin <= 1;
				#25 Cout <= 0; Zin <= 0;
			end

			ld5: begin
				MARin <= 1; Zlowout <= 1;
				#25 MARin <= 0; Zlowout <= 0;
			end

			ld6: begin
				Read <= 1; MDRin <= 1;
				#25 Read <= 0; MDRin <= 0;
			end
			ld7: begin
				MDRout <= 1; Gra <= 1; Rin <= 1;
				#25 MDRout <= 0; Gra <= 0; Rin <= 0;
			end

			/*-----------------------
					 LOAD IMMEDIATE
			-------------------------*/

			ldi3: begin
				Grb <= 1; BAout <= 1; Yin <= 1;
				#25 Grb <= 0; BAout <= 0; Yin <= 0;
			end

			ldi4: begin
				Cout <= 1; Zin <= 1;
				#25 Cout <= 0; Zin <= 0;
			end

			ldi5: begin
				Gra <= 1; Rin <= 1; Zlowout <= 1;
				#25 Gra <= 0; Rin <= 0; Zlowout <= 0;
			end

			/*-----------------------
						  STORE
			-------------------------*/

			st3: begin
				Grb <= 1; BAout <= 1; Yin <= 1;
				#25 Grb <= 0; BAout <= 0; Yin <= 0;
			end

			st4: begin
				Cout <= 1; Zin <= 1;
				#25 Cout <= 0; Zin <= 0;
			end

			st5: begin
				MARin <= 1; Zlowout <= 1;
				#25 MARin <= 0; Zlowout <= 0;
			end

			st6: begin
				MARin <= 1; Zlowout <= 1;
				#25 MARin <= 0; Zlowout <= 0;
			end
			st7: begin
				Gra <= 1; Rout <= 1; MDRin <= 1; Write <= 1;
				#25 Gra <= 0; Rout <= 0; MDRin <= 0; Write <= 0;
			end

			/*-----------------------
					  JUMP RETURN
			-------------------------*/
			
			jr3: begin
				Gra <= 1; Rout <= 1; PCin <= 1;				
				#25 Gra <= 0; Rout <= 0; PCin <= 0;
			end

			/*-----------------------
					 JUMP AND LINK
			-------------------------*/
			
			jal3: begin
				Grb <= 1; Rin <= 1; PCout <= 1;
				#25 Grb <= 0; Rin <= 0; PCout <= 0;
			end

			jal4: begin
				Gra <= 1; Rout <= 1; PCin <= 1;				
				#25 Gra <= 0; Rout <= 0; PCin <= 0;
			end

			/*-----------------------
					 MOVE FROM HI
			-------------------------*/
			
			mfhi3: begin
				Gra <= 1; Rin <= 1; HIout <= 1;
				#25 Gra <= 0; Rin <= 0; HIout <= 0;
			end

			/*-----------------------
					 MOVE FROM LO
			-------------------------*/
			
			mflo3: begin
				Gra <= 1; Rin <= 1; LOout <= 1;
				#25 Gra <= 0; Rin <= 0; LOout <= 0;
			end

			/*-----------------------
							IN
			-------------------------*/
			
			in3: begin
				Gra <= 1; Rin <= 1; InPortout <= 1;
				#25 Gra <= 0; Rin <= 0; InPortout <= 0;
			end

			/*-----------------------
						   OUT
			-------------------------*/
			
			out3: begin
				Gra <= 1; Rout <= 1; OutPortin <= 1;
				#25 Gra <= 0; Rout <= 0; OutPortin <= 0;
			end

			/*-----------------------
						 BRANCH
			-------------------------*/
			
			br3: begin	
				Gra <= 1; Rout <= 1;
				#10 CONin <= 1;
				#15 Gra <= 0; Rout <= 0; CONin <= 0;
			end

			br4: begin
				PCout <= 1; Yin <= 1;
				#25 PCout <= 0; Yin <= 0;
			end

			br5: begin
				Cout <= 1; Zin <= 1;
				#25 Cout <= 0; Zin <= 0;
			end

			br6: begin
				PCin <= 1; Zlowout <= 1;
				#25 PCin <= 0; Zlowout <= 0;
			end

			/*-----------------------
					  NO OPERATION
			-------------------------*/
			
			nop3: begin
			end

			/*-----------------------
						  HALT
			-------------------------*/
			
			halt3: begin
				Run <= 0;
			end
			
			default: begin 
			end
		endcase
	end
endmodule