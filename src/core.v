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


module core (
    clk, reset_n,
    ir0_next, ir1_next,
    ir0_en, ir1_en,
    ir0, ir1,
    ir11, ir10, ir01, ir00,
    ir111, ir110, ir101, ir100, ir011, ir010, ir001, ir000,
    ir1111, ir1110, ir1101, ir1100, ir1011, ir1010, ir1001, ir1000,
    ir0111, ir0110, ir0101, ir0100, ir0011, ir0010, ir0001, ir0000,
    len1111, len1110, len1101, len1100, len1011, len1010, len1001, len1000,
    len0111, len0110, len0101, len0100, len0011, len0010, len0001, len0000,
    of1111, of1110, of1101, of1100, of1011, of1010, of1001, of1000,
    of0111, of0110, of0101, of0100, of0011, of0010, of0001, of0000,
    offset,
    pc_next,
    pc_en,
    pc,
    len
);

input clk, reset_n;
input [31:0] ir0_next, ir1_next;
input ir0_en, ir1_en;
input [3:0] pc_next;
input pc_en;

output [31:0] ir1, ir0;
output [15:0] ir11, ir10, ir01, ir00;
output  [7:0] ir111, ir110, ir101, ir100, ir011, ir010, ir001, ir000;
output  [3:0]
    ir1111, ir1110, ir1101, ir1100, ir1011, ir1010, ir1001, ir1000,
    ir0111, ir0110, ir0101, ir0100, ir0011, ir0010, ir0001, ir0000;
output  [2:0]
    len1111, len1110, len1101, len1100, len1011, len1010, len1001, len1000,
    len0111, len0110, len0101, len0100, len0011, len0010, len0001, len0000;
output  [3:0]
    of1111, of1110, of1101, of1100, of1011, of1010, of1001, of1000,
    of0111, of0110, of0101, of0100, of0011, of0010, of0001, of0000,
    offset;
output  [3:0] len;
output  [3:0] pc;

reg [63:0] ir;
reg [31:0] ir0, ir1;
reg [15:0] ir11, ir10, ir01, ir00;
reg  [7:0] ir111, ir110, ir101, ir100, ir011, ir010, ir001, ir000;
reg  [3:0]
    ir1111, ir1110, ir1101, ir1100, ir1011, ir1010, ir1001, ir1000,
    ir0111, ir0110, ir0101, ir0100, ir0011, ir0010, ir0001, ir0000;
wire [2:0]
    len1111, len1110, len1101, len1100, len1011, len1010, len1001, len1000,
    len0111, len0110, len0101, len0100, len0011, len0010, len0001, len0000;
reg  [3:0]
    of1111, of1110, of1101, of1100, of1011, of1010, of1001, of1000,
    of0111, of0110, of0101, of0100, of0011, of0010, of0001, of0000,
    offset;
reg [3:0] len;
reg [3:0] pc;

always @(posedge clk or negedge reset_n) if (~reset_n) ir0 <= 32'b0; else if (ir0_en) ir0 <= ir0_next;
always @(posedge clk or negedge reset_n) if (~reset_n) ir1 <= 32'b0; else if (ir1_en) ir1 <= ir1_next;
always @(posedge clk or negedge reset_n) if (~reset_n) pc  <=  4'b0; else if (pc_en)  pc  <= pc_next;

always @ (ir0, ir1) begin
    ir = {ir1, ir0};
    {ir11, ir10} = ir1;
    {ir01, ir00} = ir0;
    {ir111, ir110, ir101, ir100} = ir1;
    {ir011, ir010, ir001, ir000} = ir0;
    {ir1111, ir1110, ir1101, ir1100, ir1011, ir1010, ir1001, ir1000} = ir1;
    {ir0111, ir0110, ir0101, ir0100, ir0011, ir0010, ir0001, ir0000} = ir0;
    len = ir0000;
end

tail_length u_len1111 (.ir(ir1111), .len(len1111));
tail_length u_len1110 (.ir(ir1110), .len(len1110));
tail_length u_len1101 (.ir(ir1101), .len(len1101));
tail_length u_len1100 (.ir(ir1100), .len(len1100));
tail_length u_len1011 (.ir(ir1011), .len(len1011));
tail_length u_len1010 (.ir(ir1010), .len(len1010));
tail_length u_len1001 (.ir(ir1001), .len(len1001));
tail_length u_len1000 (.ir(ir1000), .len(len1000));
tail_length u_len0111 (.ir(ir0111), .len(len0111));
tail_length u_len0110 (.ir(ir0110), .len(len0110));
tail_length u_len0101 (.ir(ir0101), .len(len0101));
tail_length u_len0100 (.ir(ir0100), .len(len0100));
tail_length u_len0011 (.ir(ir0011), .len(len0011));
tail_length u_len0010 (.ir(ir0010), .len(len0010));
tail_length u_len0001 (.ir(ir0001), .len(len0001));
tail_length u_len0000 (.ir(ir0000), .len(len0000));

always @ (
    len1111, len1110, len1101, len1100, len1011, len1010, len1001, len1000,
    len0111, len0110, len0101, len0100, len0011, len0010, len0001 // , len0000
) begin
    of0001 = 0;
    of0010 = of0001 + len0001;
    of0011 = of0010 + len0010;
    of0100 = of0011 + len0011;
    of0101 = of0100 + len0100;
    of0110 = of0101 + len0101;
    of0111 = of0110 + len0110;
    of1000 = of0111 + len0111;
    of1001 = of1000 + len1000;
    of1010 = of1001 + len1001;
    of1011 = of1010 + len1010;
    of1100 = of1011 + len1011;
    of1101 = of1100 + len1100;
    of1110 = of1101 + len1101;
    of1111 = of1110 + len1110;
end

always @ (
    pc,
    of1111, of1110, of1101, of1100, of1011, of1010, of1001, of1000,
    of0111, of0110, of0101, of0100, of0011, of0010, of0001 //, of0000;
) begin
    case (pc)
    0:  offset = of0001;
    1:  offset = of0010;
    2:  offset = of0011;
    3:  offset = of0100;
    4:  offset = of0101;
    5:  offset = of0110;
    6:  offset = of0111;
    7:  offset = of1000;
    8:  offset = of1001;
    9:  offset = of1010;
    10: offset = of1011;
    11: offset = of1100;
    12: offset = of1101;
    13: offset = of1110;
    14: offset = of1111;
    default offset = of1111;
    endcase
end

endmodule
