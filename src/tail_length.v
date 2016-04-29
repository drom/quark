module tail_length (ir, len);

input [3:0] ir;
output [2:0] len;

reg [2:0] len;

/*
    ..00  ..01  ..10  ..11
00..  1     2     4     8
01..  1     ?     ?     0
10..  1     1     0     0
11..  1     1     0     0
*/

always @ (ir)
    casez (ir)
    4'b??00: len = 1;
    4'b1?0?: len = 1;
    4'b0001: len = 2;
    4'b0010: len = 3;
    4'b0011: len = 4;
    default  len = 0;
    endcase

endmodule
