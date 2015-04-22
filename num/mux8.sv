module mux8(
	input logic [2:0] i_con_choice,
	input logic [7:0] i_data_switch,
	output logic o_data_swbit
	);

//assign o_data_sebit = i_data_switch[i_con_choice];

always_comb
case (i_con_choice)
	0 : o_data_swbit = i_data_switch[0];
	1 : o_data_swbit = i_data_switch[1];
	2 : o_data_swbit = i_data_switch[2];
	3 : o_data_swbit = i_data_switch[3];
	4 : o_data_swbit = i_data_switch[4];
	5 : o_data_swbit = i_data_switch[5];
	6 : o_data_swbit = i_data_switch[6];
	7 : o_data_swbit = i_data_switch[7];

	default : o_data_swbit = 0;
endcase

endmodule

