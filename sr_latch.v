/* ------------------------------------------------------ *
 * Project     : Digital Clock                            *
 * Module      : sr_latch                                 *
 * ------------------------------------------------------ *
 * File        : sr_latch.v                               *
 * Author      : Nallinikanth                             *
 * Last Edit   : 25/05/2021                               *
 * ------------------------------------------------------ *
 * Description : Creates a sr latch with reset option     *
 * ------------------------------------------------------ */


module sr_latch (input s,
                 input r,
                 input reset,

                 output q,
                 output qbar);

not n1(reset_bar,reset);
nand g1 (q,s,qbar),
     g2 (qbar,r,q,reset_bar);

endmodule
