`timescale 1ns/1ps

module Mux_2(MuxIn_0,MuxIn_1,Sel,MuxOut);

   parameter NrOfBits = 32;
    
   input[NrOfBits-1:0]  MuxIn_0;
   input[NrOfBits-1:0]  MuxIn_1;
   input  Sel;

   output[NrOfBits-1:0] MuxOut;

   reg[NrOfBits-1:0] s_selected_vector;

   assign MuxOut = s_selected_vector;

   always @(*)
   begin
      case (Sel)
         1'b0:
            s_selected_vector <= MuxIn_0;
         default:
            s_selected_vector <= MuxIn_1;
      endcase
   end

endmodule
