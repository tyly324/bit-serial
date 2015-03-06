module adder(
	input i_bit_a,
	input i_bit_b,
	input i_bit_cin,
	output o_bit_sum,
	output o_bit_cout);

wire and_ab, and_ac, and_bc;
assign o_bit_sum = i_bit_a ^ i_bit_b ^ i_bit_cin;
assign and_ab = i_bit_a & i_bit_b;
assign and_ac = i_bit_a & i_bit_cin;
assign and_bc = i_bit_b & i_bit_cin;
assign o_bit_cout = and_ab | and_ac | and_bc;

endmodule