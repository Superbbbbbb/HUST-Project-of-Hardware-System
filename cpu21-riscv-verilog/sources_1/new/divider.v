`timescale 1ns / 1ps

module divider(clk,clk_N);
    input clk;
    output reg clk_N;
    reg [31:0] counter;           
    integer N= 10;
    
    initial begin
        clk_N<=0;
        counter<=0;
    end
           
    always @(posedge clk) begin 
        counter<=counter+1;                   
        if(counter>=(N/2)-1) begin
            clk_N<=~clk_N;
            counter<=0;
        end
    end                           
endmodule
