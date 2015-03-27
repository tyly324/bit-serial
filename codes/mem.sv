module mem(
	input logic i_clk,
	input logic i_rst,
	input logic [2:0] i_pc,
	output logic [2:0] o_instr
	);

logic [2:0] mem [0:7];
assign o_instr = mem[i_pc];

always_ff @(posedge i_clk)
if(i_rst)
begin
	mem[0] = 3'b000;
	mem[1] = 3'b111;
	mem[2] = 3'b001; 	//stall
	mem[3] = 3'b010; 	//mult y, d
	mem[4] = 3'b001; 	//stall
	mem[5] = 3'b011; 	//mult x, 1-d
	mem[6] = 3'b100; 	//add y,x
	mem[7] = 3'b110; 	//wait switch off
end 

endmodule