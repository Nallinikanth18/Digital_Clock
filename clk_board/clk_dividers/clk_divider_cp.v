/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : clk_divider_cp                     *
 * ------------------------------------------------ *
 * File        : clk_divider_cp.v                   *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : A clock divider that generates a   *
		         clock of 0.125Hz frequency         *
 * ------------------------------------------------ */

 // included module : d_ff              (Creates a D-flip flop)
 // included module : mux2_1            (Creates a 2:1 MUX    )
 // included module : comparator_for_8s (compares input with 399999999)


module clk_divider_cp (input clk_in,
                       input reset,
                       output clk_out);

reg [0:28] temp = 0;
parameter P = 29'd3_999_999_99;  //111_011_100_110_101_100_100_111_111_11 in binary

wire d,
     q,
     qbar;
wire toggle;

comparator_for_8s COMP (temp, toggle); // toggle changes to 1 when temp = P

always @(posedge clk_in)           // A 29 bit counter to increment temp
if (reset || toggle) temp <=0;
else temp <= temp+1;

// Now we will be connecting a D-flipflop whose input will be coming from a 2:1 mux
// The I0 input of mux is nothing but the output of D-ff (clk_out) and the I1 input is ~clk_out (q_bar)
// The select line of the mux is the 'toggle' generated in comparator_for_1hz.

d_ff Dff (clk_in,reset,d,clk_out,qbar);
mux2_1 M (.I0(clk_out), .I1(qbar), .S(toggle), .O(d));

endmodule
