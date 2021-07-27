/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : seven_seg_control                  *
 * ------------------------------------------------ *
 * File        : seven_seg_control.v                *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : Controls the seven segments data   *
  		         of hours and minutes
 * ------------------------------------------------ */

 // included module : seven_segment_display  (Creates inputs for seven_seg_control)
 // included module : mux_4_to_1_7bit        (Creates a 7-bit input and output 4:1 MUX)
 // included module : demux_1_to_4           (Creates a 1:4 DEMUX)


module seven_seg_control (input [0:5]min,
                          input [0:5]hr,
                          input clk,
                          input reset,
                          output [0:3]anode,
                          output [0:6]segment);

reg [0:16]anode_selector;

wire [0:6] segment_min_msb;
wire [0:6] segment_min_lsb;
wire [0:6] segment_hr_msb;
wire [0:6] segment_hr_lsb;

seven_segment_display MIN_SEG (min,{segment_min_msb,segment_min_lsb});
seven_segment_display HR_SEG  (hr,{segment_hr_msb,segment_hr_lsb});

always @ (posedge clk)         // The select line for MULTIPLEXER and DEMULTIPLER
if (reset) anode_selector<= 0;
else anode_selector <= anode_selector +1;

mux_4_to_1_7bit MUX (anode_selector[0:1], segment_min_lsb, segment_min_msb, segment_hr_lsb, segment_hr_msb, segment); //2:4 multiplexer

demux_1_to_4    DEMUX (.out_00(anode[0]), .out_01(anode[1]), .out_10(anode[2]), .out_11(anode[3]), .s(anode_selector[0:1])); //1:4 demux

endmodule
