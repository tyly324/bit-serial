module gpr(
	input logic i_clk, 
	input logic i_con_write, 
	input logic i_con_shift, 
	input logic i_data_in, 
	input logic [1:0] rd_addr,
	output logic o_data_out,
	output logic [7:0] o_data_display
	);

logic [7:0] sr [0:3];
assign o_data_display = sr[0];
//temp
//logic [7:0] reg_sel;
//assign reg_sel = sr[rd_addr];
assign o_data_out = sr[rd_addr][0];

always_ff @(posedge i_clk) 
begin
	if (i_con_shift)
	begin
		sr[rd_addr][6:0] <= sr[rd_addr][7:1];
		if (i_con_write)
			sr[rd_addr][7] <= i_data_in;
		else
			sr[rd_addr][7] <= sr[rd_addr][0];
	end
end

endmodule