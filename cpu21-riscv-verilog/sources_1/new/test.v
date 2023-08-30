`timescale 1ns / 1ps

module test(clk,start,rst,go,LedData,clk_N,SEG,AN);
    input clk,start,rst,go;
    output [7:0]SEG,AN;
    output clk_N;
    output [31:0]LedData;
    wire clk_N;
    wire [2:0]count;
    wire [4:0]cnt;
    wire [31:0]LedData;
       
    divider(clk,clk_N);
    counter(clk_N,count[2:0]);
    decoder(.num(count[2:0]),.sel(AN[7:0]));
    assign cnt = {count[2:0],2'b0};
    cpu_riscv(clk_N,start,rst,go,LedData);
    pattern p(LedData[cnt+:4], SEG[7:0]);
endmodule
