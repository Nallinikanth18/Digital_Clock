/* ------------------------------------------------------ *
 * Project     : Digital Clock                            *
 * Module      : mux_2_to_1_7bit                          *
 * ------------------------------------------------------ *
 * File        : mux_2_to_1_7bit.v                        *
 * Author      : Nallinikanth                             *
 * Last Edit   : 25/05/2021                               *
 * ------------------------------------------------------ *
 * Description : Creates a 7-bit input and output 2:1 MUX *			    *
 * ------------------------------------------------------ */


// a 2 : 1 mux is nothing but I0.S' + I1.S.

module mux_2_to_1_7bit (input s,
                        input [0:6]i0,
                        input [0:6]i1,

                        output [0:6]out);


wire s_bar;
wire [0:6] t0;
wire [0:6] t1;

not Gs (s_bar,s);

and G00 (t0[0], s_bar, i0[0]),
    G10 (t1[0], s,     i1[0]),

    G01 (t0[1], s_bar, i0[1]),
    G11 (t1[1], s,     i1[1]),

    G02 (t0[2], s_bar, i0[2]),
    G12 (t1[2], s,     i1[2]),

    G03 (t0[3], s_bar, i0[3]),
    G13 (t1[3], s,     i1[3]),

    G04 (t0[4], s_bar, i0[4]),
    G14 (t1[4], s,     i1[4]),

    G05 (t0[5], s_bar, i0[5]),
    G15 (t1[5], s,     i1[5]),

    G06 (t0[6], s_bar, i0[6]),
    G16 (t1[6], s,     i1[6]);

or G_out0 (out[0], t0[0], t1[0]),
   G_out1 (out[1], t0[1], t1[1]),
   G_out2 (out[2], t0[2], t1[2]),
   G_out3 (out[3], t0[3], t1[3]),
   G_out4 (out[4], t0[4], t1[4]),
   G_out5 (out[5], t0[5], t1[5]),
   G_out6 (out[6], t0[6], t1[6]);

endmodule
