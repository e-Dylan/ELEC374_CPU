module Bus (
	// Mux
	input [31:0]BusMuxInRZ, 
	input [31:0]BusMuxInRA, 
	input [31:0]BusMuxInRB, 
	input [31:0] BusMuxInMDR,
	
	// Encoder
	input RZout, RAout, RBout, MDRout,
	
	output wire [31:0]BusMuxOut
);

reg [31:0]q;

always @ (*) begin
	if (RZout) q = BusMuxInRZ;
	if (RAout) q = BusMuxInRA;
	if (RBout) q = BusMuxInRB;
	if (MDRout) q = BusMuxInMDR;
end

assign BusMuxOut = q;
endmodule
