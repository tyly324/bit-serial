module carry_reg(
	input logic i_clk,
	input logic i_rst,
	input logic i_data_in,
	input logic	i_con_blockcarry,
	output logic o_data_out
	);

logic carry;

always_ff @(posedge i_clk, posedge i_rst) 
begin
	if(i_rst)
		carry <= 0;
	else
		carry <= i_data_in;
end

always_comb 
if(i_con_blockcarry)
	o_data_out = 0;
else
	o_data_out = carry;

endmodule