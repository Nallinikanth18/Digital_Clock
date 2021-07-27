/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : alarm_light_detector               *
 * ------------------------------------------------ *
 * File        : ALARM_LIGHT_MODULE.v               *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : Controls the alarm light and	    *
                 alarm detector
 * ------------------------------------------------ */

 // included module : d_ff   (Creates a D-flip flop)
 // included module : mux2_1 (Creates a 2:1 MUX    )

module alarm_light_detector (output alarm_light,

                             input stop_alarm,
                             input eq,
                             input alarm_reset,
                             input clk);

wire reset;
wire alarm_light_bar;
wire d;

or (reset, alarm_reset, stop_alarm);

d_ff DFF (.clk(clk), .reset(reset), .d(d), .q(alarm_light), .qbar(alarm_light_bar));
mux2_1 M (.I0(alarm_light), .I1(eq), .S(eq), .O(d));

endmodule
