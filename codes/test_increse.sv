module test_increse;

logic [2:0] in, out;

increase u_increase(.*);

initial
begin
	in = 3'b000;
	#10ns in = 3'b001;
	#10ns in = 3'b011;
end
endmodule