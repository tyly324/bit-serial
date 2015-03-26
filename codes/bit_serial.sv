module bit_serial(
	input logic i_clk,
	input logic [2:0] i_data_instruction,
	input logic [7:0] i_data_switch,
	input logic i_start,
	output logic o_con_pcincr,
	output logic [7:0] o_data_display
	);

wire [2:0] decode_mux8;
wire decode_gpr_region;
wire mux8_swbit;
wire acc_out;
wire alu_sum, alu_carry;
wire gpr_out;
wire [1:0] gpr_addr;
assign gpr_addr = {decode_gpr_region, i_data_instruction[0]};



decode u_decode(
	.i_clk(i_clk),
	.i_instr(i_data_instruction[2:1]),
	.i_start(i_start),
	.o_con_mux8(decode_mux8),
	.o_con_mux(decode_mux),
	.o_con_muxalu(decode_muxalu),
	.o_con_gpr_region(decode_gpr_region),
	.o_con_gpr_write(decode_gpr_write),
	.o_con_gpr_shift(decode_gpr_shift),
	.o_con_pcincr(o_con_pcincr)
	);

mux8 u_mux8(
	.i_con_choice(decode_mux8),
	.i_data_switch(i_data_switch),
	.o_data_swbit(mux8_swbit)
	);

mux u_mux(
	.i_data_acc(acc_out),
	.i_data_switch(mux8_swbit),
	.i_con_switch(decode_mux),
	.o_data_res(mux_out)
	);

gpr u_gpr(
	.i_clk(i_clk),
	.i_con_write(decode_gpr_write),
	.i_con_shift(decode_gpr_shift),
	.i_data_in(mux_out),
	.rd_addr(gpr_addr),
	.o_data_out(gpr_out),
	.o_data_display(o_data_display)
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
	.i_data_in(alu_sum),
	.o_data_out(acc_out)
	);

carry_reg u_carry(
	.i_clk(i_clk),
	.i_data_in(alu_carry),
	.o_data_out(carry_out)
	);

endmodule