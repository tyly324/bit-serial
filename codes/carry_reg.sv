module carry_reg(
	input logic i_clk,
	input logic i_rst,
	input logic i_data_in,
	output logic o_data_out
	);

always_ff @(posedge i_clk) 
begin
	if(i_rst)
		o_data_out <= 0;
	else
		o_data_out <= i_data_in;
end

endmodule