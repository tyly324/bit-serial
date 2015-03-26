module mux(
	input logic i_data_alusum,
	input logic i_data_switch,
	input logic i_con_switch,
	output logic o_data_res
	);

assign o_data_res = i_con_switch ? i_data_switch : i_data_alusum;

endmodule