module gpr8(
	input logic clk, write, rd_in, shift,
	input logic [2:0] rd_addr,
	output logic rdata);

logic [7:0] sr [2:0];

//temp
logic [7:0] rd_sel;
assign rd_sel = sr[rd_addr];

always_ff @(posedge clk) 
begin
	if (shift)
	begin
		sr[rd_addr][6:0] <= sr[rd_addr][7:1]
		if (write)
			sr[rd_addr][7] <= rd_in;
		else
			sr[rd_addr][7] <= sr[rd_addr][0];
	end

end