module bit_serial(
	input logic i_clk,
	input logic i_rst,
	input logic [7:0] i_data_switch,
	input logic i_start,
//	output logic decode_pcincr,
	output logic [7:0] y,
//	output logic [7:0] x
	);

wire [7:0] x;
wire [2:0] pc_out;
wire [2:0] mem_out;
wire [2:0] increase_out;
wire [2:0] decode_mux8;
wire mux8_swbit;
wire acc_out;
wire alu_sum, alu_carry;
wire gpr_out;

pc u_pc(
	.i_clk(i_clk),
	.i_rst(i_rst),
	.i_con_incr(decode_pcincr),
	.o_addr_pc(pc_out)
	);

mem u_mem(
	.i_clk(i_clk),
	.i_rst(i_rst),
	.i_pc(pc_out),
	.o_instr(mem_out)
	);

increase u_increase(
	.in(decode_mux8),
	.out(increase_out)
	);

decode u_decode(
	.i_clk(i_clk),
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
	.o_con_pcincr(decode_pcincr)
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
	.i_clk(i_clk),
	.i_rst(i_rst),
	.i_data_signbit(alu_sum),
	.i_con_store(decode_sign_store),
	.o_data_signbit(signreg_out)
	);

gpr u_gpr(
	.i_clk(i_clk),
	.i_rst(i_rst),
	.i_con_shift(decode_gpr_shift),
	.i_con_sign(decode_gpr_sign),
	.i_data_in(muxsign_out),
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
	.i_data_c(carry_out),
	.o_data_sum(alu_sum),
	.o_data_carry(alu_carry)
	);

accumulator u_acc(
	.i_clk(i_clk),
	.i_rst(i_rst),
	.i_con_shift(decode_acc_shift),
	.i_con_sign(decode_acc_sign),
	.i_data_in(alu_sum),
	.i_data_sign(signreg_out),
	.o_data_out(acc_out)
	);

carry_reg u_carry(
	.i_clk(i_clk),
	.i_rst(i_rst),
	.i_data_in(alu_carry),
	.o_data_out(carry_out)
	);

endmodule