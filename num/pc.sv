module pc(
	input logic i_clk,
	input logic i_rst,
	input logic i_con_incr,
	input logic [2:0] i_addr_pcin,///////
	output logic [2:0] o_addr_pc
	);

//wire [2:0] pc_incr;

logic [2:0] pc;
assign o_addr_pc = pc;

always_ff @(posedge i_clk, posedge i_rst)
begin
	if(i_rst) begin
		pc <= 0;
	end 
	else if(i_con_incr) begin
		pc <= i_addr_pcin;
	end 
end

// increase u_incr(
// 	.in(pc),
// 	.out(pc_incr)
// 	);

endmodule