module bus (
	input [31:0]	BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3,
						BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7,
						BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11,
						BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15,
						
	input				R0out, R1out, R2out, R3out,
						R4outa R5out, R6out, R7out,
						R8out, R9out, R10out, R11out,
						R12out, R13out, R14out, R15out,
	
	input [31:0]	BusMuxIn_HI, BusMuxIn_LO,
	input 			HIout, LOout,
	
	input [31:0]	BusMuxIn_Y, BusMuxIn_Zhigh, BusMuxIn_Zlow,
	input 			Yout, Zhighout, Zlowout,
	
	input [31:0]	BusMuxIn_PC, BusMuxIn_IR, BusMuxIn_MAR, BusMuxIn_MDR, BusMuxIn_InPort, BusMuxIn_C
	input 			PCout, IRout, MARout, MDRout, InPortout, Cout
	
	output wire [31:0] BusMuxOut
);

reg [31:0] q;

always @ (*) begin
	if (R0out) 			q = BusMuxIn_R0;
	else if (R1out) 	q = BusMuxIn_R1;
	else if (R2out) 	q = BusMuxIn_R2;
	else if (R3out) 	q = BusMuxIn_R3;
	
	else if (R4out) 	q = BusMuxIn_R4;
	else if (R5out) 	q = BusMuxIn_R5;
	else if (R6out) 	q = BusMuxIn_R6;
	else if (R7out) 	q = BusMuxIn_R7;
	
	else if (R8out) 	q = BusMuxIn_R8;
	else if (R9out) 	q = BusMuxIn_R9;
	else if (R10out) 	q = BusMuxIn_R10;
	else if (R11out) 	q = BusMuxIn_R11;
	
	else if (R12out) 	q = BusMuxIn_R12;
	else if (R13out) 	q = BusMuxIn_R13;
	else if (R14out) 	q = BusMuxIn_R14;
	else if (R15out) 	q = BusMuxIn_R15;
	
	else if (LOout) 	q = BusMuxIn_LO;
	else if (HIout) 	q = BusMuxIn_HI;
	
	else if (Yout)			q = BusMuxIn_Y;
	else if (Zhighout) 	q = BusMuxIn_Zhigh;
	else if (Zlowout) 	q = BusMuxIn_Zlow;
	
	else if (PCout) 		q = BusMuxIn_PCout;
	else if (IRout)		q = BusMuxIn_IRout;
	else if (MARout)		q = BusMuxIn_MARout;
	else if (MDRout) 		q = BusMuxIn_MDRout;
	else if (InPortout) 	q = BusMuxIn_Inportout;
	else if (Cout) 		q = BusMuxIn_Cout;
end

assign BusMuxOut = q;
endmodule
