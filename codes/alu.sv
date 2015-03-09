module alu #(length = 8)(
	input [length-1:0] i_data_a,
	input [length-1:0] i_data_b,
	input [1:0] i_con_alufun,
	output [length-1:0] o_data_result,
	output o_flag	//o-Add / 1-Mult
);

