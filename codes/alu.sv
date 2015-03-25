module alu(
	input logic i_data_a,
	input logic i_data_b,
	input logic i_data_c,
	output logic o_data_sum,
	output logic o_data_carry
	);

wire [1:0] result;

assign o_data_sum = result[0];
assign o_data_carry = result[1];

always_comb 
begin 
	result = i_data_a + i_data_b + i_data_c;
end

endmodule