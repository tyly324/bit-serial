module mult(
	input i_clk,
	input i_nrst,
	input i_q,
	input i_m,
	input i_shift_reg,
	output o_product);

logic carry;

wire in_a, in_b, out_sum, out_carry;

assign o_product = out_sum;
assign in_a = i_shift_reg & i_nrst;
assign in_b = i_q & i_m; 



endmodule

