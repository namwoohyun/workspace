module decision(x1_i,x2_i,x3_i,start_i,y_o,y_valid_o,clk,reset);
input [7:0] x1_i,x2_i,x3_i;
input start_i,clk,reset;
output reg [7:0] y_o;
output reg y_valid_o=0;
reg [2:0] status = 3'b000;
reg [2:0] nextstatus;
reg [7:0] A = 8'b00000111,B = 8'b00010000,C = 3'b110;
always @(posedge clk)
begin
	if(start_i == 1) begin
		if (reset == 1) begin
			status <= 3'b000;
		end
		else begin
			status <= nextstatus;
		end
	end
	else begin
		status <= 3'b000;
		y_valid_o = 0;
	end
end
always @(*)
	case(status)
		3'b000: nextstatus = (x1_i > A) ? 3'b001 : 3'b010;
		3'b001: nextstatus = (x2_i > B) ? 3'b011 : 3'b100;
		3'b010: begin
			y_o = 8'b00000011;
			y_valid_o = 1;
		end
		3'b011: nextstatus = (x3_i > C) ? 3'b101 : 3'b110;
		3'b100: begin
			y_o = 8'b00000100;
			y_valid_o = 1;
		end
		3'b101: begin
			y_o = 8'b00000001;
			y_valid_o = 1;
		end
		3'b110: begin
			y_o = 8'b00000010;
			y_valid_o = 1;
		end
		default : y_valid_o = 0;
	endcase
endmodule // decision