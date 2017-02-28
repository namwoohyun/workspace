//*******************************************
//文件名：decisiontree.v
//功能描述：根据RAM中的决策树以及x_i中的值，输出决策情况y_o；
//输入：开始信号（start_i），时钟信号（clk），同步复位信号（reset）；
//输出：有效信号（y_valid_o），决策结果（y_o）；
//日期：2017/2/26
//作者：liuyoujin
//*******************************************
`define DATA 8
`define STATE 8
`define FIRST 1
`define AWAIT 0
module decisiontree (start_i,y_o,y_valid_o,clk,reset);
	input start_i,clk,reset;
	output reg [`DATA-1 : 0] y_o;
	output reg y_valid_o=0;
	reg [`STATE+1+`DATA+`STATE+`STATE+`DATA-1 : 0] ram[0 : 2**`STATE - 1];
	reg [`STATE-1 : 0] n = `AWAIT,state = `AWAIT,nextstate_T,nextstate_F,nextstate;
	reg [`DATA-1 : 0] x_i[0 : 2**`STATE - 1],x;
	reg [`DATA-1 : 0] data,y;
	reg dec;

	initial
     begin
        $readmemb("decision.txt",ram,1,7);				//将决策树和输入值从文件中读入
        $readmemb("x_i.txt",x_i,1,3);
     end	
	always @(*) 
	begin
		{dec,data,nextstate_T,nextstate_F,y} = ram[state];			//根据当前状态取出决策树中的状态点
		/*dec表示是决策点还是输出点，data表示要比较的数，nextstate_T表示比较结果为真时的次态，nextstate_F表示比较结果为假时的次态,y表示输出点的输出*/
		x = x_i[n];
	end

	always @(posedge clk)
	begin
		if((state == `AWAIT && start_i == 1) || reset == 1)
		begin
			state <= `FIRST;            //接受开始信号或复位信号后进入工作状态
			n <= `FIRST;
		end
		else if(dec == 1) 
		begin
			state <= `AWAIT;
			n <= `AWAIT;
			nextstate <= `AWAIT;
		end
		else begin
			n <= n + 1;
			state <= nextstate;         //进行状态跳转
		end
	end
	
	always @(*)
	begin 
		if(dec == 0) 						//为0时为决策点，为1时为输出点
		begin
			nextstate = (x > data) ? nextstate_T : nextstate_F;
		end
		else begin 
			y_valid_o = 1; 				//输出点进行输出并复位
			y_o = y;
		end
	end
	
endmodule