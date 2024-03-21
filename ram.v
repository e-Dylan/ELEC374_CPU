module ram(input [31:0] data_in, input [31:0] address, input read, input write, output reg [31:0] data_out);
	reg [31:0] ram[511:0];
	
	initial begin
		// $readmemh("init.hex", ram);
		ram[0] = 32'b00011_0010_0000_00000000_00000000_000;
		ram[94] = 32'b1101;
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