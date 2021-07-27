module digital_clock_cp_dp_tb;

reg [0:5] input_data;

reg clk,
    start,
    reset,
    on_alarm,
    alarm_reset,
    stop_alarm;

wire [0:6] segment;

wire [0:3] anode;

wire alarm_light,
     alarm_detector;

wire [0:5] sec;
wire [0:5] hr;
wire [0:5] min;

digital_clock_cp CP (.clk(clk),
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

initial
begin
    clk=1'b0;
    start=1'b0;
    reset =1'b1;
    stop_alarm = 1'b0;
end

initial forever #5 clk=~clk;

initial
begin
    #10 reset =1'b0;
    #10 start=1;
    #10 input_data = 23;
    #10 input_data = 58;
    #10 input_data = 58;
    #10 alarm_reset=1'b1;
    #10 alarm_reset=1'b0;
    #10 on_alarm=1;
    #10 input_data = 0;
    #10 input_data = 0;
    #10 input_data = 1;
end

initial
begin
    $monitor ($time ,"  TIME = %d : %d : %d ; ALARM SOUND = %b ; ALARM DETECTOR =  %b   ANODE = %b  SEGMENT = %b",hr,min,sec,alarm_light,alarm_detector,DP.anode,segment);
    $dumpfile("digital_clock_cp_dp.vcd");
    $dumpvars(0,digital_clock_cp_dp_tb);
    #25000000 stop_alarm=1'b1;
    #1002000 $finish;
end


endmodule

