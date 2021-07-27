/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : general_comparator                 *
 * ------------------------------------------------ *
 * File        : general_comparator.v               *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : Compares whether the given two     *
	    	     are equal or not
 * ------------------------------------------------ */


module general_comparator (input [0:5]in1,
                           input [0:5]in2,

                           output eq);

wire t0,
     t1,
     t2,
     t3,
     t4,
     t5;

xnor G0 (t0,in1[0],in2[0]),  // for q'
     G1 (t1,in1[1],in2[1]),
     G2 (t2,in1[2],in2[2]),
     G3 (t3,in1[3],in2[3]),
     G4 (t4,in1[4],in2[4]),
     G5 (t5,in1[5],in2[5]);
and (eq,t0,t1,t2,t3,t4,t5);

endmodule
