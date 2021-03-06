module testbench;

logic i_clk;
logic i_rst;
logic [2:0] i_data_instruction;
logic [7:0] i_data_switch;
logic i_start;
logic o_con_pcincr;
logic [7:0] o_data_display;

bit_serial u_bs(.*);

logic [2:0] mem [0:3];
logic [1:0] pc;
assign i_data_instruction = mem[pc];

initial
begin
	mem[0] = 3'b000;
	mem[1] = 3'b110;
	mem[2] = 3'b100;
	mem[3] = 3'b000;
	pc = 0;
end

always_ff @ (posedge i_clk)
pc = pc + o_con_pcincr;

initial 
begin
	i_clk = 0;
	i_data_switch = 8'b11110000;
	i_start = 0;
	i_rst = 0;
	#10ns i_rst = 1;
	#20ns i_rst = 0;
	#20ns i_start = 1;
	#20ns i_start = 0;
	#500ns $stop;
end

always
#10ns i_clk = ~i_clk;

endmodule