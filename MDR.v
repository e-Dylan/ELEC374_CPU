module MDR (clear, clock, BusMuxOut, Mdatain, read, MDRin, q);
	input [31:0] BusMuxOut;
	input [31:0] Mdatain;
	input read;
	input clear, clock, MDRin;
	output[31:0] q;
	reg[31:0] q;
	
	always @ (posedge clock or negedge clear) begin
		if (!clear)
			q <= 32'b0;
		else
			if (MDRin)
				if (!read)
					q <= BusMuxOut;
				else
					q <= Mdatain;
			else
				q <= q;
	end
endmodule
