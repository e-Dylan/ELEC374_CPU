module ff_logic(input wire clk, 
                input wire A, 
                output reg B, 
                output reg B_not);	

	initial begin
		B <= 0;
		B_not <= 1;
    end

	always@(clk) 
	begin
		B <= A;
		B_not <= !A;
    end
endmodule