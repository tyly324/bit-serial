module muxcarry(
	input logic i_data_carry, 
	input logic i_con_carry,
	output logic o_data_aluc
	);

assign o_data_aluc = i_con_carry ? 1'b1 : i_data_carry;

endmodule