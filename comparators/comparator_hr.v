/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : comparator_hr	                    *
 * ------------------------------------------------ *
 * File        : comparator_hr.v                    *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : A comparator that compares input   *
		         with 23
 * ------------------------------------------------ */

module comparator_hr(input [0:5]x,
                     output eq);

wire t0;
wire t2;

not g0 (t0,x[0]),
    g2 (t2,x[2]);

and g3 (eq,t0,x[1],t2,x[3],x[4],x[5]);

endmodule
