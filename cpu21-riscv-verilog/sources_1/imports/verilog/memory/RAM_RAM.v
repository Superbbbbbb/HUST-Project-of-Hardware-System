`timescale 1ns/1ps

module RAM(clk, addr,
                d,
                we,
                q);

   /***************************************************************************
    ** Here the inputs are defined                                           **
    ***************************************************************************/
   input[9:0]  addr;
   input  clk;
   input[31:0]  d;
   input  we;

   /***************************************************************************
    ** Here the outputs are defined                                          **
    ***************************************************************************/
   output[31:0] q;

	reg [31:0] mem[1023:0];
	integer k;
	
	initial begin
	   for(k=0;k<1024;k=k+1)
	       mem[k]=0;
	end
	
	always @ (posedge clk) begin
		if (we)
			mem[addr] <= d;
	end
	assign q = mem[addr];

endmodule
