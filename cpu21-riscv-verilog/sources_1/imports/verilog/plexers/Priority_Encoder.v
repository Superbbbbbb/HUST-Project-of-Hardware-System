`timescale 1ns/1ps

module Priority_Encoder( input_vector,Address);

   parameter NrOfInputBits = 4;
   parameter NrOfSelectBits = 2;

   input[NrOfInputBits-1:0]  input_vector;
   output[NrOfSelectBits-1:0] Address;

   wire[4:0] s_address;
   wire[32:0] v_select_1_vector;
   wire[15:0] v_select_2_vector;
   wire[7:0] v_select_3_vector;
   wire[3:0] v_select_4_vector;

   assign Address = s_address[NrOfSelectBits-1:0];
   assign v_select_1_vector[32:NrOfInputBits] = 0;
   assign v_select_1_vector[NrOfInputBits-1:0] = input_vector;
   assign s_address[4] = (v_select_1_vector[31:16] == 0) ? 1'b0 : 1'b1;
   assign v_select_2_vector = (v_select_1_vector[31:16] == 0) ? v_select_1_vector[15:0] : v_select_1_vector[31:16];
   assign s_address[3] = (v_select_2_vector[15:8] == 0) ? 1'b0 : 1'b1;
   assign v_select_3_vector = (v_select_2_vector[15:8] == 0) ? v_select_2_vector[7:0] : v_select_2_vector[15:8];
   assign s_address[2] = (v_select_3_vector[7:4] == 0) ? 1'b0 : 1'b1;
   assign v_select_4_vector = (v_select_3_vector[7:4] == 0) ? v_select_3_vector[3:0] : v_select_2_vector[7:4];
   assign s_address[1] = (v_select_4_vector[3:2] == 0) ? 1'b0 : 1'b1;
   assign s_address[0] = (v_select_4_vector[3:2] == 0) ? v_select_4_vector[1] : v_select_4_vector[3];

endmodule
