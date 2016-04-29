module tail_offset (ir, pc, offset, len);
input [63:0] ir;
input [3:0] pc;
output [3:0] offset;
output [2:0] len;

reg  [3:0]
    ir1111, ir1110, ir1101, ir1100, ir1011, ir1010, ir1001, ir1000,
    ir0111, ir0110, ir0101, ir0100, ir0011, ir0010, ir0001, ir0000;

reg  [3:0]
    of1111, of1110, of1101, of1100, of1011, of1010, of1001, of1000,
    of0111, of0110, of0101, of0100, of0011, of0010, of0001;
    //, of0000;

wire [2:0]
    // len1111,
    len1110, len1101, len1100, len1011, len1010, len1001, len1000,
    len0111, len0110, len0101, len0100, len0011, len0010, len0001;
    //, len0000;

wire [3:0] offset;
wire [2:0] len;

// tail_length u_len1111 (.ir(ir1111), .len(len1111));
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
// tail_length u_len0000 (.ir(ir0000), .len(len0000));

always @ (ir) begin
    {
        ir1111, ir1110, ir1101, ir1100, ir1011, ir1010, ir1001, ir1000,
        ir0111, ir0110, ir0101, ir0100, ir0011, ir0010, ir0001, ir0000
    } = ir;
end


always @ (
    // len1111,
    len1110, len1101, len1100, len1011, len1010, len1001, len1000,
    len0111, len0110, len0101, len0100, len0011, len0010, len0001
    //, len0000
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

mux16 #(.W(4)) u_offset_mux (
    .sel(pc),
    .i0000(of0001),
    .i0001(of0010),
    .i0010(of0011),
    .i0011(of0100),
    .i0100(of0101),
    .i0101(of0110),
    .i0110(of0111),
    .i0111(of1000),
    .i1000(of1001),
    .i1001(of1010),
    .i1010(of1011),
    .i1011(of1100),
    .i1100(of1101),
    .i1101(of1110),
    .i1110(of1111),
    .i1111(of1111),
    .o(offset)
);

mux16 #(.W(3)) u_len_mux (
    .sel(pc),
    .i0000(len0001),
    .i0001(len0010),
    .i0010(len0011),
    .i0011(len0100),
    .i0100(len0101),
    .i0101(len0110),
    .i0110(len0111),
    .i0111(len1000),
    .i1000(len1001),
    .i1001(len1010),
    .i1010(len1011),
    .i1011(len1100),
    .i1100(len1101),
    .i1101(len1110),
    .i1110(len1111),
    .i1111(len1111),
    .o(len)
);

endmodule
