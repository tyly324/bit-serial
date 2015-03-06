module adder(
	input i_bit_a,
	input i_bit_b,
	input i_bit_cin,
	output o_bit_sum,
	output o_bit_cout);

assign o_bit_sum = i_bit_a ^ i_bit_b ^ i_bit_cin;
assign o_bit_cout = i_bit_a & i_bit_b + i_bit_a & i_bit_b + i_bit_b & i_bit_cin;

endmodule