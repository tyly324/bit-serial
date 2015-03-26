module accumulator(
	input logic i_clk,
	input logic i_rst,
	input logic i_data_in,
	output logic o_data_out
	);

logic [7:0] register;
assign o_data_out = register[0];

always_ff @(posedge i_clk)
begin
	if(i_rst)
		register <= 0;
	else
		register <= {i_data_in, register[7:1]};
end

endmodule