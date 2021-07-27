/* ------------------------------------------------ *
 * Project     : Digital Clock                      *
 * Module      : comparator_for_8s                  *
 * ------------------------------------------------ *
 * File        : comparator_for_8s.v                *
 * Author      : Nallinikanth                       *
 * Last Edit   : 25/05/2021                         *
 * ------------------------------------------------ *
 * Description : A comparator that compares input   *
		         with 399999999
 * ------------------------------------------------ */

//-----------Comparator_for_8_s-------------------//
module comparator_for_8s  (input [0:28]x,
                           output eq);

wire t1,   //x = 3_999_999_99 = 101_111_101_011_110_000_011_111_111_11 in binary
     t7,
     t9,
     t11,
     t14,
     t15,
     t16,
     t17,
     t18,

wire eq1,
     eq2,
     eq3,
     eq4,
     eq5;

not g1 (t1 ,x[1]),
    g2 (t7 ,x[7]),
    g3 (t9 ,x[9]),
    g4 (t11,x[11]),
    g5 (t14,x[14]),
    g6 (t15,x[15]),
    g7 (t16,x[16]),
    g8 (t17,x[17]),
    g9 (t18,x[18]),

and g10 (eq1,    t1, x[1],   x[2],  x[3],   x[4],  x[5]),
    g11 (eq2,  x[6],   t7,   x[8],    t9,  x[10],  t11),
    g12 (eq3, x[12], x[13],   t14,   t15,  t16,     t17),
    g13 (eq4,   t18, x[19],  x[20], x[21], x[22], x[23]),
    g14 (eq5, x[24], x[25],  x[26], x[27], x[28]);

and g15(eq, eq1, eq2, eq3, eq4, eq5);

endmodule
