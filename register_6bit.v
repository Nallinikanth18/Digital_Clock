/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : register_6bit              	    *
 * ------------------------------------------------ *
 * File        : register_6bit.v            	    *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : Creates a 6 bit parallel load 	    *
                 register
 * ------------------------------------------------ */

 // included module : d_ff   (Creates a D-flip flop)
 // included module : mux2_1 (Creates a 2:1 MUX    )

module register_6bit (output[0:5]x,
                      input ld_x,
                      input [0:5]input_data,
                      input alarm_reset,
                      input clk);

wire [0:5]d;
wire [0:5]x_bar;

not x0 (x_bar[0],x[0]),  // for q'
    x1 (x_bar[1],x[1]),
    x2 (x_bar[2],x[2]),
    x3 (x_bar[3],x[3]),
    x4 (x_bar[4],x[4]),
    x5 (x_bar[5],x[5]);

d_ff DFF5 (clk,alarm_reset,d[5],x[5],x_bar[5]);
mux2_1 M5 (.I0(x[5]), .I1(input_data[5]), .S(ld_x), .O(d[5]));

d_ff DFF4 (clk,alarm_reset,d[4],x[4],x_bar[4]);
mux2_1 M4 (.I0(x[4]), .I1(input_data[4]), .S(ld_x), .O(d[4]));

d_ff DFF3 (clk,alarm_reset,d[3],x[3],x_bar[3]);
mux2_1 M3 (.I0(x[3]), .I1(input_data[3]), .S(ld_x), .O(d[3]));

d_ff DFF2 (clk,alarm_reset,d[2],x[2],x_bar[2]);
mux2_1 M2 (.I0(x[2]), .I1(input_data[2]), .S(ld_x), .O(d[2]));

d_ff DFF1 (clk,alarm_reset,d[1],x[1],x_bar[1]);
mux2_1 M1 (.I0(x[1]), .I1(input_data[1]), .S(ld_x), .O(d[1]));

d_ff DFF0 (clk,alarm_reset,d[0],x[0],x_bar[0]);
mux2_1 M0 (.I0(x[0]), .I1(input_data[0]), .S(ld_x), .O(d[0]));

endmodule
