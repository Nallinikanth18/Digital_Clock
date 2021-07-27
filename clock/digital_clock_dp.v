/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : digital_clock_dp                   *
 * ------------------------------------------------ *
 * File        : digital_clock_dp.v                 *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : A clock 			                *
 * ------------------------------------------------ */

 // included module : counter_24bits      (Creates a 24-bit counter)
 // included module : counter_6bits       (Creates a 6-bit counter)
 // included module : comparator_for_temp (Compares the input with 999999)
 // included module : comparator_sec_min  (Compares the input with 59)
 // included module : comparator_hr	      (Compares the input with 23)
 // included module : seven_seg_control	  (Used for seven segment display)
 // included module : ALARM	              (Creates an alarm)


module digital_clock_dp (input clk,
                         input reset,
                         input [0:5]input_data,
                         input ld_hr,
                         input ld_min,
                         input ld_sec,
                         input on,

                         input ld_alarm_sec,
                         input ld_alarm_min,
                         input ld_alarm_hr,
                         input on_alarm,
                         input alarm_reset,
                         input stop_alarm,

                         output [0:5]sec,
                         output [0:5]min,
                         output [0:5]hr,
                         output [0:6]segment,
                         output [0:3]anode,

                         output alarm_light,
                         output alarm_detector);


wire comp_sec,    //for comparing hr,sec,min with their max values
     comp_hr,
     comp_min;

wire clr_sec,     //for clearing sec,min,hr,temp
     clr_min,
     clr_hr,
     clr_temp;

wire en_min,      //for enabling sec,min,hr,temp
     en_hr,
     en_sec,
     en_temp,


wire [0:23]temp;  // used to count seconds

assign en_temp = on;

and (en_sec,  clr_temp, on) ;        // for seconds, seconds should run throughout the process
and (clr_sec, comp_sec, clr_temp);   // sec should clear after sec=59.

and (en_min,  clr_sec,  on);         // for minutes, it should increase only when the seconds=59.
and (clr_min, en_min,   comp_min);   // min should clear when min=sec=59.

and (en_hr,   clr_min,  on);         // for hours, it should increase only when the min=sec=59.
and (clr_hr,  en_hr,    comp_hr);    // hr should clear when hr=min=sec=59.


counter_24bits TEMP    (reset,temp,clr_temp,clk,en_temp);                //24 bit counter for temp
counter_6bits  SECONDS (ld_sec,reset,sec,clr_sec,input_data,clk,en_sec); //6 bit counter for seconds
counter_6bits  MINUTES (ld_min,reset,min,clr_min,input_data,clk,en_min); //6 bit counter for minutes
counter_6bits  HOURS   (ld_hr ,reset,hr ,clr_hr ,input_data,clk,en_hr ); //6 bit counter for hours

comparator_for_temp COMP_TEMP (temp, clr_temp);   //Comparator that gives clr_temp=1 when temp = 99999
comparator_sec_min  COMP_SEC  (sec,comp_sec);     //Comparator that gives comp_sec=1 when sec = 59
comparator_sec_min  COMP_MIN  (min,comp_min);     //Comparator that gives comp_min=1 when min = 59
comparator_hr       COMP_HR   (hr,comp_hr);       //Comparator that gives comp_hr=1 when hr = 23

seven_seg_control SEVEN_SEG (min,hr,clk,reset,anode,segment);  // seven segments used to display time

ALARM alrm (clk,alarm_reset,ld_alarm_sec,ld_alarm_min,ld_alarm_hr,on_alarm,stop_alarm,input_data,sec,min,hr,alarm_light,alarm_detector);
//An alarm module


endmodule
