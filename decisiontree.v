`define DATA 8
`define STATU 8
`define FIRST 0
module decision (start_i,y_o,y_valid_o,clk,reset);
	input start_i,clk,reset;
	output reg [`DATA-1 : 0] y_o;
	output reg y_valid_o=0;
	reg [`STATU+1+`DATA+`STATU+`STATU+`DATA-1 : 0] ram[0 : 2**`STATU - 1];
	reg [`STATU-1 : 0] status = `FIRST,nextstatus_T,nextstatus_F,nextstatus;
	reg [`DATA-1 : 0] x_i[0 : 2**`STATU - 1];
	reg [`DATA-1 : 0] data,y;
	reg dec,n = `FIRST;

	initial
     begin
        $readmemb("decision.txt",ram,0,6);
        $readmemb("x_i.txt",x_i,0,2);
     end

	always @(*) {dec,data,nextstatus_T,nextstatus_F,y} = ram[status];

	always @(posedge clk)
	begin
		if(start_i == 1) begin
			if (reset == 1) begin
				status <= 3'b000;
				n <= 0;
			end
			else begin
				n <= n + 1;
				status <= nextstatus;
			end
		end
		else begin
			status <= 3'b000;
			y_valid_o = 0;
		end
	end

	always @(*)
	begin 
		if(dec == 0) 
		begin
			if(x_i[n] > data) 
			begin
				nextstatus <= nextstatus_T;
			end
			else
			begin 
				nextstatus <= nextstatus_F;
			end
		end
		else
		begin 
			y_valid_o <= 1; 
			y_o <= y;
		end
	end
	
endmodule