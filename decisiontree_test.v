//*******************************************
//文件名：decisiontree_test.v
//功能描述：测试文件，调用decisiontree，产生控制信号并显示输出；
//输入：
//输出：
//日期：2017/2/26
//作者：liuyoujin
//*******************************************
`timescale 1ps/1ps
`include "decisiontree.v"
module decision_test;
	reg start_i,clk,reset;
	wire [7:0] y_o;
	wire y_valid_o;

	always #100 clk = ~clk;

	decisiontree decisiontree(start_i,y_o,y_valid_o,clk,reset);
	
	initial
	begin 
		clk = 0;									//初始化时钟和复位信号，产生开始信号
		start_i = 1;
		reset = 0;
		#2000 
		case (y_o)									//根据输出选择Y1，Y2，Y3，Y4进行显示
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