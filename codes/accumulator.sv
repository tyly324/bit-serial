module accumulator(
	input logic i_clk,
	input logic i_rst,
	input logic i_con_shift,
	input logic i_con_write,
	input logic i_data_in,
	output logic o_data_out
	);

logic [7:0] register;
assign o_data_out = register[0];

always_ff @(posedge i_clk, posedge i_rst)
begin
	if(i_rst)
		register <= 0;
	else if(i_con_shift)
	begin
		register[6:0] <= register[7:1];
		if(i_con_write)
			register[7] <= i_data_in;
		else
			register[7] <= 0;
	end 
end

endmodule