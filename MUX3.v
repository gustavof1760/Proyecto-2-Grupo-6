`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:51:24
// Design Name: 
// Module Name: MUX3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MUX3(
	input wire ch0_mux3,
	input wire ch1_mux3,
	input wire ch2_mux3,
	input wire ch3_mux3,
	input wire ch4_mux3,
	input wire ch5_mux3,
	input wire ch6_mux3,
	input wire ch7_mux3,
	input wire ch8_mux3,
	
	input wire [7:0] ch0,
	input wire [7:0] ch1,
	input wire [7:0] ch2,
	input wire [7:0] ch3,
	input wire [7:0] ch4,
	input wire [7:0] ch5,
	input wire [7:0] ch6,
	input wire [7:0] ch7,
	input wire [7:0] ch8,
	
	output reg [7:0] y3

   );
	
	reg [3:0] sel;
	
	always @* begin
		if (ch0_mux3) begin
			sel = 4'b0000;
		end else if (ch1_mux3) begin
			sel = 4'b0001;
		end else if (ch2_mux3) begin
			sel = 4'b0010;
		end else if (ch3_mux3) begin
			sel = 4'b0011;
		end else if (ch4_mux3) begin
			sel = 4'b0100;
		end else if (ch5_mux3) begin
			sel = 4'b0101;
		end else if (ch6_mux3) begin
			sel = 4'b0110;
		end else if (ch7_mux3) begin
			sel = 4'b0111;
		end else if (ch8_mux3) begin
			sel = 4'b1000;
		end else begin
			sel = 4'b1111;
		end
	end
	
	always @* begin
		case(sel)
			4'b0000: y3 = ch0;
			4'b0001: y3 = ch1;
			4'b0010: y3 = ch2;
			4'b0011: y3 = ch3;
			4'b0100: y3 = ch4;
			4'b0101: y3 = ch5;
			4'b0110: y3 = ch6;
			4'b0111: y3 = ch7;
			4'b1000: y3 = ch8;
			default: y3 = 8'h77;
		endcase
	end
	
endmodule