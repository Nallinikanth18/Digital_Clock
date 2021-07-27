module debouncer(input clk,
                 input in,  // port from the push button

                 output out // port into the circuit
                 );

wire q1,
     q1_bar,
     q2,
     q2_bar;

supply0 reset;

d_ff DFF1 (.clk(clk), .reset(reset), .d(in), .q(q1), .qbar(q1_bar));
d_ff DFF2 (.clk(clk), .reset(reset), .d(q1), .q(q2), .qbar(q2_bar));

and (out, q1, q2_bar);

endmodule

