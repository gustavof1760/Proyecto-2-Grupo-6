`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:33:35
// Design Name: 
// Module Name: CTRL_RTC_2
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


module CTRL_RTC_2(
	input wire clk,
	input wire rst,
	
	input wire [2:0] switch,
	input wire p_timer,
	
	input wire bot_up,
	input wire bot_down,
	input wire bot_right,
	input wire bot_left,
	
	input wire alarma,
	
	inout wire [7:0] AD,
	
	output wire a_d, cs, rd, wr,
	
	output wire h_sync, v_sync,
	output wire [11:0] rgb_text_salida
	
   );
   
   
	wire reset;
	assign reset = ~rst;
	
	wire [2:0] SW;
	
	SWITCHES Int(
		.S(switch),
		.prog(SW)
	);
	
	wire incremento;
	
	ANTIREBOTE Boton_Arriba(
		.clk(clk),
		.reset(reset),
		.entrada(bot_up),
		.salida(incremento)
	);
	
	wire decremento;
	
	ANTIREBOTE Boton_Abajo(
		.clk(clk),
		.reset(reset),
		.entrada(bot_down),
		.salida(decremento)
	);
	
	wire derecha;
	
	ANTIREBOTE Boton_Derecha(
		.clk(clk),
		.reset(reset),
		.entrada(bot_right),
		.salida(derecha)
	);
	
	wire izquierda;
	
	ANTIREBOTE Boton_Izquierda(
		.clk(clk),
		.reset(reset),
		.entrada(bot_left),
		.salida(izquierda)
	);
	
	wire parar_timer;
	
	ANTIREBOTE Boton_Centro(
		.clk(clk),
		.reset(reset),
		.entrada(p_timer),
		.salida(parar_timer)
	);
	
	wire en_dir = en_contadores_hora | en_contadores_fecha | en_contadores_timer;
	wire [1:0] direccion;
	
	CONT_DIR CuentaDireccion(
		.clk(clk),
		.reset(reset),
		.der(derecha),
		.izq(izquierda),
		.en(en_dir),
		.dir(direccion)
	);
	
	wire en_contadores_hora;
	wire en_contadores_fecha;
	wire en_contadores_timer;
	
	wire most_cur;

	wire en_seg_g, en_min_g, en_hora_g, en_dia_g, en_mes_g, en_anio_g, en_seg_t_g, en_min_t_g, en_hora_t_g;
	// Se unen porque el el VGA las recibe en un byte.
	wire [8:0] banderas_dir = {en_dia_g, en_mes_g, en_anio_g, en_hora_g, en_min_g, en_seg_g, en_hora_t_g, en_min_t_g, en_seg_t_g};

	DECO_DIR Decodificador(
		.dir_bin(direccion),
		.en_cont_hora(en_contadores_hora),
		.en_cont_fecha(en_contadores_fecha),
		.en_cont_timer(en_contadores_timer),
		.cursor(most_cur),
		.en_seg(en_seg_g),
		.en_min(en_min_g),
		.en_hora(en_hora_g),
		.en_dia(en_dia_g),
		.en_mes(en_mes_g),
		.en_anio(en_anio_g),
		.en_seg_t(en_seg_t_g),
		.en_min_t(en_min_t_g),
		.en_hora_t(en_hora_t_g)		
	);
	
	
	
	wire [7:0] dato_prog_seg, dato_prog_min, dato_prog_hora, dato_prog_dia, dato_prog_mes, dato_prog_anio,
		dato_prog_seg_t, dato_prog_min_t, dato_prog_hora_t;
	
	CONT_DATOS CuentaDatos(
		.clk(clk),
		.reset(reset),
		.arriba(incremento),
		.abajo(decremento),
		.en_seg(en_seg_g),
		.en_min(en_min_g),
		.en_hora(en_hora_g),
		.en_dia(en_dia_g),
		.en_mes(en_mes_g),
		.en_anio(en_anio_g),
		.en_seg_t(en_seg_t_g),
		.en_min_t(en_min_t_g),
		.en_hora_t(en_hora_t_g),
		.dato_prog_seg(dato_prog_seg),
		.dato_prog_min(dato_prog_min),
		.dato_prog_hora(dato_prog_hora),
		.dato_prog_dia(dato_prog_dia),
		.dato_prog_mes(dato_prog_mes),
		.dato_prog_anio(dato_prog_anio),
		.dato_prog_seg_t(dato_prog_seg_t),
		.dato_prog_min_t(dato_prog_min_t),
		.dato_prog_hora_t(dato_prog_hora_t)
	);

	
	wire ch0_mux1, ch1_mux1, ch0_mux2, ch1_mux2;
	wire buf_act;
	wire dat_esc_zero, dat_esc_init, dat_59,
		dir_st2, dir_com_cyt, dir_com_c, dir_com_t, dir_seg, dir_min, dir_hora, dir_dia, dir_mes, dir_anio,
		dir_seg_tim, dir_min_tim, dir_hora_tim, dir_tim_en, dir_tim_mask,
		
		dat_lect_seg, dat_lect_min, dat_lect_hora, dat_lect_dia, dat_lect_mes,
		dat_lect_anio, dat_lect_seg_tim, dat_lect_min_tim, dat_lect_hora_tim,
		
		dat_esc_seg, dat_esc_min, dat_esc_hora, dat_esc_dia, dat_esc_mes,
		dat_esc_anio, dat_esc_seg_tim, dat_esc_min_tim, dat_esc_hora_tim,
		dat_tim_en, dat_tim_mask;
	
	wire alarma2 = ~alarma;
	
	FSM_GENERAL Maquina_General(
		.clk(clk),
		.reset(reset),
		.a_d_g(a_d),
		.cs_g(cs),
		.rd_g(rd),
		.wr_g(wr),
		.S2(SW[2]),
		.S1(SW[1]),
		.S0(SW[0]),
		.ch0_mux1_g(ch0_mux1),
		.ch1_mux1_g(ch1_mux1),
		.buffer_activo_g(buf_act),
		.ch0_mux2_g(ch0_mux2),
		.ch1_mux2_g(ch1_mux2),
		.s_stop_t(parar_timer),
		.en_contadores_hora_g(en_contadores_hora),
		.en_contadores_fecha_g(en_contadores_fecha),
		.en_contadores_timer_g(en_contadores_timer),
		.dat_esc_init_g(dat_esc_init),
		.dat_esc_zero_g(dat_esc_zero),
		.dat_59_g(dat_59),
		.dir_st2_g(dir_st2),
		.dir_com_cyt_g(dir_com_cyt), ////
		.dir_seg_g(dir_seg), ////
		.dir_min_g(dir_min), ////
		.dir_hora_g(dir_hora), ////
		.dir_dia_g(dir_dia), ////
		.dir_mes_g(dir_mes), ////
		.dir_anio_g(dir_anio), ////
		.dir_seg_tim_g(dir_seg_tim), ////
		.dir_min_tim_g(dir_min_tim), ////
		.dir_hora_tim_g(dir_hora_tim), ////
		.dat_lect_seg_g(dat_lect_seg),
		.dat_lect_min_g(dat_lect_min),
		.dat_lect_hora_g(dat_lect_hora),
		.dat_lect_dia_g(dat_lect_dia),
		.dat_lect_mes_g(dat_lect_mes),
		.dat_lect_anio_g(dat_lect_anio),
		.dat_lect_seg_tim_g(dat_lect_seg_tim),
		.dat_lect_min_tim_g(dat_lect_min_tim),
		.dat_lect_hora_tim_g(dat_lect_hora_tim),
		.dat_esc_seg_g(dat_esc_seg),
		.dat_esc_min_g(dat_esc_min),
		.dat_esc_hora_g(dat_esc_hora),
		.dat_esc_dia_g(dat_esc_dia),
		.dat_esc_mes_g(dat_esc_mes),
		.dat_esc_anio_g(dat_esc_anio),
		.dat_esc_seg_tim_g(dat_esc_seg_tim),
		.dat_esc_min_tim_g(dat_esc_min_tim),
		.dat_esc_hora_tim_g(dat_esc_hora_tim),
		.dir_com_c_g(dir_com_c),
		.dir_com_t_g(dir_com_t),
		.dir_tim_en_g(dir_tim_en),
		.dir_tim_mask_g(dir_tim_mask),
		.dat_tim_en_g(dat_tim_en),
		.dat_tim_mask_g(dat_tim_mask),
		.most_cur_g(most_cur)
	);
	
	wire [7:0] dato_ctrl_data;
	
	CONTROL_DATA CtrlEscritura(
		.dat_esc_init(dat_esc_init),
		.dat_esc_zero(dat_esc_zero),
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
		.dato_salida(dato_ctrl_data),
		.dir_com_c(dir_com_c),
		.dir_com_t(dir_com_t),
		.dir_tim_en(dir_tim_en),
		.dir_tim_mask(dir_tim_mask),
		.dat_tim_en(dat_tim_en),
		.dat_tim_mask(dat_tim_mask),
		.dat_59(dat_59)
	);
		
	wire [7:0] dato_reg_esc;
	
	REGISTRO_SENCILLO RegEscritura(
		.clk(clk),
		.reset(reset),
		.data_in(dato_ctrl_data),
		.data_out(dato_reg_esc)
	);
	
	/* Registros de programación */
	
	wire [7:0] dat_prog_seg, dat_prog_min, dat_prog_hora, dat_prog_dia, dat_prog_mes, dat_prog_anio,
		dat_prog_seg_tim, dat_prog_min_tim, dat_prog_hora_tim;
		
	REGISTRO_SENCILLO Registro_prog_seg(
		.clk(clk),
		.reset(reset),
		.data_in(dato_prog_seg),
		.data_out(dat_prog_seg)
	);
	
	REGISTRO_SENCILLO Registro_prog_min(
		.clk(clk),
		.reset(reset),
		.data_in(dato_prog_min),
		.data_out(dat_prog_min)
	);
	
	REGISTRO_SENCILLO Registro_prog_hora(
		.clk(clk),
		.reset(reset),
		.data_in(dato_prog_hora),
		.data_out(dat_prog_hora)
	);
	
	REGISTRO_SENCILLO Registro_prog_dia(
		.clk(clk),
		.reset(reset),
		.data_in(dato_prog_dia),
		.data_out(dat_prog_dia)
	);
	
	REGISTRO_SENCILLO Registro_prog_mes(
		.clk(clk),
		.reset(reset),
		.data_in(dato_prog_mes),
		.data_out(dat_prog_mes)
	);
	
	REGISTRO_SENCILLO Registro_prog_anio(
		.clk(clk),
		.reset(reset),
		.data_in(dato_prog_anio),
		.data_out(dat_prog_anio)
	);
	
	REGISTRO_SENCILLO Registro_prog_seg_tim(
		.clk(clk),
		.reset(reset),
		.data_in(dato_prog_seg_t),
		.data_out(dat_prog_seg_tim)
	);
	
	REGISTRO_SENCILLO Registro_prog_min_tim(
		.clk(clk),
		.reset(reset),
		.data_in(dato_prog_min_t),
		.data_out(dat_prog_min_tim)
	);
	
	REGISTRO_SENCILLO Registro_prog_hora_tim(
		.clk(clk),
		.reset(reset),
		.data_in(dato_prog_hora_t),
		.data_out(dat_prog_hora_tim)
	);
	
	wire [7:0] hora_mux3, min_mux3, seg_mux3;
	
	RESTA_RTC Resta(
		.hora_in(dat_prog_hora_tim),
		.minuto_in(dat_prog_min_tim),
		.segundo_in(dat_prog_seg_tim),
		.hora_out(hora_mux3),
		.minuto_out(min_mux3),
		.segundo_out(seg_mux3)
	);
	
	
	wire [7:0] dato_mux_prog;
	
	MUX3 mux3(
		.ch0_mux3(dat_esc_seg),
		.ch1_mux3(dat_esc_min),
		.ch2_mux3(dat_esc_hora),
		.ch3_mux3(dat_esc_dia),
		.ch4_mux3(dat_esc_mes),
		.ch5_mux3(dat_esc_anio),
		.ch6_mux3(dat_esc_seg_tim),
		.ch7_mux3(dat_esc_min_tim),
		.ch8_mux3(dat_esc_hora_tim),
		.ch0(dat_prog_seg),
		.ch1(dat_prog_min),
		.ch2(dat_prog_hora),
		.ch3(dat_prog_dia),
		.ch4(dat_prog_mes),
		.ch5(dat_prog_anio),
		.ch6(seg_mux3),
		.ch7(min_mux3),
		.ch8(hora_mux3),
		.y3(dato_mux_prog)
	);
	
	wire [7:0] dato_mux_esc;
	
	mux1 mux1(
		.ch0_mux1(ch0_mux1),
		.ch1_mux1(ch1_mux1),
		.ch0(dato_reg_esc),
		.ch1(dato_mux_prog),
		.y1(dato_mux_esc)
	);
	
	wire [7:0] dato_rtc_lect;
	
	BUFFER_TRIESTADO Buffer(
		.AD(AD),
		.sig_out(dato_mux_esc),
		.sig_in(dato_rtc_lect),
		.buffer_activo(buf_act)
	);
	
	wire [7:0] seg_l, min_l, hora_l, dia_l, mes_l, anio_l, seg_t_l, min_t_l, hora_t_l;
		
	DIRECCION_DATOS Registro_Lectura(
		.clk(clk),
		.reset(reset),
		.entrada(dato_rtc_lect),
		.en_seg(dat_lect_seg),
		.en_min(dat_lect_min),
		.en_hora(dat_lect_hora),
		.en_dia(dat_lect_dia),
		.en_mes(dat_lect_mes),
		.en_anio(dat_lect_anio),
		.en_seg_tim(dat_lect_seg_tim), 
		.en_min_tim(dat_lect_min_tim),
		.en_hora_tim(dat_lect_hora_tim),
		.sal_seg(seg_l),
		.sal_min(min_l),
		.sal_hora(hora_l),
		.sal_dia(dia_l),
		.sal_mes(mes_l),
		.sal_anio(anio_l),
		.sal_seg_tim(seg_t_l),
		.sal_min_tim(min_t_l), 
		.sal_hora_tim(hora_t_l)
	);
	
	wire [7:0] seg, min, hora, dia, mes, anio, seg_t, min_t, hora_t;

	mux2 mux2_1(
		.ch0_mux2(ch0_mux2),
		.ch1_mux2(ch1_mux2),
		.ch0(dat_prog_seg),
		.ch1(seg_l),
		.y2(seg)
	);
	
	mux2 mux2_2(
		.ch0_mux2(ch0_mux2),
		.ch1_mux2(ch1_mux2),
		.ch0(dat_prog_min),
		.ch1(min_l),
		.y2(min)
	);
	
	mux2 mux2_3(
		.ch0_mux2(ch0_mux2),
		.ch1_mux2(ch1_mux2),
		.ch0(dat_prog_hora),
		.ch1(hora_l),
		.y2(hora)
	);
	
	mux2 mux2_4(
		.ch0_mux2(ch0_mux2),
		.ch1_mux2(ch1_mux2),
		.ch0(dat_prog_dia),
		.ch1(dia_l),
		.y2(dia)
	);
	
	mux2 mux2_5(
		.ch0_mux2(ch0_mux2),
		.ch1_mux2(ch1_mux2),
		.ch0(dat_prog_mes),
		.ch1(mes_l),
		.y2(mes)
	);
	
	mux2 mux2_6(
		.ch0_mux2(ch0_mux2),
		.ch1_mux2(ch1_mux2),
		.ch0(dat_prog_anio),
		.ch1(anio_l),
		.y2(anio)
	);
	
	wire [7:0] hora_vga, min_vga, seg_vga;
	
	mux2 mux2_7(
		.ch0_mux2(ch0_mux2),
		.ch1_mux2(ch1_mux2),
		.ch0(dat_prog_seg_tim),
		.ch1(seg_vga),
		.y2(seg_t)
	);
	
	mux2 mux2_8(
		.ch0_mux2(ch0_mux2),
		.ch1_mux2(ch1_mux2),
		.ch0(dat_prog_min_tim),
		.ch1(min_vga),
		.y2(min_t)
	);
	
	mux2 mux2_9(
		.ch0_mux2(ch0_mux2),
		.ch1_mux2(ch1_mux2),
		.ch0(dat_prog_hora_tim),
		.ch1(hora_vga),
		.y2(hora_t)
	);
	
	RESTA_RTC RestaVGA(
		.hora_in(hora_t_l),
		.minuto_in(min_t_l),
		.segundo_in(seg_t_l),
		.hora_out(hora_vga),
		.minuto_out(min_vga),
		.segundo_out(seg_vga)
	);
	
	reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
	wire pixel_tick;
	wire video_on;
	wire [9:0] pixel_x, pixel_y;
	
	
	Divisor_F divisor(
           .clk(clk),
           .reset(reset),
           .SCLKclk(SCLKclk)
           );
           
           //wire SCLKclk;
           wire clk_in;
           assign clk_in = SCLKclk;
	
    VGA_Sync Sincronizador(
		.clk_in(clk_in),
		.reset(reset),
		.hsync(h_sync),
		.vsync(v_sync),
		.video_on(video_on),
		.p_tick(pixel_tick),
		.pixel_x(pixel_x),
		.pixel_y(pixel_y)
	);
	
	wire [11:0] rgb_text;
	
	Generador_texto GeneradorVGA(
		.clk(clk),
		.pixel_x(pixel_x),
		.pixel_y(pixel_y),
		.Alarma_on(alarma2),
		.bandera_cursor(banderas_dir),
		.digit_DD(dia),
		.digit_M(mes),
		.digit_AN(anio),
		.digit_HORA(hora),
		.digit_MIN(min),
		.digit_SEG(seg),
		.digit_TimerHORA(hora_t),
		.digit_TimerMIN(min_t),
		.digit_TimerSEG(seg_t),
		.rgb_text(rgb_text)
	);
	
	MUX_RGB Mux_color(
	    .video_on(video_on),
	    .rgb_text(rgb_text),
	    .RGB(rgb_next)
	);    	

	 // rgb buffer
      always @(negedge clk)
         if (pixel_tick)
            rgb_reg <= rgb_next;
      // output
      assign rgb_text_salida = rgb_reg;
       

endmodule