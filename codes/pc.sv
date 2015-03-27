module pc(
	input logic i_clk,
	input logic i_rst,
	input logic i_con_incr,
	output logic [2:0] o_addr_pc
	);

wire [2:0] pc_incr;

logic [2:0] pc;
assign o_addr_pc = pc;

always_ff @(posedge i_clk)
begin
	if(i_rst)
		pc <= 3'b0;
	else if(i_con_incr)
		pc <= pc_incr;
end

increase u_incr(
	.in(pc),
	.out(pc_incr)
	);

endmodule