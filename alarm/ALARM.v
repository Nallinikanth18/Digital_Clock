/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : ALARM              		        *
 * ------------------------------------------------ *
 * File        : ALARM.v            		        *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : Creates an alarm		            *
 * ------------------------------------------------ */

 // included module : register_6bit       (Creates a 6 bit parallel load register)
 // included module : general_comparator  (Compares whether the entered two values are equal or not)
 // included module : alarm_light_detector (Contols the alarm lights and alarm detector)


module ALARM (input clk,
              input alarm_reset,
              input ld_alarm_sec,
              input ld_alarm_min,
              input ld_alarm_hr,
              input on_alarm,
              input stop_alarm,
              input [0:5]input_data,
              input [0:5]sec,
              input [0:5]min,
              input [0:5]hr,
              output alarm_light,
              output alarm_detector);


wire [0:5] alarm_sec;  // 3 three regesters to store the alarm time
wire [0:5] alarm_min;
wire [0:5] alarm_hr;

wire eq_sec; // Used in comparators gives 1 when alarm time equals current time else 0
wire eq_min;
wire eq_hr;
wire eq;

register_6bit ALARM_SEC_REG (alarm_sec, ld_alarm_sec, input_data, alarm_reset, clk); // 3 registers to store alarm time
register_6bit ALARM_MIN_REG (alarm_min, ld_alarm_min, input_data, alarm_reset, clk);
register_6bit ALARM_HR_REG  (alarm_hr,  ld_alarm_hr,  input_data, alarm_reset, clk);

general_comparator SECONDS (alarm_sec,sec,eq_sec);
general_comparator MINUTES (alarm_min,min,eq_min);
general_comparator HOURS   (alarm_hr,hr,eq_hr);

and (eq,eq_sec,eq_min,eq_hr,alarm_detector);  // eq is 1 when time equals to alarm time

alarm_light_detector light    (.alarm_light(alarm_light) ,   .stop_alarm(stop_alarm), .eq(eq),       .alarm_reset(alarm_reset), .clk(clk));
alarm_light_detector detector (.alarm_light(alarm_detector) ,.stop_alarm(stop_alarm), .eq(on_alarm), .alarm_reset(alarm_reset), .clk(clk));

endmodule
