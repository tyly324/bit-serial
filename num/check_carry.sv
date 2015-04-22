module check_carry(
	input logic i_clk,
	input logic i_data_gpr, 
	input logic i_data_acc,
	input logic i_con_check,
	output logic o_con_carry
	);

logic g, a;

assign o_con_carry = g & a & i_con_check;

always_ff @(posedge i_clk)
begin 
	g <= i_data_gpr;
	a <= i_data_acc;
end 

endmodule