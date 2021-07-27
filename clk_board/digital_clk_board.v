/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : board                              *
 * ------------------------------------------------ *
 * File        : digital_clk_board.v                *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description :                                    *
 * ------------------------------------------------ */

 // included module : digital_clock_cp
 // included module : digital_clock_dp
 // included module : clk_divider
 // included module : clk_divider_cp
 // included module : debouncer

module digital_clk_board (input clk,
                          input btn0,
                          input btn1,
                          input [0:5] sw,

                          output [0:6] segment,
                          output [0:3] anode

                          input btn2,
                          input btn3,
                          input btn4,
                          output [0:15] led);


//start will be connected to btn0
//reset will be connected to btn1
//alarm_on will be connected to btn2
//alarm_reset will be connected to btn3
//stop_alarm will be connected to btn4
//input_data will be connected to sw[0:5]
//
//when digital clock starts led[0] will be on
//when ld_hr is on led[1] will be on so that user can enter hours
//when ld_min is on led[2] will be on so that user can enter minutes
//when ld_sec is on led[3] will be on so that user can enter seconds
//
//alarm_detector will be connected to led[4]
//when ld_alarm_hr is on led[5] will be on so that user can enter hours
//when ld_alarm_min is on led[6] will be on so that user can enter minutes
//when ld_alarm_sec is on led[7] will be on so that user can enter seconds
//alarm_light is connected to led[8:15]


wire [0:5] input_data;

wire ld_hr,  //used to load seconds,minutes and hours
     ld_min,
     ld_sec;

wire on; //the clock starts working only when on=1

wire ld_alarm_sec,  //used to load seconds,minutes and hours for alarm
     ld_alarm_min,
     ld_alarm_hr;

wire [0:5] sec,
     [0:5] min,
     [0:5] hr;

wire start,      //connected to btn0
     reset,      //connected to btn1
     alarm_reset,//connected to btn3
     on_alarm,   //connected to btn2
     stop_alarm; //connected to btn4

wire clk_out2s,
     clk_out8s;

assign input_data = sw[0:5];

assign led[0] = on;
assign led[1] =ld_hr;
assign led[2] =ld_min;
assign led[3] =ld_sec;

assign led[4] =alarm_detector;
assign led[5] =ld_alarm_hr;
assign led[6] =ld_alarm_min;
assign led[7] =ld_alarm_sec;

assign led[8]  =alarm_light;
assign led[9]  =alarm_light;
assign led[10] =alarm_light;
assign led[11] =alarm_light;
assign led[12] =alarm_light;
assign led[13] =alarm_light;
assign led[14] =alarm_light;
assign led[15] =alarm_light;

digital_clock_cp CP (.clk(clk_out8s),
                     .on_alarm(on_alarm),
                     .start(start),
                     .reset(reset),

                     .ld_hr(ld_hr),
                     .ld_min(ld_min),
                     .ld_sec(ld_sec),
                     .ld_alarm_sec(ld_alarm_sec),
                     .ld_alarm_min(ld_alarm_min),
                     .ld_alarm_hr(ld_alarm_hr),

                     .on(on));

digital_clock_dp DP (.clk(clk),
                     .reset(reset),
                     .input_data(input_data),
                     .ld_hr(ld_hr),
                     .ld_min(ld_min),
                     .ld_sec(ld_sec),
                     .on(on),

                     .ld_alarm_sec(ld_alarm_sec),
                     .ld_alarm_min(ld_alarm_min),
                     .ld_alarm_hr(ld_alarm_hr),
                     .on_alarm(on_alarm),
                     .alarm_reset(alarm_reset),
                     .stop_alarm(stop_alarm),

                     .sec(sec),
                     .min(min),
                     .hr(hr),
                     .segment(segment),
                     .anode(anode),
                     .alarm_light(alarm_light),
                     .alarm_detector(alarm_detector));

clk_divider_cp(.clk_in(clk),
               .reset(reset),
               .clk_out(clk_out8s)); //clk_out8s has time period of 8 seconds so that user can enter the data

clk_divider(.clk_in(clk),
            .reset(reset),
            .clk_out(clk_out2s));    //clk_out2s has time period of 2 seconds


//for reset button (btn1)
debouncer DB1(.clk(clk_out2s),
              .in(btn1),         // port from the push button
              .out(reset),       // port into the circuit
              );

//for alarm_reset button (btn3)
debouncer DB2(.clk(clk_out2s),
              .in(btn3),         // port from the push button
              .out(alarm_reset), // port into the circuit
              );

//for stop_alarm button (btn4)
debouncer DB3(.clk(clk_out2s),
              .in(btn4),         // port from the push button
              .out(stop_alarm),  // port into the circuit
              );

//for start button (btn0)
debouncer DB4(.clk(clk_out8s),
              .in(btn1),         // port from the push button
              .out(start),       // port into the circuit
              );

//for alarm_on button (btn2)
debouncer DB5(.clk(clk_out8s),
              .in(btn2),         // port from the push button
              .out(alarm_on),    // port into the circuit
              );

endmodule
