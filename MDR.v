module MDR (clear, clock, MDRin, BusMuxOut, Mdatain, Read, q);
	input [31:0] BusMuxOut;
	input [31:0] Mdatain;
	input Read;
	input clear, clock, MDRin;
	output[31:0] q;
	reg[31:0] q;
	
	always @ (posedge clock) begin
		if (clear)
			q <= 32'b0;
		else
			if (MDRin)
				if (!Read)
					q <= BusMuxOut;
				else
					q <= Mdatain;
			else
				q <= q;
	end
endmodule
