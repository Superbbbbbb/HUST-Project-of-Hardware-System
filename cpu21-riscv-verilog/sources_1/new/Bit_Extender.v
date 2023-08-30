`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/08 11:48:59
// Design Name: 
// Module Name: Bit_Extender
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Bit_Extender( imm_in,imm_out);
    
    parameter data_width=8;
   /***************************************************************************
    ** Here the inputs are defined                                           **
    ***************************************************************************/
   input[11data_width-:0]  imm_in;

   /***************************************************************************
    ** Here the outputs are defined                                          **
    ***************************************************************************/
   output reg [31:0] imm_out;

	always @(*) begin
		imm_out = {{(20){imm_in[11]}}, imm_in};
	end

endmodule
