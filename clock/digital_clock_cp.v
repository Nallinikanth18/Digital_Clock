/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : digital_clock_cp                   *
 * ------------------------------------------------ *
 * File        : digital_clock_cp.v                 *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : An FSM made to load data using a   *
		 single bus                         
 * ------------------------------------------------ */


// NOTE that this module is only used to load information and start clock thats it.

module digital_clock_cp       (input clk,
                              input on_alarm,
                              input start,
                              input reset,

                              output reg ld_hr,
                              output reg ld_min,
                              output reg ld_sec,

                              output reg ld_alarm_sec,
                              output reg ld_alarm_min,
                              output reg ld_alarm_hr,

                              output reg on);


parameter s0=4'b0000,
          s1=4'b0001,
          s2=4'b0010,
          s3=4'b0011,
          s4=4'b0100,
          s5=4'b0101,
          s6=4'b0110,
          s7=4'b0111,
          s8=4'b1000;

reg [0:3]state = 0;

always @ (posedge clk)
begin
    case (state)
    s0 : if(start) state <= s1;  // In this stage(S0) on and all load operations are zero in this stage and it goes to next stage(S1) only when start=1.
    s1 : state <= s2;      // In this stage(S1) on=0, input data is loaded into hr and then it goes to next stage(S2).
    s2 : state <= s3;      // In this stage(S2) on=0, input data is loaded into min and then it goes to next stage(S3).
    s3 : state <= s4;      // In this stage(S3) on=0, input data is loaded into sec and then it goes to next stage(S4).
    s4 : if (on_alarm) state <= s5; // In this stage(S4) on=1and all load operations are zero , this is also the final stage.
         else state <= s4;
    s5 : state <= s6;
    s6 : state <= s7;
    s7 : #2 state <= s8;
    s8 : state <= s8;
    default : state <= s0;
    endcase
end

// variable on is used to start the clock ticking, on is high only after all sec,hr,min are loaded.

always @ (state)
begin
    case (state)
    s0 : begin on=0; ld_hr=0; ld_min=0; ld_sec=0; ld_alarm_sec=0; ld_alarm_min=0; ld_alarm_hr=0;;end
    s1 : begin ld_hr=1; ld_min=0; ld_sec=0;end
    s2 : begin ld_hr=0; ld_min=1; ld_sec=0;end
    s3 : begin ld_hr=0; ld_min=0; ld_sec=1;end
    s4 : begin on=1; ld_hr=0; ld_min=0; ld_sec=0;end
    s5 : begin ld_alarm_sec=0; ld_alarm_min=0; ld_alarm_hr=1;end
    s6 : begin ld_alarm_sec=0; ld_alarm_min=1; ld_alarm_hr=0;end
    s7 : begin ld_alarm_sec=1; ld_alarm_min=0; ld_alarm_hr=0;end
    s8 : begin ld_alarm_sec=0; ld_alarm_min=0; ld_alarm_hr=0;end
    default : begin on=0; ld_hr=0; ld_min=0; ld_sec=0; ld_alarm_sec=0; ld_alarm_min=0; ld_alarm_hr=0;end
endcase
end

endmodule
