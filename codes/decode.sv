module decode(
	input logic i_clk,
	input logic [2:0] i_instr,
	input logic i_start,
	input logic [2:0] i_data_count,
	output logic [2:0] o_con_mux8,
	output logic o_con_mux,
	output logic o_con_muxalu,
	output logic o_con_gpr_shift,
	output logic o_con_gpr_write,
	output logic o_con_acc_shift,
	output logic o_con_acc_write,
	output logic o_con_pcincr
	);

logic [1:0] state_mult; 	//enum {read, shift, mult} 

//bit counter
logic [2:0] count;
logic count_rst; 
assign o_con_mux8 = count;	//count input bit from switches


always_ff @ (posedge i_clk, posedge count_rst)
if (count_rst)
	count <= 0;
else 
	count <= i_data_count;

always_ff @(posedge i_clk)
begin 
	casez(i_instr)
		3'b000 :if (i_start)
		begin
			state_mult = 2'b00;
		end

		3'b001 : state_mult = 2'b00; 	//NOP without start

		3'b010 : begin 
			case(state_mult)
				2'b00 : if(count == 7)
							state_mult = 2'b01;

				2'b01 : if(count == 7)
							state_mult = 2'b11;

				2'b11 : if(count == 7)
							state_mult = 2'b00;
			endcase 
		end 

		3'b011 : begin 	//X*(1-d)
			case(state_mult)
				2'b00 : if(count == 7)
							state_mult = 2'b01;

				2'b01 : if(count == 7)
							state_mult = 2'b11;

				2'b11 : if(count == 7)
							state_mult = 2'b00; 
			endcase 
		end


		3'b10? : begin 	//Add
			if(count == 7)
					state_mult = 2'b00;
		end

		3'b110 : begin
			if(~i_start)
				state_mult = 2'b00;
		end 


		3'b111 : begin 	//Load X
			if(count == 7)
				state_mult = 2'b00;
		end
	endcase
end 


always_comb 
begin
	o_con_mux = 0;
	o_con_muxalu = 0;
	o_con_gpr_shift = 0;
	o_con_gpr_write = 0;
	o_con_acc_shift = 0;
	o_con_acc_write = 0;
	o_con_pcincr = 0;
	count_rst = 0;

	casez(i_instr)
		3'b000 : begin 	//NOP
			if (i_start)
			begin
				o_con_pcincr = 1;
				count_rst = 1;
			end
		end

		3'b001 : begin 	//stall
			o_con_pcincr = 1;
			count_rst = 1;
		end

		3'b010 : begin 	//Y*d
			case(state_mult)
				2'b00 : begin
					o_con_muxalu = 1;
					o_con_gpr_shift = 1;
					o_con_acc_shift = 1;
					o_con_gpr_write = 1;
					o_con_acc_write = 1;
					
				end 

				2'b01 : begin
					case(count)
						0 : begin
							o_con_gpr_shift = 1;
							o_con_acc_shift = 1;
						end

						1 : begin 	//begin to read value into gpr
							o_con_gpr_shift = 1;
							o_con_acc_shift = 1;
						end

						2 : begin
							o_con_gpr_shift = 0;
							o_con_acc_shift = 1;
						end

						default : begin 	//begin to read value into acc
							o_con_gpr_shift = 0;
							o_con_acc_shift = 0;
						end
					endcase
				end 

				2'b11 : begin
					o_con_muxalu = 0;
					o_con_gpr_shift = 1;
					o_con_gpr_write = 1;
					o_con_acc_shift = 1;
					case(count)
						7 : begin 
							o_con_pcincr = 1;
						end

						default : ;
					endcase 
				end 
			endcase 
		end 

		3'b011 : begin 	//X*(1-d)
			case(state_mult)
				2'b00 : begin
					o_con_muxalu = 1;
					o_con_gpr_shift = 1;
					o_con_acc_shift = 1;
					o_con_gpr_write = 1;
					o_con_acc_write = 1;
				end 

				2'b01 : begin
					case(count)
						0 : begin
							o_con_gpr_shift = 1;
							o_con_acc_shift = 1;
						end

						1 : begin 	//begin to read value into gpr
							o_con_gpr_shift = 0;
							o_con_acc_shift = 1;
						end

						2 : begin
							o_con_gpr_shift = 0;
							o_con_acc_shift = 1;
						end

						default : begin 	//begin to read value into acc
							o_con_gpr_shift = 0;
							o_con_acc_shift = 0;
						end
					endcase
				end 

				2'b11 : begin
					o_con_muxalu = 0;
					o_con_gpr_shift = 1;
					o_con_gpr_write = 1;
					o_con_acc_shift = 1;
					o_con_acc_write = 1;
					case(count)
						7 : begin 
							o_con_pcincr = 1;
						end

						default : ;
					endcase 
				end 
			endcase 
		end


		3'b10? : begin 	//Add
			o_con_mux = 0;
			o_con_muxalu = 0;
			o_con_gpr_write = 1;
			o_con_gpr_shift = 1;
			o_con_acc_shift = 1;
			case(count)
				7 : begin
					o_con_pcincr = 1;
				end 

				default : ;
			endcase
		end

		3'b110 : begin 	//wait switch off
			if(~i_start)
			begin
				o_con_pcincr = 1;
				count_rst = 1;
			end
		end 


		3'b111 : begin 	//Load X
			o_con_mux = 1;
			o_con_gpr_write = 1;
			o_con_gpr_shift = 1;
			case(count)
				7 : begin
					o_con_pcincr = 1;
				end
			
				default : ;
			endcase
		end
	endcase
end

endmodule
