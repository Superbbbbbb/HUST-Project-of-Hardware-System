`timescale 1ns / 1ps

module tb;
    reg clk,go;
    wire [31:0]LedData;
    cpu_riscv c(clk,1'b1,0,go,LedData);
    integer k;
    initial begin
        clk<=0;
        go<=0;
        for(k=0;k<4500;k=k+1) begin
            #1 clk=~clk;
            if(k==3100) go<=1;
            if(k==3103) go<=0;
            if(k==3300) go<=1;
            if(k==3303) go<=0;
            if(k==3500) go<=1;
            if(k==3503) go<=0;
            if(k==4200) go<=1;
            if(k==4203) go<=0;
        end        
        $stop;
    end
endmodule
