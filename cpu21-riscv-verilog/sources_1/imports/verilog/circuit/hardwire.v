`timescale 1ns/1ps

module hardwire( Funct,
                 OP,
                 ALU_OP,
                 ALU_SRC,
                 BGE,
                 Beq,
                 Bne,
                 JAL,
                 Jalr,
                 LB,
                 MemToReg,
                 MemWrite,
                 RegWrite,
                 S_type,
                 ecall);

    input[4:0]  Funct;
    input[4:0]  OP;

    output reg [3:0] ALU_OP;
    output reg ALU_SRC,BGE,Beq,Bne,JAL,Jalr,LB,MemToReg,MemWrite,RegWrite,S_type,ecall;
    
    always@(*) begin
        {ALU_SRC,BGE,Beq,Bne,JAL,Jalr,LB,MemToReg,MemWrite,RegWrite,S_type,ecall} = 12'b0;
        ALU_OP <= 4'd0;
        case(OP[4:0])
            5'hc:begin
                RegWrite<=1'b1;
                case(Funct[2:0])
                    3'd0:begin
                        case(Funct[4])
                            1'd0: ALU_OP<=4'd5;
                            1'd1: ALU_OP<=4'd6; 
                        endcase
                    end
                    3'd7: ALU_OP<=4'd7;
                    3'd6: ALU_OP<=4'd8;
                    3'd2: ALU_OP<=4'd11;
                    3'd3: ALU_OP<=4'd12;
                    3'd1: ALU_OP<=4'd0;
                    3'd5: ALU_OP<=4'd2;
                endcase
            end
            5'h4:begin
                RegWrite<=1'b1;
                ALU_SRC<=1'b1;
                case(Funct[2:0])
                    3'd0: ALU_OP<=4'd5;
                    3'd7: ALU_OP<=4'd7;
                    3'd6: ALU_OP<=4'd8;
                    3'd4: ALU_OP<=4'd9;
                    3'd2: ALU_OP<=4'd11;
                    3'd1: ALU_OP<=4'd0;
                    3'd5: begin
                        case(Funct[4])
                            1'd0: ALU_OP<=4'd2;
                            1'd1: ALU_OP<=4'd1; 
                        endcase
                    end
                endcase
            end
            5'h0:begin
                RegWrite<=1'b1;
                ALU_SRC<=1'b1;
                MemToReg<=1'b1;
                case(Funct[2:0])
                    3'd0:LB<=1'b1;
                endcase
            end
            5'h8:begin
                ALU_SRC<=1'b1;
                MemWrite<=1'b1;
                S_type<=1'b1;
            end
            5'h1c: ecall<=1'b1;
            5'h18: begin
                case(Funct[2:0])        
                    3'd0:begin
                        Beq<=1'b1;
                        ALU_OP<=4'd6;
                        {BGE,Bne} = 2'b0;
                    end
                    3'd1:begin
                        Bne<=1'b1;
                        ALU_OP<=4'd6;
                        {BGE,Beq} = 2'b0;
                    end
                    3'd5:begin
                        BGE<=1'b1;
                        ALU_OP<=4'd11;
                        {Beq,Bne} = 2'b0;
                    end
                endcase
            end
            5'h1b:begin
                RegWrite<=1'b1;
                JAL<=1'b1;
            end
            5'h19:begin
                ALU_OP<=4'd6;
                RegWrite<=1'b1;
                ALU_SRC<=1'b1;
                Jalr<=1'b1;
            end   
        endcase
    end
    
endmodule
