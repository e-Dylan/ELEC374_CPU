module datapath(
	input wire clock, clear,
	input wire [31:0] A,
	input wire [31:0] RegisterAImmediate,
	input wire RZout, RAout, RBout, MDRout,
	input wire RAin, RBin, RZin, MDRin
);

wire [31:0] BusMuxOut, BusMuxInMDR, BusMuxInRZ, BusMuxInRA, BusMuxInRB;

wire [31:0] Zregin;

// Devices
register RA(clear, clock, RAin, RegisterAImmediate, BusMuxInRA);
register RB(clear, clock, RBin, BusMuxOut, BusMuxInRB);
MDR mdr(clear, clock, BusMuxOut, Mdatain, read, MDRin, BusMuxInMDR);

// adder
adder add(A, BusMuxOut, Zregin);
register RZ(clear, clock, RZin, Zregin, BusMuxInRZ);

// Bus
Bus bus(BusMuxInRZ, BusMuxInRA, BusMuxInRB, BusMuxInMDR, RZout, RAout, RBout, MDRout, BusMuxOut);

endmodule
