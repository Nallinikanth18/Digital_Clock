/* ------------------------------------------------------ *
 * Project     : Digital Clock                            *
 * Module      : mux_4_to_1_7bit                          *
 * ------------------------------------------------------ *
 * File        : mux_4_to_1_7bit.v                        *
 * Author      : Nallinikanth                             *
 * Last Edit   : 25/05/2021                               *
 * ------------------------------------------------------ *
 * Description : Creates a 7-bit input and output 4:1 MUX *			    *
 * ------------------------------------------------------ */

 // included module : mux_2_to_1_7bit   (Creates a 7-bit input and output 2:1 MUX)

// building a 4:1 mux using 3 2:1 muxes
module mux_4_to_1_7bit (input [0:1]s,
                        input [0:6]i_00,
                        input [0:6]i_01,
                        input [0:6]i_10,
                        input [0:6]i_11,

                        output [0:6]out);

wire [0:6] t0;
wire [0:6] t1;

mux_2_to_1_7bit MUX1 (.s(s[1]), .i0(i_00), .i1(i_01), .out(t0));
mux_2_to_1_7bit MUX2 (.s(s[1]), .i0(i_10), .i1(i_11), .out(t1));
mux_2_to_1_7bit MUX3 (.s(s[0]),   .i0(t0),   .i1(t1), .out(out));

endmodule
