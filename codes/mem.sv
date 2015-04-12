// module mem(
// 	input logic i_rst,
// 	input logic [2:0] i_pc,
// 	output logic [2:0] o_instr
// 	);

// logic [2:0] mem [0:7];
// assign o_instr = mem[i_pc];

// always_ff @(posedge i_rst)
// begin
// 	mem[0] = 3'b000;	//NOP
// 	mem[1] = 3'b111;	//load X
// 	mem[2] = 3'b001; 	//stall
// 	mem[3] = 3'b010; 	//mult y, d
// 	mem[4] = 3'b001; 	//stall
// 	mem[5] = 3'b011; 	//mult x, 1-d
// 	mem[6] = 3'b100; 	//add y,x
// 	mem[7] = 3'b110; 	//wait switch off
// end 

// endmodule

module mem #(parameter Psize = 3, Isize = 2) // psize - address width, Isize - instruction width
(input logic [Psize-1:0] address,
output logic [Isize:0] I); // I - instruction code

// program memory declaration, note: 1<<n is same as 2^n
logic [Isize:0] progMem[ (1<<Psize)-1:0];

// get memory contents from file
initial
  $readmemh("prog.hex", progMem);
  
// program memory read 
always_comb
  I = progMem[address];
  
endmodule // end of module prog