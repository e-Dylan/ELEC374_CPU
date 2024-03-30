module ff_logic(input wire clk, 
                input wire D, 
                output reg Q);	

	initial begin
		Q <= 0;
    end

	always@(clk) 
	begin
		Q <= D;
    end
endmodule