module ram(input [31:0] data_in, input [31:0] address, input read, input write, output reg [31:0] data_out);
	reg [31:0] ram[511:0];
	
	initial begin
		// load testbenches
		// ld R2, 0x95 		instruction : 32'b00000_0010_0000_0000_0000_0000_1011_110;
		// ld R2, 0x38(R2) 	instruction : 32'b00000_0010_0010_0000_0000_0000_0100_110;
		
		// store testbenches
		// ldi R1, 0x43		instruction : 32'b00001_0001_0000_0000_0000_0000_0101_011;
		// st 0x87, R1			instruction : 32'b00010_0001_0000_0000_0000_0000_1010_111;
		// st 0x87(R1), R1	instruction : 32'b00010_0001_0001_0000_0000_0000_1010_111;
		
		// branch testbenches
		// branch if zero not taken
		// ldi R5, 0x43		instruction : 32'b00001_0101_0000_0000_0000_0000_0101_011;
		// brzr R5, 14			instruction : 32'b10011_0101_0000_0000_0000_0000_0001_110;
		// branch if zero taken
		// ldi R5, 0x43		instruction : 32'b00001_0101_0000_0000_0000_0000_0000_000;
		// brzr R5, 14			instruction : 32'b10011_0101_0000_0000_0000_0000_0001_110;
		
		// branch if not zero not taken
		// ldi R5, 0x43		instruction : 32'b00001_0101_0000_0000_0000_0000_0000_000;
		// brnz R5, 14			instruction : 32'b10011_0101_0001_0000_0000_0000_0001_110;
		// branch if not zero taken
		// ldi R5, 0x43		instruction : 32'b00001_0101_0000_0000_0000_0000_0101_011;
		// brnz R5, 14			instruction : 32'b10011_0101_0001_0000_0000_0000_0001_110;
		
		// branch if positive not taken
		// ldi R5, 0x43		instruction : 32'b00001_0101_0000_0000_1111_0000_0101_011;
		// brpl R5, 14			instruction : 32'b10011_0101_0010_0000_0000_0000_0001_110;
		// branch if positive taken
		// ldi R5, 0x43		instruction : 32'b00001_0101_0000_0000_0000_0000_0101_011;
		// brpl R5, 14			instruction : 32'b10011_0101_0010_0000_0000_0000_0001_110;
		
		// branch if negative not taken
		// ldi R5, 0x43		instruction : 32'b00001_0101_0000_0000_0000_0000_0101_011;
		// brmi R5, 14			instruction : 32'b10011_0101_0011_0000_0000_0000_0001_110;
		// branch if negative taken
		// ldi R5, 0x43		instruction : 32'b00001_0101_0000_0000_1000_0000_0101_011;
		// brmi R5, 14			instruction : 32'b10011_0101_0011_0000_0000_0000_0001_110;

		//immediate testbenches
		//addi r2, r3, 2    instruction: 32'b 01100_0010_0011_0000000000000000010;
		//andi r2, r3, 2    instruction: 322'b01101_0010_0011_0000000000000000010;
		//ori  r2, r3, 2    instruction: 32'b 01110_0010_0011_0000000000000000010;

		//jump testbenches
		//jr R15	instruction: 32'b10100_1111_00000000000000000000000;
		//jal R4	instruction: 32'b10101_0100_00000000000000000000000;

		// i/o testbenches
		// out r3				instruction: b'32 10111_0011_0000_0000_0000_0000_0000_0000
		// in r4					instruction: b'32 10110_0100_0000_0000_0000_0000_0000_0000
		
		// special instruction testbenches
		// mfhi r6				instruction: b'32 11000_0110_0000_0000_0000_0000_0000_0000
		// mflo r7				instruction: b'32 11001_0111_0000_0000_0000_0000_0000_0000
		
		// jr testbenches
		// ldi R6, 0x43		instruction: 32'b00001_0110_0000_0000_0000_0000_0101_011;
		// jr R6					instruction: 32'b10100_0110_0000_0000_0000_0000_0000_000;
		
		// jal testbenches
		// ldi R6, 0x43		instruction: 32'b00001_0110_0000_0000_0000_0000_0101_011;
		// jr R6					instruction: 32'b10100_0110_1111_0000_0000_0000_0000_000;
		
		ram[0] = 32'b00001_0110_0000_0000_0000_0000_0101_011;
		ram[1] = 32'b10100_0110_1111_0000_0000_0000_0000_000;
		ram[43] = 32'b0010;
		ram[51] = 32'b0111;
		ram[87] = 32'b0011;
		ram[95] = 32'b1101;
	end
	
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