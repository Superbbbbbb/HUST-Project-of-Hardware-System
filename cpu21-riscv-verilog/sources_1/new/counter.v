`timescale 1ns / 1ps

module counter(clk, out);
    input clk;
    output reg [2:0] out;
    
    always @(posedge clk)  begin
        out<=out-1;
    end
endmodule
