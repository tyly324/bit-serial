module signreg(
	input logic i_clk,
	input logic i_rst,
	input logic i_data_signbit,
	input logic i_con_store,
	output logic o_data_signbit
	);

logic msb;
assign o_data_signbit = msb;

always_ff @(posedge i_clk, posedge i_rst) 
begin
	if(i_rst) 
	begin
		msb <= 0;
	end 
	else if(i_con_store)
	begin
		msb <= i_data_signbit;
	end
end

endmodule