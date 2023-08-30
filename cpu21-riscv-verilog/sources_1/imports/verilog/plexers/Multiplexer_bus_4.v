`timescale 1ns/1ps

module Mux_4(MuxIn_0,MuxIn_1,MuxIn_2,MuxIn_3,Sel,MuxOut);

   parameter NrOfBits = 32;

   input[NrOfBits-1:0]  MuxIn_0;
   input[NrOfBits-1:0]  MuxIn_1;
   input[NrOfBits-1:0]  MuxIn_2;
   input[NrOfBits-1:0]  MuxIn_3;
   input[1:0]  Sel;
   output[NrOfBits-1:0] MuxOut;

   reg[NrOfBits-1:0] s_selected_vector;

   assign MuxOut = s_selected_vector;

   always @(*)
   begin
      case (Sel)
         2'b00:
            s_selected_vector <= MuxIn_0;
         2'b01:
            s_selected_vector <= MuxIn_1;
         2'b10:
            s_selected_vector <= MuxIn_2;
         default:
            s_selected_vector <= MuxIn_3;
      endcase
   end

endmodule
