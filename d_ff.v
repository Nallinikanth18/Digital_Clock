/* ------------------------------------------------------ *
 * Project     : Digital Clock                            *
 * Module      : d_ff                                     *
 * ------------------------------------------------------ *
 * File        : d_ff.v                                   *
 * Author      : Nallinikanth                             *
 * Last Edit   : 25/05/2021                               *
 * ------------------------------------------------------ *
 * Description : Creates D-flipflop with asynchronous     *
		         reset
 * ------------------------------------------------------ */

 // included module : sr_latch   (Creates a sr latch with reset option)

//-----------------------------------------------making D-flipflop with asynchronous reset
//Idea we will be using 3 sr-latches to build a d-flip-flop.
// note that d-flip-flop can also be made using 2 D-latches but here we are using 3 sr-latches.

module d_ff (input clk,
             input reset,
             input d,

             output q,
             output qbar);


wire r1,
     s1,
     s;

not n1 (reset_bar,reset);
sr_latch SR1 (r1,clk,reset,s1,s);    //1st sr-latch

nand SR2_g1 (r,s,clk,r1),            //2nd sr-latch
     SR2_g2 (r1,d,r,reset_bar);

sr_latch SR3 (s,r,reset,q,qbar);     //3rd sr-latch

endmodule
