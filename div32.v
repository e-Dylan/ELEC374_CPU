
module div32(
   input wire signed [31:0] RegA,
   input wire signed [31:0] RegB,
   output wire signed [63:0] Z
);
   integer i;
   reg signed [31:0] A;
   reg signed [31:0] Q;
   reg signed [31:0] M;
   reg q0;

   always @ (*) begins
      Q = RegA;
      M = RegB;
      A = 32'sb0;

      for (i = 0; i < 32; i = i + 1) begin
         {A, Q} = {A, Q} << 1;
         A = A - M;
         if (A[31] == 1'b0) begin
               Q[0] = 1;
         end
         else if (A[31] == 1'b1) begin
               Q[0] = 0;
               A = A + M;
         end
      end
   assign Z = {A, Q};

endmodule