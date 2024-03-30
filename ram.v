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

					
		ram[0] = 32'b00001_0010_0000_0000_0000_0000_1101_001;
		ram[1] = 32'b00001_0010_0010_0000_0000_0000_0000_010;
		ram[2] = 32'b00000_0001_0000_0000_0000_000o_1000_111; 
		ram[3] = 32'b00001_0001_0001_0000_0000_0000_0000_001;
		ram[5] = 32'b00000_0000_0000_1111_1111_1111_1111_001; 
		ram[6] = 32'b00001_0011_0000_0000_0000_0000_0000_011;
		ram[7] = 32'b00001_0010_0000_0000_0000_0000_1000_011;
		ram[8] = 32'b10011_0010_0000_0000_0000_0000_0000_011;
		ram[9] = 32'b00001_0010_0010_0000_0000_0000_0000_110;
		ram[10] = 32'b00000_0111_0010_1111_1111_1111_1111_110;
		ram[11] = 32'b11010_0000_0000_0000_0000_0000_0000_000;
		ram[12] = 32'b10011_0111_0000_0000_0000_0000_0000_010;
		ram[13] = 32'b00001_0010_0010_0000_0000_0000_0000_100;
		ram[15] = 32'b00001_0100_0101_1111_1111_1111_1111_101;
		ram[16] = 
		ram[17] = 
		ram[18] = 
		ram[19] = 
		ram[20] = 
		ram[21] = 
		ram[22] = 
		ram[23] = 
		ram[24] = 
		
		
		
		
		
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
