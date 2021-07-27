/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : counter_6bits                      *
 * ------------------------------------------------ *
 * File        : counter_6bits.v                    *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : A 6 bit counter		            *
 * ------------------------------------------------ */

 // included module : parallel_load_6bit_counter   (A structural design of a 6-bit counter)
 // included module : d_ff 			               (Creates a D-flip flop)
 // included module : mux2_1			           (Creates a 2:1 MUX    )


//---------------------Counter--------------------------for seconds and minutes
module counter_6bits(input ld_sec,
                     input reset,
                     output reg [0:5]sec,
                     input clr_sec,
                     input [0:5]input_data,
                     input clk,
                     input en_sec);


always @ (posedge clk, posedge reset)
begin
    if((clr_sec) || (reset)) sec<= 6'b0;
    else if (ld_sec) sec<= input_data;
    else if (en_sec) sec <= sec+1;
end


endmodule

//------------------------A structural description of above counter---------------------------------
//-----------------------A 6bit parallel load counter

module parallel_load_6bit_counter (input en,
                                   input load,
                                   input clear,
                                   input reset,
                                   input clk,
                                   input [5:0]in,

                                   output [5:0]out);



wire clear_reset;
wire [5:0] out_bar;

//-----------------------------------------------------
wire d0, t0_d1, t0;         // for out[0]
wire d1, t1_d1, t1;         // for out[1]
wire d2, t2_d2, t2;         // for out[2]
wire d3, t3_d3, t3;         // for out[3]
wire d4, t4_d4, t4;         // for out[4]
wire d5, t5_d5, t5;         // for out[5]

//-----------------------------------------------------
not O0 (out_bar[0],out[0]),  // for q'
    O1 (out_bar[1],out[1]),
    O2 (out_bar[2],out[2]),
    O3 (out_bar[3],out[3]),
    O4 (out_bar[4],out[4]),
    O5 (out_bar[5],out[5]);
//-----------------------------------------------------
or CR (clear_reset,clear,reset);  // connecting clear and reset

//-----------------------------------------------------
xor G1 (t_d0,en,out[0]);
d_ff   DFF0 (clk,clear_reset,d0,out[0],out_bar[0]);
mux2_1 MUX_DFF0 (t_d0,in[0],load,d0);
and G2 (t0,out[0],en);

xor G3 (t_d1, t0, out[1]);
d_ff   DFF1 (clk,clear_reset,d1,out[1],out_bar[1]);
mux2_1 MUX_DFF1 (t_d1,in[1],load,d1);
and G4 (t1,out[1],t0);

xor G5 (t_d2, t1, out[2]);
d_ff   DFF2 (clk,clear_reset,d2,out[2],out_bar[2]);
mux2_1 MUX_DFF2 (t_d2,in[2],load,d2);
and G6 (t2,out[2],t1);

xor G7 (t_d3,t2,out[3]);
d_ff   DFF3 (clk,clear_reset,d3,out[3],out_bar[3]);
mux2_1 MUX_DFF3 (t_d3,in[3],load,d3);
and G8 (t3,out[3],t2);

xor G9 (t_d4, t3, out[4]);
d_ff   DFF4 (clk,clear_reset,d4,out[4],out_bar[4]);
mux2_1 MUX_DFF4 (t_d4,in[4],load,d4);
and G10 (t4,out[4],t3);

xor G11 (t_d5, t4, out[5]);
d_ff   DFF5 (clk,clear_reset,d5,out[5],out_bar[5]);
mux2_1 MUX_DFF5 (t_d5,in[5],load,d5);
and G12 (t5,out[5],t4);

endmodule
