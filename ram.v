module ram(input [31:0] data_in, input [31:0] address, input read, input write, output reg [31:0] data_out);
	reg [31:0] ram[511:0];
	
	initial begin
	// load testbenches
		// ld R2, 0x95 		instruction : 32'b00000_0010_0000_0000_0000_0001_0010_101; 
		// ld R2, 0x38(R2) 	instruction : 32'b00000_0010_0010_0000_0000_0000_0110_101; 
		
		// ldi R2, 0x95		instruction : 32'b00001_0010_0000_0000_0000_0001_0010_101;
		// ldi R2, 0x38(R2)	instruction : 32'b00001_0010_0010_0000_0000_0000_0110_101;
		
	// store testbenches
		// ldi R1, 0x43		instruction : 32'b00001_0001_0000_0000_0000_0000_1000_011;
		// st 0x87, R1		instruction : 32'b00010_0001_0000_0000_0000_0001_0000_111; 
		// st 0x87(R1), R1	instruction : 32'b00010_0001_0001_0000_0000_0001_0000_111; 
		
	// branch testbenches
		// branch if zero not taken
		// ldi R5, 0x43			instruction : 32'b00001_0101_0000_0000_0000_0001_0000_011; 
		// brzr R5, 14			instruction : 32'b10011_0101_0000_0000_0000_0000_0001_110;
		// branch if zero taken
		// ldi R5, 0x43			instruction : 32'b00001_0101_0000_0000_0000_0001_0000_011;
		// brzr R5, 14			instruction : 32'b10011_0101_0000_0000_0000_0000_0001_110;
		
		// branch if not zero not taken
		// ldi R5, 0x43			instruction : 32'b00001_0101_0000_0000_0000_0001_0000_011;
		// brnz R5, 14			instruction : 32'b10011_0101_0001_0000_0000_0000_0001_110;
		// branch if not zero taken
		// ldi R5, 0x43			instruction : 32'b00001_0101_0000_0000_0000_0001_0000_011;
		// brnz R5, 14			instruction : 32'b10011_0101_0001_0000_0000_0000_0001_110;
		
		// branch if positive not taken
		// ldi R5, 0x43			instruction : 32'b00001_0101_0000_0000_0000_0001_0000_011;
		// brpl R5, 14			instruction : 32'b10011_0101_0010_0000_0000_0000_0001_110;
		// branch if positive taken
		// ldi R5, 0x43			instruction : 32'b00001_0101_0000_0000_0000_0001_0000_011;
		// brpl R5, 14			instruction : 32'b10011_0101_0010_0000_0000_0000_0001_110;
		
		// branch if negative not taken
		// ldi R5, 0x43			instruction : 32'b00001_0101_0000_0000_0000_0001_0000_011;
		// brmi R5, 14			instruction : 32'b10011_0101_0011_0000_0000_0000_0001_110;
		// branch if negative taken
		// ldi R5, 0x43			instruction : 32'b00001_0101_0000_0000_0000_0001_0000_011;
		// brmi R5, 14			instruction : 32'b10011_0101_0011_0000_0000_0000_0001_110;

	// immediate testbenches
		// ldi r4, 3			instruction : 32'b00001_0100_0000_0000_0000_0000_0000_011;
		// addi r3, r4, -5    	instruction: 32'b01100_0011_0100_1111_1111_1111_1111_011;
		
		// ldi r4, 3			instruction : 32'b00001_0100_0000_0000_0000_0000_0000_011;
		// andi r3, r4, 0x53    instruction: 32'b01101_0011_0100_0000_0000_0000_1010_011;
		
		// ldi r4, 3			instruction : 32'b00001_0100_0000_0000_0000_0000_0000_011; 
		// ori  r3, r4, 0x53    instruction: 32'b01110_0011_0100_0000_0000_0000_1010_011;

	// i/o testbenches
		// ldi R3, 0x43			instruction: 32'b00001_0011_0000_0000_0000_0000_0101_011;
		// out r3				instruction: 32'b10111_0011_0000_0000_0000_0000_0000_000;
		
		// in r4				instruction: 32'b10110_0100_0000_0000_0000_0000_0000_000;
		
	// special instruction testbenches
		// mfhi r6				instruction: 32'b11000_0110_0000_0000_0000_0000_0000_000;
		// mflo r7				instruction: 32'b11001_0111_0000_0000_0000_0000_0000_000;
		
	//jump testbenches
		// ldi R6, 0x43			instruction: 32'b00001_0110_0000_0000_0000_0000_1000_011; 
		// jr R6				instruction: 32'b10100_0110_0000_0000_0000_0000_0000_000;
		
		// ldi R6, 0x43			instruction: 32'b00001_0110_0000_0000_0000_0000_1000_011;
		// jal R6				instruction: 32'b10101_0110_1111_0000_0000_0000_0000_000;
		
	//nop instruction
		// instruction: 32'b11010_0000_0000_0000_0000_0000_0000_000;
		

		//initialize 0x47 with 0x94 
		ram[71] = 32'b10010100;
		
		//and 0x8E with 0x34
		ram[142] = 32'b00110100;

					
		ram[0] = 32'b00001_0010_0000_0000_0000_0000_1101_001;// ldi R2, 0x69 ; R2 = 0x69
		ram[1] = 32'b00001_0010_0010_0000_0000_0000_0000_010;// ldi R2, 2(R2) ; R2 = 0x6B
		ram[2] = 32'b00000_0001_0000_0000_0000_000o_1000_111;// ld R1, 0x47 ; R1 = (0x47) = 0x94
		ram[3] = 32'b00001_0001_0001_0000_0000_0000_0000_001;// ldi R1, 1(R1) ; R1 = 0x95
		ram[5] = 32'b00000_0000_0000_1111_1111_1111_1111_001;// ld R0, -7(R1) ; R0 = (0x8E) = 0x34
		ram[6] = 32'b00001_0011_0000_0000_0000_0000_0000_011;// ldi R3, 3 ; R3 = 3
		ram[7] = 32'b00001_0010_0000_0000_0000_0000_1000_011;// ldi R2, 0x43 ; R2 = 0x43
		ram[8] = 32'b10011_0010_0000_0000_0000_0000_0000_011;// brmi R2, 3 ; continue with the next instruction (will not branch)
		ram[9] = 32'b00001_0010_0010_0000_0000_0000_0000_110;// ldi R2, 6(R2) ; R2 = 0x49
		ram[10] = 32'b00000_0111_0010_1111_1111_1111_1111_110;// ld R7, -2(R2) ; R7 = (0x49 - 2) = 0x94
		ram[11] = 32'b11010_0000_0000_0000_0000_0000_0000_000;// nop
		ram[12] = 32'b10011_0111_0000_0000_0000_0000_0000_010;// brpl R7, 2 ; continue with the instruction at “target” (will branch)
		ram[13] = 32'b00001_0010_0010_0000_0000_0000_0000_100;// ldi R5, 4(R2) ; this instruction will not execute
		ram[15] = 32'b00001_0100_0101_1111_1111_1111_1111_101;// ldi R4, -3(R5) ; this instruction will not execute
		ram[16] = 32'b00011_0010_0010_0011_0000_0000_0000_000;// target: add R2, R2, R3 ; R2 = 0x4C
		ram[17] = 32'b01100_0111_0111_0000_0000_0000_0000_011;// addi R7, R7, 3 ; R7 = 0x97
		ram[18] = 32'b10001_0111_0111_0000_0000_0000_0000_000;// neg R7, R7 ; R7 = 0xFFFFFF69
		ram[19] = 32'b10010_0111_0111_0000_0000_0000_0000_000;// not R7, R7 ; R7 = 0x96
		ram[20] = 32'b01101_0111_0111_0000_0000_0000_0001_111;// andi R7, R7, 0xF ; R7 = 6
		ram[21] = 32'b01000_0001_0000_0011_0000_0000_0000_000;// ror R1, R0, R3 ; R1 = 0x80000006
		ram[22] = 32'b01110_0111_0001_0000_0000_0000_0001_001;// ori R7, R1, 9 ; R7 = 0x8000000F
		ram[23] = 32'b00110_0001_0111_0011_0000_0000_0000_000;// shra R1, R7, R3 ; R1 = 0xF0000001
		ram[24] = 32'b00101_0010_0010_0011_0000_0000_0000_000;// shr R2, R2, R3 ; R2 = 9
		ram[25] = 32'b00010_0010_0000_0000_0000_0001_0001_110;// st 0x8E, R2 ; (0x8E) = 9 new value in memory with address 0x8E
		ram[26] = 32'b01001_0010_0000_0011_0000_0000_0000_000;// rol R2, R0, R3 ; R2 = 0x1A0
		ram[27] = 32'b01011_0100_0011_0000_0000_0000_0000_000;// or R4, R3, R0 ; R4 = 0x37
		ram[28] = 32'b01010_0001_0010_0000_0000_0000_0000_000;// and R1, R2, R0 ; R1 = 0x20

		ram[37] = 
		
		
		

	
	always @(*)
		begin
		if (write)
			ram[address] <= data_in;
		else if (read)
			data_out <= ram[address];
		else
			data_out <= 32'b0;
	end
endmodule
