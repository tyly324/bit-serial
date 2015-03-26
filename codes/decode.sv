module decode(
	input logic i_clk,
	input logic [1:0] i_instr,
	input logic i_start,
	output logic [2:0] o_con_mux8,
	output logic o_con_mux,
	output logic o_con_muxalu,
	output logic o_con_gpr_region,
	output logic o_con_gpr_write,
	output logic o_con_gpr_shift,
	output logic o_con_pcincr
	);

logic [2:0] count;
assign o_con_mux8 = count;

logic count_rst; 

always_ff @ (posedge i_clk)
if (count_rst)
	count = 0;
else 
	count = count + 1;

always_comb 
begin
	o_con_mux = 0;
	o_con_muxalu = 0;
	o_con_gpr_region = 0;
	o_con_gpr_write = 0;
	o_con_gpr_shift = 0;
	o_con_pcincr = 0;
	count_rst = 0;

	case(i_instr)
		2'b00 : begin 	//NOP
			if (i_start)
			begin
				o_con_pcincr = 1;
				count_rst = 1;
			end
		end

		// 2'b10 : begin 	//Add
		// 	case(count)
		// 		7 : begin
		// 			o_con_mux = 0;
		// 			o_con_gpr_region = 0;
		// 			o_con_gpr_write = 0;
		// 			o_con_gpr_shift = 0;
		// 			o_con_pcincr = 1;
		// 			count_rst = 1;
		// 		end
			
		// 		default : begin
		// 			o_con_mux = 0;
		// 			o_con_gpr_region = 0;
		// 			o_con_gpr_write = 0;
		// 			o_con_gpr_shift = 0;
		// 		end
		// 	endcase
		// end

		2'b11 : begin 	//Load
			o_con_mux = 1;
			o_con_gpr_region = 0;
			o_con_gpr_write = 1;
			o_con_gpr_shift = 1;
			case(count)
				7 : begin
					o_con_pcincr = 1;
					count_rst = 1;
				end
			
				default : ;
			endcase
		end
	endcase
end

endmodule
