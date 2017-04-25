`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 02:02:30
// Design Name: 
// Module Name: FSM_GENERAL_TB
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


module FSM_GENERAL_TB;

	// Inputs
	reg clk;
	reg reset;
	reg S2;
	reg S1;
	reg S0;

	// Outputs
	wire a_d_g;
	wire cs_g;
	wire rd_g;
	wire wr_g;
	wire ch0_mux1_g;
	wire ch1_mux1_g;
	wire buffer_activo_g;
	wire ch0_mux2_g;
	wire ch1_mux2_g;
	wire dat_esc_init_g;
	wire dat_esc_zero_g;
	wire dir_st2_g;
	wire dir_com_cyt_g;
	wire dir_seg_g;
	wire dir_min_g;
	wire dir_hora_g;
	wire dir_dia_g;
	wire dir_mes_g;
	wire dir_anio_g;
	wire dir_seg_tim_g;
	wire dir_min_tim_g;
	wire dir_hora_tim_g;
	wire dat_lect_seg_g;
	wire dat_lect_min_g;
	wire dat_lect_hora_g;
	wire dat_lect_dia_g;
	wire dat_lect_mes_g;
	wire dat_lect_anio_g;
	wire dat_lect_seg_tim_g;
	wire dat_lect_min_tim_g;
	wire dat_lect_hora_tim_g;
	wire dat_esc_seg_g;
	wire dat_esc_min_g;
	wire dat_esc_hora_g;
	wire dat_esc_dia_g;
	wire dat_esc_mes_g;
	wire dat_esc_anio_g;
	wire dat_esc_seg_tim_g;
	wire dat_esc_min_tim_g;
	wire dat_esc_hora_tim_g;
	wire en_contadores_hora_g;
	wire en_contadores_fecha_g;
	wire en_contadores_timer_g;

	// Instantiate the Unit Under Test (UUT)
	FSM_GENERAL uut (
		.clk(clk), 
		.reset(reset), 
		.S2(S2), 
		.S1(S1), 
		.S0(S0), 
		.a_d_g(a_d_g), 
		.cs_g(cs_g), 
		.rd_g(rd_g), 
		.wr_g(wr_g), 
		.ch0_mux1_g(ch0_mux1_g), 
		.ch1_mux1_g(ch1_mux1_g), 
		.buffer_activo_g(buffer_activo_g), 
		.ch0_mux2_g(ch0_mux2_g), 
		.ch1_mux2_g(ch1_mux2_g), 
		.dat_esc_init_g(dat_esc_init_g), 
		.dat_esc_zero_g(dat_esc_zero_g), 
		.dir_st2_g(dir_st2_g), 
		.dir_com_cyt_g(dir_com_cyt_g), 
		.dir_seg_g(dir_seg_g), 
		.dir_min_g(dir_min_g), 
		.dir_hora_g(dir_hora_g), 
		.dir_dia_g(dir_dia_g), 
		.dir_mes_g(dir_mes_g), 
		.dir_anio_g(dir_anio_g), 
		.dir_seg_tim_g(dir_seg_tim_g), 
		.dir_min_tim_g(dir_min_tim_g), 
		.dir_hora_tim_g(dir_hora_tim_g), 
		.dat_lect_seg_g(dat_lect_seg_g), 
		.dat_lect_min_g(dat_lect_min_g), 
		.dat_lect_hora_g(dat_lect_hora_g), 
		.dat_lect_dia_g(dat_lect_dia_g), 
		.dat_lect_mes_g(dat_lect_mes_g), 
		.dat_lect_anio_g(dat_lect_anio_g), 
		.dat_lect_seg_tim_g(dat_lect_seg_tim_g), 
		.dat_lect_min_tim_g(dat_lect_min_tim_g), 
		.dat_lect_hora_tim_g(dat_lect_hora_tim_g), 
		.dat_esc_seg_g(dat_esc_seg_g), 
		.dat_esc_min_g(dat_esc_min_g), 
		.dat_esc_hora_g(dat_esc_hora_g), 
		.dat_esc_dia_g(dat_esc_dia_g), 
		.dat_esc_mes_g(dat_esc_mes_g), 
		.dat_esc_anio_g(dat_esc_anio_g), 
		.dat_esc_seg_tim_g(dat_esc_seg_tim_g), 
		.dat_esc_min_tim_g(dat_esc_min_tim_g), 
		.dat_esc_hora_tim_g(dat_esc_hora_tim_g), 
		.en_contadores_hora_g(en_contadores_hora_g), 
		.en_contadores_fecha_g(en_contadores_fecha_g), 
		.en_contadores_timer_g(en_contadores_timer_g)
	);
	
	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		S2 = 0;
		S1 = 0;
		S0 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		#10000;
		S1 = 1;
		#10000;
		S1 = 0;
		#16500000;
		$stop;

	end
      
endmodule
