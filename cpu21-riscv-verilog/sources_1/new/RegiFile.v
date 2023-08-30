`timescale 1ns / 1ps

module RegiFile(
	read_reg1_addr	,
    read_reg2_addr	,
    write_reg_addr	,
    data_in			,
    write_read_ena	,
    clk				,        
    read_reg1_data	,
    read_reg2_data	
);
    input [4:0]read_reg1_addr;
    input [4:0]read_reg2_addr;
    input [4:0]write_reg_addr;
    input [31:0]data_in;
    input write_read_ena,clk;
                    
    output reg[31:0]read_reg1_data;
    output reg[31:0]read_reg2_data;
    reg [31:0] regifile[31:0];
	integer k;
	
    initial begin
        for(k=0;k<32;k=k+1)
            regifile[k]=0;
        read_reg1_data <= 0;
        read_reg2_data <= 0;
    end

    always @(posedge clk) begin
        if(write_read_ena && write_reg_addr) begin
            regifile[write_reg_addr] <= data_in;
        end
    end
    
    always @(*) begin
        read_reg1_data <= regifile[read_reg1_addr];
        read_reg2_data <= regifile[read_reg2_addr];
    end    
endmodule
