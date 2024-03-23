module ram(input [31:0] data_in, input [31:0] address, input read, input write, output reg [31:0] data_out);
	reg [31:0] ram[511:0];
	
	initial begin
		// ld R2, 0x95 		instruction : 32'b00011_0010_0000_0000_0000_0000_1011_110;
		// ld R2, 0x38(R2) 	instruction : 32'b00011_0010_0010_0000_0000_0000_0100_110;
		ram[0] = 32'b00011_0010_0000_0000_0000_0000_1011_111;
		ram[1] = 32'b00011_0000_0010_0000_0000_0000_0100_110;
		ram[38] = 32'b0101;
		ram[51] = 32'b0111;
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