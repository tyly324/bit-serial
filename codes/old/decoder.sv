module decoder(
	input clk, 
	input logic [2:0] opcode,
	output logic write, shift, pc_incr,
	output logic [2:0] alu_func
	);

logic [2:0] bit_count;
logic bit_count_rst;

always_ff @(posedge clk)
begin
	if (bit_count_rst)
		bit_count = 0;
	else 
		bit_count = bit_count + 1;
end

always_comb
begin
	bit_count_rst = 0;
	write = 0;
	shift = 0;
	pc_incr = 0;
	alu_func = 0;

	case (opcode)
		'NOP :	begin
			bit_count_rst = 1;
			pc_incr = 1;
		end

		'ADD :	begin
			case (bit_count)
				7 : begin
					alu_func = 'RADD;
					shift = 1;
				end

				default : begin
					alu_func = 'RADD;
					shift = 1;
					pc_incr = 1;
				end
			end
		end
	endmodule