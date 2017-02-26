`timescale 1ps/1ps
`include "decisiontree.v"
module decision_test;
	reg start_i,clk,reset;
	wire [7:0] y_o;
	wire y_valid_o;

	always #100 clk = ~clk;

	decision decision(start_i,y_o,y_valid_o,clk,reset);
	
	initial
	begin 
		clk = 0;
		start_i = 1;
		reset = 0;
		#2000 
		case (y_o)
	 	8'b00000001 : $display("Y1");
	 	8'b00000010 : $display("Y2");
	 	8'b00000011 : $display("Y3");
	 	8'b00000100 : $display("Y4");
	 		default : $display("error");
	 	endcase // y_o
		#1000 $finish;
	end

	initial
     begin
        $dumpfile("decisiontree_test.vcd");
        $dumpvars(0,decision_test);
     end

endmodule // decision_test