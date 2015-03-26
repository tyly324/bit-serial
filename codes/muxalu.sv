module muxalu(
	input logic i_data_acc,
	input logic i_con_0,
	output logic o_data_out
	);

assign o_data_out = i_con_0 ? 0 : i_data_acc;

endmodule