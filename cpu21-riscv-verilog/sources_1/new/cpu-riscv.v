`timescale 1ns/1ps

module cpu_riscv(clk,start,rst,go,LedData);
    input clk,start,rst,go;
    output [31:0]LedData;
    
    wire JAL,JALR,Branch,halt,E,GE,AluSrcB,BGE,Beq,Bne,LB,MemToReg,MemWrite,RegWrite,S_type,ecall;
    wire [31:0]b,j,imm_b,imm_j,PC_plus_4,PC,R,IR,RDin,R1,R2,B,Dout,memword,next_PC,LedData;
    wire [11:0]imm;
    wire [3:0]AluOp;
    wire [4:0]R1_Addr,R2_Addr;
    wire [1:0]sel1,sel2;
    reg [31:0]membyte;
    
    assign PC_plus_4=PC+4;
    ROM rom(PC[11:2],IR[31:0]);
        
    hardwire hardwire({IR[30],IR[25],IR[14:12]},IR[6:2],AluOp,AluSrcB,BGE,Beq,Bne,JAL,JALR,LB,MemToReg,MemWrite,RegWrite,S_type,ecall);
    Mux_2 #(5)mux2_1(IR[19:15],5'h11,ecall,R1_Addr);
    Mux_2 #(5)mux2_2(IR[24:20],5'ha,ecall,R2_Addr);
    assign WD=IR[11:7];
    RegiFile regifile(R1_Addr,R2_Addr,IR[11:7],RDin,RegWrite,clk,R1,R2);
    Mux_2 #(12)mux2_3(IR[31:20],{IR[31:25],IR[11:7]},S_type,imm);
    assign imm_b={{(21){IR[31]}},IR[7],IR[30:25],IR[11:8]};
    assign imm_j={{(13){IR[31]}},IR[19:12],IR[20],IR[30:21]};
    
    assign b=imm_b*2+PC;
    assign j=imm_j*2+PC;
    
    Mux_2 #(32)mux2_4(R2,{{(20){imm[11]}},imm[11:0]},AluSrcB,B);
    ALU alu(R1,B,AluOp,R,E,GE);
    assign Branch=Beq&&E||Bne&&~E||GE&&BGE;
        
    RAM ram(.clk(clk),.addr(R[11:2]),.d(R2),.we(MemWrite),.q(Dout));
    
    Priority_Encoder PE2(.input_vector({1'b0,(JALR||JAL),MemToReg,1'b1}),.Address(sel2));
    Mux_4 mux4_2(R,Dout,PC_plus_4,32'b0,sel2,memword);
    always@(R or memword) begin
        case(R[1:0])
            2'b00: membyte<={{(24){memword[7]}},memword[7:0]};
            2'b01: membyte<={{(24){memword[15]}},memword[15:8]};
            2'b10: membyte<={{(24){memword[23]}},memword[23:16]};
            2'b11: membyte<={{(24){memword[31]}},memword[31:24]};
        endcase
    end
    Mux_2 #(32)mux2_5(memword,membyte,LB,RDin);
        
    REGISTER register2(.Clock(clk),.ClockEnable(ecall&&~(R1==32'ha)),.D(R2),.Reset(rst),.Tick(start),.Q(LedData));
    assign halt = ecall&&(R1==32'ha)&&go;

    Priority_Encoder PE1(.input_vector({JALR,JAL,Branch,1'b1}),.Address(sel1));
    Mux_4 mux4_1(PC_plus_4,b,j,R,sel1,next_PC);
    REGISTER register1(.Clock(clk),.ClockEnable(~halt),.D(next_PC),.Reset(rst),.Tick(start),.Q(PC));
    
endmodule
