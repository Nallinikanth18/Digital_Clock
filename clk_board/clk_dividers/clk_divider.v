/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : clk_divider                        *
 * ------------------------------------------------ *
 * File        : clk_divider.v                      *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : A clock divider that generates a   *
		         clock of 0.5Hz frequency
 * ------------------------------------------------ */

 // included module : d_ff               (Creates a D-flip flop)
 // included module : mux2_1             (Creates a 2:1 MUX    )
 // included module : comparator_for_2s  (compares input with 99999999)

module clk_divider(input clk_in,
                   input reset,
                   output clk_out);

reg [0:26] temp = 0;
parameter P = 27'd99_999_999;  //10111110101111000010000000 in binary

wire d,
     q,
     qbar;
wire toggle;

comparator_for_2s COMP (temp, toggle); // toggle changes to 1 when temp = P

always @(posedge clk_in)           // A 27 bit counter to increment temp
if (reset || toggle) temp <=0;
else temp <= temp+1;


// Now we will be connecting a D-flipflop whose input will be coming from a 2:1 mux
// The I0 input of mux is nothing but the output of D-ff (clk_out) and the I1 input is ~clk_out (q_bar)
// The select line of the mux is the 'toggle' generated in comparator_for_1hz.

d_ff Dff (clk_in,reset,d,clk_out,qbar);
mux2_1 M (.I0(clk_out), .I1(qbar), .S(toggle), .O(d));

endmodule
