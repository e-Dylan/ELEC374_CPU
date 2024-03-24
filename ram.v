module ram(input [31:0] data_in, input [31:0] address, input read, input write, output reg [31:0] data_out);
	reg [31:0] ram[511:0];
	
	initial begin
		// load testbenches
		// ld R2, 0x95 		instruction : 32'b00000_0010_0000_0000_0000_0000_1011_110;
		// ld R2, 0x38(R2) 	instruction : 32'b00000_0010_0010_0000_0000_0000_0100_110;
		
		// store testbenches
		// ldi R1, 0x43			instruction : 32'b00001_0001_0000_0000_0000_0000_0101_011;
		// st 0x87, R1			instruction : 32'b00010_0001_0000_0000_0000_0000_1010_111;
		// st 0x87(R1), R1	instruction : 32'b00010_0001_0001_0000_0000_0000_1010_111;
		ram[0] = 32'b00000_0001_0000_0000_0000_0000_0101_011;
		ram[1] = 32'b00010_0001_0001_0000_0000_0000_1010_111;
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