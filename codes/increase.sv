module increase(
	input logic [2:0] in,
	output logic [2:0] out
	);

wire in_a, in_b, in_c;
wire out_a, out_b, out_c;
assign in_a = in[2];
assign in_b = in[1];
assign in_c = in[0];
assign out = {out_a, out_b, out_c};

assign out_a = (in_a^(in_b&in_c))|(in_a&(out_b));
assign out_b = in_b^in_c;
assign out_c = ~in_c;

endmodule