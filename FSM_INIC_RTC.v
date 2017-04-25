`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:42:37
// Design Name: 
// Module Name: FSM_INIC_RTC
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


module FSM_INIC_RTC(
	input wire clk, reset,
	input wire do_it_inic,
	
	output wire a_d, cs, rd, wr, // Señales de ctrl RTC.
	
	output reg ch0_mux1,
	
	output reg dat_esc_init,
	output reg dat_esc_zero,
	output reg dat_59,
	
	output reg dir_st2,
	output reg dir_com_cyt,
	output reg dir_seg,
	output reg dir_min,
	output reg dir_hora,
	output reg dir_dia,
	output reg dir_mes,
	output reg dir_anio,
	output reg dir_seg_tim,
	output reg dir_min_tim,
	output reg dir_hora_tim,
	
	output reg dir_tim_en,
	
	output reg buffer_activo
   );
	
	reg w_r;
	reg do_it;
	wire read_data;  // Bandera que indica que puede leer el dato.
	wire send_data; // Bandera que indica enviar el dato.
	wire send_add;	// Bandera que indica enviar dirección.
	
	FSM_W_R Inst0(
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
	
	/* Estados. */
	localparam est0 = 1'b0, est1 = 1'b1;
	
	reg est_sig;
	reg est_act;
	reg [9:0] contador;
	
	/* Lógica Secuencial */
	
	always @(posedge clk) begin
		if (est_act == est0) begin
			contador <= 10'b0000000000;
		end else	begin
			contador <= contador + 10'b0000000001;
		end
	end
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			est_act <= est0;
		end else begin
			if (contador == 560) begin
				est_act <= est0;
			end else begin
				est_act <= est_sig;
			end
		end
	end
	
	/* Lógica Combinacional */
	
	always @* begin
		est_sig = est0;
		case(est_act)
			est0: begin
				if (do_it_inic) begin
					est_sig = est1;
				end else begin
					est_sig = est0;
				end
			end
			est1: begin
				if (do_it_inic) begin
					est_sig = est1;
				end else begin
					est_sig = est0;
				end
			end
			default: est_sig = est0;
		endcase
	end
	
	/* Salidas */
	
	always @* begin
		if (est_act == est0) begin
			w_r = 1;
			ch0_mux1 = 0;
			buffer_activo = 0;
					
			do_it = 0;
			
			dat_esc_init = 0;
			dat_esc_zero = 0;
			
			dir_st2 = 0;
			dir_com_cyt = 0;
			dir_seg = 0;
			dir_min = 0;
			dir_hora = 0;
			dir_dia = 0;
			dir_mes = 0;
			dir_anio = 0;
			dir_seg_tim = 0;
			dir_min_tim = 0;
			dir_hora_tim = 0;
			dir_tim_en = 0;
			dat_59 = 0;
		end
		else if (est_act == est1) begin
			w_r = 1;
			ch0_mux1 = 1;
			buffer_activo = 0;
			
			do_it = 1;
			if (send_add && (~send_data) && (~read_data)) begin
				dat_esc_init = 0;
				dat_esc_zero = 0;
				dat_59 = 0;
				
				buffer_activo = 1;
				
				if (contador > 516) begin
					dir_com_cyt = 0;
					dir_st2 = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					dir_tim_en = 1;
				end else if (contador > 473) begin
					dir_com_cyt = 1;
					dir_st2 = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					dir_tim_en = 0;
				end else if (contador > 430) begin
					dir_com_cyt = 0;
					dir_st2 = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 1;
					dir_tim_en = 0;
				end else if (contador > 387) begin
					dir_com_cyt = 0;
					dir_st2 = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 1;
					dir_hora_tim = 0;
					dir_tim_en = 0;
				end else	if (contador > 344) begin
					dir_com_cyt = 0;
					dir_st2 = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 1;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					dir_tim_en = 0;
				end else	if (contador > 301) begin
					dir_com_cyt = 0;
					dir_st2 = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 1;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					dir_tim_en = 0;
				end else if (contador > 258) begin
					dir_com_cyt = 0;
					dir_st2 = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 1;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					dir_tim_en = 0;
				end else if (contador > 215) begin
					dir_com_cyt = 0;
					dir_st2 = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 1;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					dir_tim_en = 0;
				end else if (contador > 172) begin
					dir_com_cyt = 0;
					dir_st2 = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 1;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					dir_tim_en = 0;
				end else if (contador > 129) begin
					dir_com_cyt = 0;
					dir_st2 = 0;
					dir_seg = 0;
					dir_min = 1;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					dir_tim_en = 0;
				end else if (contador > 86) begin
					dir_com_cyt = 0;
					dir_st2 = 0;
					dir_seg = 1;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					dir_tim_en = 0;
				end else if (contador > 43) begin
					dir_com_cyt = 0;
					dir_st2 = 1;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					dir_tim_en = 0;
				end else begin
					dir_com_cyt = 0;
					dir_st2 = 1;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					dir_tim_en = 0;
				end
			end else if (send_data && (~send_add) && (~read_data)) begin
				dir_st2 = 0;
				dir_seg = 0;
				dir_min = 0;
				dir_dia = 0;
				dir_mes = 0;
				dir_anio = 0;
				dir_seg_tim = 0;
				dir_min_tim = 0;
				dir_hora_tim = 0;
				dir_tim_en = 0;
				
				buffer_activo = 1;
				if (contador > 516) begin
					dir_com_cyt = 0;
					
					dat_esc_init = 0;
					dat_esc_zero = 1;
					dir_hora = 0;
					dat_59 = 0;
				end else if (contador > 473) begin
					dir_com_cyt = 1;
					
					dat_esc_init = 0;
					dat_esc_zero = 0;
					dir_hora = 0;
					dat_59 = 0;
				end else if (contador > 430) begin
					dir_com_cyt = 0;
					
					dat_esc_init = 0;
					dat_esc_zero = 0;
					dir_hora = 1; // Para el timer se inicializa alrevés, para que no afecte la resta. 23 en hora.
					dat_59 = 0;
				end else if (contador > 387) begin
					dir_com_cyt = 0;
					
					dat_esc_init = 0;
					dat_esc_zero = 0;
					dir_hora = 0;
					dat_59 = 1; // 59 en min timer.
				end else if (contador > 344) begin
					dir_com_cyt = 0;
					
					dat_esc_init = 0;
					dat_esc_zero = 0;
					dir_hora = 0;
					dat_59 = 1; // 59 en seg timer.
				end else if(contador > 301) begin
					dir_com_cyt = 0;
					
					dat_esc_init = 0;
					dat_esc_zero = 1;
					dir_hora = 0;
					dat_59 = 0;
				end else if (contador > 258) begin
					dir_com_cyt = 0;
					
					dat_esc_init = 0;
					dat_esc_zero = 1;
					dir_hora = 0;
					dat_59 = 0;
				end else if (contador > 215) begin
					dir_com_cyt = 0;
					
					dat_esc_init = 0;
					dat_esc_zero = 1;
					dir_hora = 0;
					dat_59 = 0;
				end else if (contador > 172) begin
					dir_com_cyt = 0;
					
					dat_esc_init = 0;
					dat_esc_zero = 1;
					dir_hora = 0;
					dat_59 = 0;
				end else if (contador > 129) begin
					dir_com_cyt = 0;
					
					dat_esc_init = 0;
					dat_esc_zero = 1;
					dir_hora = 0;
					dat_59 = 0;
				end else if (contador > 86) begin
					dir_com_cyt = 0;
					
					dat_esc_init = 0;
					dat_esc_zero = 1;
					dir_hora = 0;
					dat_59 = 0;
				end else if (contador > 43) begin
					dir_com_cyt = 0;
					
					dat_esc_init = 0;
					dat_esc_zero = 1;
					dir_hora = 0;
					dat_59 = 0;
				end else begin
					dir_com_cyt = 0;
					
					dat_esc_init = 1;
					dat_esc_zero = 0;
					dir_hora = 0;
					dat_59 = 0;
				end
			end else begin
				buffer_activo = 0;
				
				dat_esc_init = 0;
				dat_esc_zero = 0;
				dat_59 = 0;
				
				dir_com_cyt = 0;
				dir_st2 = 0;
				dir_seg = 0;
				dir_min = 0;
				dir_hora = 0;
				dir_dia = 0;
				dir_mes = 0;
				dir_anio = 0;
				dir_seg_tim = 0;
				dir_min_tim = 0;
				dir_hora_tim = 0;
				dir_tim_en = 0;
			end
		end else begin
			w_r = 1;
			ch0_mux1 = 0;
			buffer_activo = 0;
			
			do_it = 0;
			
			dat_esc_init = 0;
			dat_esc_zero = 0;
			
			dir_com_cyt = 0;
			dir_st2 = 0;
			dir_seg = 0;
			dir_min = 0;
			dir_hora = 0;
			dir_dia = 0;
			dir_mes = 0;
			dir_anio = 0;
			dir_seg_tim = 0;
			dir_min_tim = 0;
			dir_hora_tim = 0;
			dat_59 = 0;
			dir_tim_en = 0;
		end
	end
	
endmodule