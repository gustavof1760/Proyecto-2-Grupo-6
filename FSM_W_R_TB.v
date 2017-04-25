`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:58:58
// Design Name: 
// Module Name: FSM_W_R_TB
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


module FSM_W_R_TB;

	// Inputs
	reg clk;
	reg reset;
	reg w_r;
	reg do_it;

	// Outputs
	wire a_d;
	wire cs;
	wire rd;
	wire wr;
	wire read_data;
	wire send_data;
	wire send_add;

	// Instantiate the Unit Under Test (UUT)
	FSM_W_R uut (
		.clk(clk), 
		.reset(reset), 
		.w_r(w_r), 
		.do_it(do_it), 
		.a_d(a_d), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.read_data(read_data), 
		.send_data(send_data), 
		.send_add(send_add)
	);
	
	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		w_r = 1;
		do_it = 1;
		#100;
		reset = 0;
		#30;
		do_it = 0;
		#370;
		reset = 1;
		w_r = 0;
		do_it = 1;
		#100;
		reset = 0;
		#30;
		do_it = 0;
		#370;
		$stop;

	end
      
endmodule