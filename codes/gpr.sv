module gpr(
	input logic i_clk, 
	input logic i_rst,
	input logic i_con_write, 
	input logic i_con_shift, 
	input logic i_data_in, 
	input logic rd_addr,
	output logic o_data_out,
	output logic [7:0] ry,
	output logic [7:0] rx
	);

logic [7:0] sr [0:1];

assign ry = sr[0];
assign rx = sr[1];
assign o_data_out = sr[rd_addr][0];

always_ff @(posedge i_clk) 
begin
	if(i_rst)
	begin
		sr[0] <= 0;
		sr[1] <= 0;
	end
	else if(i_con_shift)
	begin
		sr[rd_addr][6:0] <= sr[rd_addr][7:1];
		if(i_con_write)
			sr[rd_addr][7] <= i_data_in;
		else
			sr[rd_addr][7] <= 0;
	end
end

endmodule