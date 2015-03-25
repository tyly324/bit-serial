module alu #(length = 8)(
	input [length-1:0] i_data_a,
	input [length-1:0] i_data_b,
	input i_con_alufun,
	output [length-1:0] o_data_result,
	output o_flag	//o-Add / 1-Mult
);

wire adder_in_a, adder_in_b, adder_in_c, adder_out_sum, adder_out_c;
wire mult_in

assign adder_in_a


adder U_adder(
	.i_bit_a(adder_in_a),
	.i_bit_b(adder_in_b),
	.i_bit_cin(adder_in_c),
	.o_bit_sum(adder_out_sum),
	.o_bit_cout(adder_out_c)
);