/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : comparator_sec_min                 *
 * ------------------------------------------------ *
 * File        : comparator_sec_min.v               *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : A comparator that compares input   *
		         with 59
 * ------------------------------------------------ */

module comparator_sec_min(input [0:5]x,
                          output eq);
wire t3;

not g1 (t3,x[3]);
and g3 (eq,x[0],x[1],x[2],t3,x[4],x[5]);

endmodule
