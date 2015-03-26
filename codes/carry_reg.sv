module carry_reg(
	input logic i_clk,
	input logic i_data_in,
	output logic o_data_out
	);

always_ff @(posedge i_clk) 
begin
		o_data_out <= i_data_in;
end

endmodule