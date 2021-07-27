/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : comparator_for_2s                  *
 * ------------------------------------------------ *
 * File        : comparator_for_2s.v                *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : A comparator that compares input   *
		         with 99999999
 * ------------------------------------------------ */

module comparator_for_2s  (input [0:26]x,
                           output eq);

wire t1,   //x = 999_999_99 =101_111_101_011_110_000_011_111_111
     t7,
     t9,
     t14,
     t15,
     t16,
     t17,
     t18;

wire eq1,
     eq2,
     eq3,
     eq4,
     eq5;

not g1 (t3 ,x[3]),
    g2 (t7 ,x[7]),
    g3 (t9 ,x[9]),
    g4 (t14,x[14]),
    g5 (t15,x[15]),
    g6 (t16,x[16]),
    g7 (t17,x[17]),
    g8 (t18,x[18]);

and g9 (eq1,  x[0], x[1],   x[2],   t3,   x[4],  x[5]),
    g10(eq2,  x[6],   t7,   x[8],   t9,  x[10], x[11]),
    g11(eq3, x[12], x[13],   t14,  t15,  t16,     t17),
    g12(eq4,   t18, x[19], x[20], x[21], x[22], x[23]),
    g13(eq5, x[24], x[25], x[26]);

and g14(eq, eq1, eq2, eq3, eq4, eq5);

endmodule
