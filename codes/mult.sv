module mult(
	input i_clk,
	input i_nrst,
	input i_q,
	input i_m,
	output [15:0] o_prd);

logic [15:0] o_prd;
logic carry;

wire in_a, in_b, out_sum, out_carry;

assign in_a = o_prd[0] & i_nrst;
assign in_b = i_q & i_m;

adder U_adder(
	.i_bit_a(in_a),
	.i_bit_b(in_b),
	.i_bit_cin(carry),
	.o_bit_sum(out_sum),
	.o_bit_cout(out_carry)
);

always_ff @(posedge i_clk or negedge i_nrst)
begin
	if(~i_nrst)
		carry <= 0;
	else
		carry <= out_carry;
end

always_ff @(posedge i_clk or negedge i_nrst) 
begin
	if(~i_nrst)
		o_prd <= 0;
	else
		o_prd <= {out_sum, o_prd[15:1]};
end

endmodule

