module bitSerialCPU(
	input logic clk,
	input logic [9:0] SW,
	output logic [7:0] LED
	);

wire [7:0] y;
assign LED = y;
wire [7:0] i_data_switch;
wire i_start;
wire i_rst;
assign i_data_switch = SW[9:2];
assign i_start = SW[1];
assign i_rst = ~SW[0];

wire [7:0] x;
wire [2:0] pc_out;
wire [2:0] mem_out;
wire [2:0] increase_out;
wire [2:0] decode_mux8;
wire mux8_swbit;
wire acc_out;
wire alu_sum, alu_carry;
wire gpr_out;
wire muxalu_out;
wire carry_out;
wire mux_out;
wire decode_acc_shift, decode_acc_write, decode_gpr_shift, decode_gpr_write, decode_mux, decode_muxalu, decode_pcincr;
wire [2:0] pcincr_out;

pc u_pc(
	.i_clk(clk),
	.i_rst(i_rst),
	.i_con_incr(decode_pcincr),
	.i_addr_pcin(pcincr_out),
	.o_addr_pc(pc_out)
	);

mem u_mem(
	.address(pc_out),
	.I(mem_out)
	);

increase u_increase(
	.in(decode_mux8),
	.out(increase_out)
	);

decode u_decode(
	.i_clk(clk),
	.i_instr(mem_out),
	.i_start(i_start),
	.i_data_count(increase_out),
	.o_con_mux8(decode_mux8),
	.o_con_mux(decode_mux),
	.o_con_muxalu(decode_muxalu),
	.o_con_gpr_shift(decode_gpr_shift),
	.o_con_gpr_sign(decode_gpr_sign),
	.o_con_acc_shift(decode_acc_shift),
	.o_con_acc_sign(decode_acc_sign),
	.o_con_sign_store(decode_sign_store),
	.o_con_blockcarry(decode_blockcarry),
	.o_con_pcincr(decode_pcincr),
	.o_con_check_carry(decode_check_carry)
	);

mux8 u_mux8(
	.i_con_choice(decode_mux8),
	.i_data_switch(i_data_switch),
	.o_data_swbit(mux8_swbit)
	);

muxgpr u_muxgpr(
	.i_data_alusum(alu_sum),
	.i_data_switch(mux8_swbit),
	.i_con_switch(decode_mux),
	.o_data_res(muxgpr_out)
	);

signreg u_signreg(
	.i_clk(clk),
	.i_rst(i_rst),
	.i_data_signbit(alu_sum),
	.i_con_store(decode_sign_store),
	.o_data_signbit(signreg_out)
	);

gpr u_gpr(
	.i_clk(clk),
	.i_rst(i_rst),
	.i_con_shift(decode_gpr_shift),
	.i_con_sign(decode_gpr_sign),
	.i_data_in(muxgpr_out),
	.i_data_sign(signreg_out),
	.rd_addr(mem_out[0]),
	.o_data_out(gpr_out),
	.ry(y),
	.rx(x)
	);

muxalu u_muxalu(
	.i_data_acc(acc_out),
	.i_con_0(decode_muxalu),
	.o_data_out(muxalu_out)
	);

alu u_alu(
	.i_data_a(gpr_out),
	.i_data_b(muxalu_out),
	.i_data_c(muxc_out),
	.o_data_sum(alu_sum),
	.o_data_carry(alu_carry)
	);

accumulator u_acc(
	.i_clk(clk),
	.i_rst(i_rst),
	.i_con_shift(decode_acc_shift),
	.i_con_sign(decode_acc_sign),
	.i_data_in(alu_sum),
	.i_data_sign(signreg_out),
	.o_data_out(acc_out)
	);

carry_reg u_carry(
	.i_clk(clk),
	.i_rst(i_rst),
	.i_data_in(alu_carry),
	.i_con_blockcarry(decode_blockcarry),
	.o_data_out(carry_out)
	);

muxcarry u_muxc(
	.i_data_carry(carry_out),
	.i_con_carry(checkc_out),
	.o_data_aluc(muxc_out)
	);

check_carry u_checkc(
	.i_clk(clk),
	.i_data_gpr(gpr_out),
	.i_data_acc(acc_out),
	.i_con_check(decode_check_carry),
	.o_con_carry(checkc_out)
	);

increase u_incr_pc(
	.in(pc_out),
	.out(pcincr_out)
	);
endmodule