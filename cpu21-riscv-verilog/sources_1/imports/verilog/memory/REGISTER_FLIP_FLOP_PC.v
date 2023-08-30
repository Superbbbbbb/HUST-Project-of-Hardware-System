`timescale 1ns/1ps

module REGISTER(Clock,ClockEnable,D,Reset,Tick,Q);

   integer ActiveLevel = 1;
   parameter NrOfBits = 32;
   input Clock,ClockEnable,Reset,Tick;
   input[NrOfBits-1:0]  D;
   output reg[NrOfBits-1:0] Q;
   
   initial begin
       Q <= 0;
   end

   always @(posedge Clock or posedge Reset)
   begin
      if (Reset) Q <= 0;
      else if (ClockEnable&Tick) Q <= D;
   end

endmodule
