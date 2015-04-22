module alu(
	input logic i_data_a,
	input logic i_data_b,
	input logic i_data_c,
	output logic o_data_sum,
	output logic o_data_carry
	);

wire and_ab, and_ac, and_bc;
//sum = A xor B xor Cin
assign o_data_sum = i_data_a ^ i_data_b ^ i_data_c;

//carry = AB+ACin+BCin
assign and_ab = i_data_a & i_data_b;
assign and_ac = i_data_a & i_data_c;
assign and_bc = i_data_b & i_data_c;
assign o_data_carry = and_ab | and_ac | and_bc;

endmodule