`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 02:01:22
// Design Name: 
// Module Name: FSM_INIC_RTC_TB
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


module FSM_INIC_RTC_TB;

	// Inputs
	reg clk;
	reg reset;
	reg do_it_inic;

	// Outputs
	wire a_d;
	wire cs;
	wire rd;
	wire wr;
	wire ch0_mux1;
	wire dat_esc_init;
	wire dat_esc_zero;
	wire dat_59;
	wire dir_st2;
	wire dir_com_cyt;
	wire dir_seg;
	wire dir_min;
	wire dir_hora;
	wire dir_dia;
	wire dir_mes;
	wire dir_anio;
	wire dir_seg_tim;
	wire dir_min_tim;
	wire dir_hora_tim;
	wire dir_tim_en;
	wire buffer_activo;

	// Instantiate the Unit Under Test (UUT)
	FSM_INIC_RTC uut (
		.clk(clk), 
		.reset(reset), 
		.do_it_inic(do_it_inic), 
		.a_d(a_d), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.ch0_mux1(ch0_mux1), 
		.dat_esc_init(dat_esc_init), 
		.dat_esc_zero(dat_esc_zero), 
		.dat_59(dat_59), 
		.dir_st2(dir_st2), 
		.dir_com_cyt(dir_com_cyt), 
		.dir_seg(dir_seg), 
		.dir_min(dir_min), 
		.dir_hora(dir_hora), 
		.dir_dia(dir_dia), 
		.dir_mes(dir_mes), 
		.dir_anio(dir_anio), 
		.dir_seg_tim(dir_seg_tim), 
		.dir_min_tim(dir_min_tim), 
		.dir_hora_tim(dir_hora_tim), 
		.dir_tim_en(dir_tim_en), 
		.buffer_activo(buffer_activo)
	);

	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		do_it_inic = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		#5600;
		$stop;

	end
      
endmodule
