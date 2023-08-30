`timescale 1ns / 1ps

module ALU(a_i,b_i,alu_op,result,E,GE);
    input [31:0]a_i,b_i;
    input [3:0]alu_op;
    output reg[31:0]result;
    output reg E,GE;

    always@(a_i or b_i)
        begin
            case(alu_op[3:0])
                4'd0:result<= a_i<<b_i[4:0];
                4'd1:result<= a_i[31]?~(32'hffffffff>>b_i[4:0])|(a_i>>b_i[4:0]):a_i>>b_i[4:0];
                4'd2:result<= a_i>>b_i[4:0];
                4'd5:result<= a_i+b_i;
                4'd6:result<= a_i-b_i;
                4'd7:result<= a_i&b_i;
                4'd8:result<= a_i|b_i;
                4'd9:result<= a_i^b_i;
                4'd10:result<= ~(a_i|b_i);
                4'd11:result<= a_i[31]>b_i[31]||(a_i[31]==b_i[31]&&a_i[31]==0&&a_i<b_i)||(a_i[31]==b_i[31]&&a_i[31]==1&&a_i[30:0]>b_i[30:0]);
                4'd12:result<= (a_i<b_i)?1:0;
                default:result<=0;
            endcase
            E<=(a_i==b_i)?1:0;
            GE<=(a_i[31]==0&&b_i[31]==0&&a_i<b_i)?0:(a_i[31]==1&&b_i[31]==1&&a_i>b_i)?0:(a_i[31]==1&&b_i[31]==0)?0:1;
        end
endmodule
