module core (
    clk, reset_n,
    ir_next,
    ir_be,
    ir0, ir1,
    ir11, ir10, ir01, ir00,
    ir111, ir110, ir101, ir100, ir011, ir010, ir001, ir000,
    ir1111, ir1110, ir1101, ir1100, ir1011, ir1010, ir1001, ir1000, ir0111, ir0110, ir0101, ir0100, ir0011, ir0010, ir0001, ir0000,
    offset,
    pc_next,
    pc_en,
    pc,
    len,
    imm,
    imm_en,
    cur_len
);

input clk, reset_n;
input [63:0] ir_next;
input [1:0] ir_be;
input [3:0] pc_next;
input pc_en;
input imm_en;

output [31:0] ir1, ir0;
output [15:0] ir11, ir10, ir01, ir00;
output  [7:0] ir111, ir110, ir101, ir100, ir011, ir010, ir001, ir000;
output  [3:0] ir1111, ir1110, ir1101, ir1100, ir1011, ir1010, ir1001, ir1000, ir0111, ir0110, ir0101, ir0100, ir0011, ir0010, ir0001, ir0000;
output  [3:0] offset;
output  [3:0] len;
output  [2:0] cur_len;
output  [3:0] pc;
output [31:0] imm;

reg [63:0] ir;
reg [31:0] ir0, ir1;
reg [15:0] ir11, ir10, ir01, ir00;
reg  [7:0] ir111, ir110, ir101, ir100, ir011, ir010, ir001, ir000;
reg  [3:0] ir1111, ir1110, ir1101, ir1100, ir1011, ir1010, ir1001, ir1000, ir0111, ir0110, ir0101, ir0100, ir0011, ir0010, ir0001, ir0000;
wire [3:0] offset;
wire [2:0] cur_len;
wire [31:0] imm_next;
reg [3:0] len;
reg [3:0] pc;
reg [31:0] imm;

always @(posedge clk or negedge reset_n) if (~reset_n) ir0 <= 32'b0; else if (ir_be[0]) ir0 <= ir_next[31:0];
always @(posedge clk or negedge reset_n) if (~reset_n) ir1 <= 32'b0; else if (ir_be[1]) ir1 <= ir_next[63:32];
always @(posedge clk or negedge reset_n) if (~reset_n) pc  <=  4'b0; else if (pc_en)  pc  <= pc_next;

always @ (ir0, ir1) begin
    {ir11, ir10} = ir1;
    {ir01, ir00} = ir0;

    {ir111, ir110, ir101, ir100} = ir1;
    {ir011, ir010, ir001, ir000} = ir0;

    {ir1111, ir1110, ir1101, ir1100, ir1011, ir1010, ir1001, ir1000} = ir1;
    {ir0111, ir0110, ir0101, ir0100, ir0011, ir0010, ir0001, ir0000} = ir0;

    len = ir0000;

    ir = {ir1, ir0};
end

tail_offset u_tail_offset (.ir(ir), .pc(pc), .offset(offset), .len(cur_len), .imm(imm_next));

always @(posedge clk) if (imm_en) imm <= imm_next;

endmodule
