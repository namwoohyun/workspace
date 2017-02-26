`timescale 1ps/1ps
`include "decision.v"
module decision_test;
	reg [7:0] x1_i,x2_i,x3_i;
	reg start_i,clk,reset;
	wire [7:0] y_o;
	wire y_valid_o;
	always #100 clk = ~clk;
	decision decision(x1_i,x2_i,x3_i,start_i,y_o,y_valid_o,clk,reset);
	initial
	begin 
		clk = 0;
		x1_i = 8'b10000000;
		x2_i = 8'b10000000;
		x3_i = 8'b10000000;
		start_i = 1;
		reset = 0;
		#2000 case (y_o)
	 	8'b00000001 : $display("Y1");
	 	8'b00000010 : $display("Y2");
	 	8'b00000011 : $display("Y3");
	 	8'b00000100 : $display("Y4");
	 		default : $display("error");
	 	endcase
		reset = 1;
		#2000
		x1_i = 8'b00001000;
		x2_i = 8'b10000000;
		x3_i = 8'b00000001;
		reset = 0;
		#2000 case (y_o)
	 	8'b00000001 : $display("Y1");
	 	8'b00000010 : $display("Y2");
	 	8'b00000011 : $display("Y3");
	 	8'b00000100 : $display("Y4");
	 		default : $display("error");
	 	endcase
		reset = 1;
		#2000
		x1_i = 8'b00001000;
		x2_i = 8'b00000001;
		x3_i = 8'b00000001;
		reset = 0;
		#2000 case (y_o)
	 	8'b00000001 : $display("Y1");
	 	8'b00000010 : $display("Y2");
	 	8'b00000011 : $display("Y3");
	 	8'b00000100 : $display("Y4");
	 		default : $display("error");
	 	endcase
		reset = 1;
		#2000
		x1_i = 8'b00000001;
		x2_i = 8'b00000001;
		x3_i = 8'b00000001;
		reset = 0;
		#2000 case (y_o)
	 	8'b00000001 : $display("Y1");
	 	8'b00000010 : $display("Y2");
	 	8'b00000011 : $display("Y3");
	 	8'b00000100 : $display("Y4");
	 		default : $display("error");
	 	endcase
		$finish;
	end
	// task cout;
	// 	input [7:0] y_o;
	// 	always @(*)
	// 	case (y_o)
	// 	8'b00000001 : $display("Y1");
	// 	8'b00000010 : $display("Y2");
	// 	8'b00000011 : $display("Y3");
	// 	8'b00000100 : $display("Y4");
	// 		default : $display("error");
	// 	endcase
	// endtask
	initial
     begin
        $dumpfile("decision_test.vcd");
        $dumpvars(0,decision_test);
     end
endmodule // decision_test