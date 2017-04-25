`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:47:28
// Design Name: 
// Module Name: Generador_texto
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


module Generador_texto(
	//ENTRADAS
	input wire clk,
	input wire [7:0] digit_DD, digit_M, digit_AN, digit_HORA, digit_MIN, digit_SEG, digit_TimerHORA, digit_TimerMIN, digit_TimerSEG,
	input wire [8:0] bandera_cursor, //banderas para activar lo que se desea cambiar
	input wire [9:0] pixel_x, pixel_y, // Coordenadas del escáner del VGA.
	input wire Alarma_on,
	
	//SALIDAS
	output reg [11:0] rgb_text // Salida para controlar color en VGA.
   );
	
	// Declaración de señales, base. Para el momento de impresion
   wire [10:0] rom_addr;
   reg [6:0] char_addr;
   reg [3:0] row_addr;
   reg [2:0] bit_addr;
   wire [7:0] font_word;
   wire font_bit;
	
	//Declaración de señales de variables a mostrar
   reg [6:0] char_addr_FECHA, char_addr_NumFECHA, char_addr_HORA, char_addr_NumHORA, char_addr_ForMili, char_addr_TIMER, char_addr_NumTIMER, char_addr_SIMBOLO, char_addr_Fordoce;
   wire [3:0] row_addr_FECHA, row_addr_NumFECHA, row_addr_HORA, row_addr_NumHORA, row_addr_ForMili, row_addr_TIMER, row_addr_NumTIMER, row_addr_SIMBOLO, row_addr_Fordoce; //fila (y)
   wire [2:0] bit_addr_FECHA, bit_addr_NumFECHA, bit_addr_HORA, bit_addr_NumHORA, bit_addr_ForMili, bit_addr_TIMER, bit_addr_NumTIMER, bit_addr_SIMBOLO, bit_addr_Fordoce; //bit (x)
   wire FECHA_on, NumFECHA_on, HORA_on, NumHORA_on, ForMili_on, TIMER_on, NumTIMER_on, SIMBOLO_on, Fordoce_on; //establecera valor booleano como indicador que se pintara palabra FECHA
   reg [6:0] char_addr_FECHA_reg;
	
	//Instanciar FONT ROM
	font_rom font_unit
      (.clk(clk), .addr(rom_addr), .data(font_word));
	
	
	//VARIABLES PARA CADA NUMERO QUE SE VAN A DIVIDIR DE UN NUMERO MAYOR
	wire [3:0] digitDec_DD, digitUni_DD, digitDec_M, digitUni_M, digitDec_AN, digitUni_AN,
	digitDec_HORA, digitUni_HORA, digitDec_MIN, digitUni_MIN, digitDec_SEG, digitUni_SEG,
	digitDec_TimerHORA, digitUni_TimerHORA, digitDec_TimerMIN, digitUni_TimerMIN, digitDec_TimerSEG, digitUni_TimerSEG;
	
	
	
	//PARA REALIZAR PRUEBA
	//HACER UN DIVISOR DE FRECUENCIA DE 25MHz A APROX
	reg [24:0] cont = 0;
	wire CLK1Hz;
	
	always @ (posedge clk) begin
		if (cont == 25000000) begin
			cont <= 0;
		end
		else begin
			cont <= cont + 1'b1;
		end
	end
	assign CLK1Hz = cont[24];

	
	//FECHA
	assign digitDec_DD = digit_DD[7:4];
	assign digitUni_DD = digit_DD[3:0];
	assign digitDec_M  = digit_M[7:4];
	assign digitUni_M  = digit_M[3:0];
	assign digitDec_AN = digit_AN[7:4];
	assign digitUni_AN = digit_AN[3:0];
	
	//HORA
	assign digitDec_HORA = digit_HORA[7:4];
	assign digitUni_HORA = digit_HORA[3:0];
	assign digitDec_MIN  = digit_MIN[7:4];
	assign digitUni_MIN  = digit_MIN[3:0];
	assign digitDec_SEG  = digit_SEG[7:4];
	assign digitUni_SEG  = digit_SEG[3:0];
	
	//TIMER
	assign digitDec_TimerHORA = digit_TimerHORA[7:4];
	assign digitUni_TimerHORA = digit_TimerHORA[3:0];
	assign digitDec_TimerMIN  = digit_TimerMIN[7:4];
	assign digitUni_TimerMIN  = digit_TimerMIN[3:0];
	assign digitDec_TimerSEG  = digit_TimerSEG[7:4];
	assign digitUni_TimerSEG  = digit_TimerSEG[3:0];
	
	
	//VALORES DE LIMITES DE LOS CUADROS QUE ENCERRARAN LOS NUMEROS
            //Limites para caja de fecha
            
    localparam Caja_FECHA_XI = 180; //limite izquierdo de la caja
    localparam Caja_FECHA_XD = 459; //limite derecho de la caja
    localparam Caja_FECHA_YA = 62; //Limite superior de la caja
    localparam Caja_FECHA_YD = 129; //limite inferior de la caja
    
    assign Caja_FECHA_on = (pixel_x>=Caja_FECHA_XI)&&(pixel_x<=Caja_FECHA_XD)&&(pixel_y>=Caja_FECHA_YA)&&(pixel_y<=Caja_FECHA_YD); 
	
	
	//1. Definir el espacio y las letras correspondientes a la palabra FECHA 16x32
	assign FECHA_on = ((pixel_y[9:5]==1) && (pixel_x[9:4]>=18) && (pixel_x[9:4]<=22)); //Me difine el tamaño y=2^5 y x=2^5
	assign row_addr_FECHA = pixel_y[4:1]; //me define el tamaño de la letra
	assign bit_addr_FECHA = pixel_x[3:1]; //me define el tamaño de la letra
	
	always @* 
		case(pixel_x[6:4]) //para este caso cada 2^4 bits se pinta nueva letra
							  //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en FECHA_on
			4'h2: char_addr_FECHA = 7'h46; //F
			4'h3: char_addr_FECHA = 7'h45; //E
			4'h4: char_addr_FECHA = 7'h43; //C
			4'h5: char_addr_FECHA = 7'h48; //H
			4'h6: char_addr_FECHA = 7'h41; //A
			default: char_addr_FECHA = 7'h20;//Espacio en blanco
		endcase

	//2. Mostrar digitos de la fecha 64x32
	assign NumFECHA_on = (pixel_y[9:5]<=3) && (pixel_y[9:5]>=2) && (pixel_x[9:6]>=3) && (pixel_x[9:6]<=6); //coordenadas donde se pintara los digitos
	assign row_addr_NumFECHA = pixel_y[5:2]; //tamaño de la letra 
	assign bit_addr_NumFECHA = pixel_x[4:2]; //tamaño de la letra

	always@*
	begin
		case(pixel_x[7:5]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en NumFECHA_on
			3'h6: char_addr_NumFECHA = {3'b011, digitDec_DD};//(decenas dia)  
			3'h7: char_addr_NumFECHA = {3'b011, digitUni_DD};//(unidades dia) 
			3'h0: char_addr_NumFECHA = 7'h2f;// /
			3'h1: char_addr_NumFECHA = {3'b011, digitDec_M};//(decenas Mes)
			3'h2: char_addr_NumFECHA = {3'b011, digitUni_M};//(unidades mes)
			3'h3: char_addr_NumFECHA = 7'h2f;// /
			3'h4: char_addr_NumFECHA = {3'b011, digitDec_AN};//(unidad de millar año)
			3'h5: char_addr_NumFECHA = {3'b011, digitUni_AN};//(Centenas año)
			default: char_addr_NumFECHA = 7'h00;//Espacio en blanco
		endcase	
	end
	
	//3. Mostrar Palabra HORA
	assign HORA_on = ((pixel_y[9:5]==6) && (pixel_x[9:5]>=2) && (pixel_x[9:5]<=3)); //Me difine el tamaño y=2^5 y x=2^5
	assign row_addr_HORA = pixel_y[4:1]; //pix_y[5:1] //me define el tamaño de la letra
	assign bit_addr_HORA = pixel_x[3:1]; //pix_x[4:1]//me define el tamaño de la letra
	
	always @* 
	begin
		case(pixel_x[5:4]) //para este caso cada 2^4 bits se pinta nueva letra
							  //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en HORA_on
			2'h0: char_addr_HORA = 7'h48; //H
			2'h1: char_addr_HORA = 7'h4f; //O
			2'h2: char_addr_HORA = 7'h52; //R
			2'h3: char_addr_HORA = 7'h41; //A
			default: char_addr_HORA = 7'h00;//Espacio en blanco
			
		endcase
	end
	
	//4. Mostrar Palabra 24H y 12H
	//Crear posteriormente con una variable AM/PM, para seleccionar si se esta en AM/PM, usandolo un case,
	//en este caso, posiblemente con un switch
	assign ForMili_on = ((pixel_y[9:5]==7) && (pixel_x[9:5]>=9) && (pixel_x[9:5]<=10)); //Me difine el tamaño y=2^5 y x=2^5
	assign row_addr_ForMili = pixel_y[4:1]; // pix_y[5:1]//me define el tamaño de la letra
	assign bit_addr_ForMili = pixel_x[3:1]; // pix_x[4:1]//me define el tamaño de la letra
	
	always @* 
	begin
		case(pixel_x[5:4]) //para este caso cada 2^4 bits se pinta nueva letra
							  //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en AMPM_on
			2'h2: char_addr_ForMili = 7'h32; //2
			2'h3: char_addr_ForMili = 7'h34; //4 
			2'h0: char_addr_ForMili = 7'h00; //espacio en blanco
			2'h1: char_addr_ForMili = 7'h48; //H
			
			
		endcase
	end
	
	
	assign Fordoce_on = ((pixel_y[9:5]==8) && (pixel_x[9:5]>=9) && (pixel_x[9:5]<=10)); //Me difine el tamaño y=2^5 y x=2^5
        assign row_addr_Fordoce = pixel_y[4:1]; // pix_y[5:1]//me define el tamaño de la letra
        assign bit_addr_Fordoce = pixel_x[3:1]; // pix_x[4:1]//me define el tamaño de la letra
        
        always @* 
        begin
            case(pixel_x[5:4]) //para este caso cada 2^4 bits se pinta nueva letra
                                  //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en AMPM_on
                2'h2: char_addr_Fordoce = 7'h31; //1
                2'h3: char_addr_Fordoce = 7'h32; //2 
                2'h0: char_addr_Fordoce = 7'h00; //espacio en blanco
                2'h1: char_addr_Fordoce = 7'h48; //H
                
                
            endcase
        end
	

	//5. Mostrar digitos de la Hora
	assign NumHORA_on = (pixel_y[9:5]==7) && (pixel_x[9:5]>=4) && (pixel_x[9:5]<=7);
	assign row_addr_NumHORA = pixel_y[4:1];
	assign bit_addr_NumHORA = pixel_x[3:1];

	always@*
	begin
		case(pixel_x[6:4]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en NumHORA_on
			3'h0: char_addr_NumHORA = {3'b011, digitDec_HORA};//(decenas dia)
			3'h1: char_addr_NumHORA = {3'b011, digitUni_HORA};//(unidades dia)
			3'h2: char_addr_NumHORA = 7'h3a;// /
			3'h3: char_addr_NumHORA = {3'b011, digitDec_MIN};//(decenas Mes)
			3'h4: char_addr_NumHORA = {3'b011, digitUni_MIN};//(unidades mes)
			3'h5: char_addr_NumHORA = 7'h3a;// /
			3'h6: char_addr_NumHORA = {3'b011, digitDec_SEG};//(unidad de millar año)
			3'h7: char_addr_NumHORA = {3'b011, digitUni_SEG};//(Centenas año)
			default: char_addr_NumHORA = 7'h00;//Espacio en blanco
		endcase	
	end
	
	//6. Mostrar Palabra TIMER
	assign TIMER_on = ((pixel_y[9:5]==10) && (pixel_x[9:5]>=2) && (pixel_x[9:5]<=4)); //Me difine el tamaño y=2^5 y x=2^5
	assign row_addr_TIMER = pixel_y[4:1]; //pix_y[5:1]//me define el tamaño de la letra
	assign bit_addr_TIMER = pixel_x[3:1]; //pix_x[4:1]//me define el tamaño de la letra
	
	always @* 
	begin
		case(pixel_x[6:4]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en TIMER_on
			3'h4: char_addr_TIMER = 7'h54; //T
			3'h5: char_addr_TIMER = 7'h49; //I
			3'h6: char_addr_TIMER = 7'h4d; //M
			3'h7: char_addr_TIMER = 7'h45; //E
			3'h0: char_addr_TIMER = 7'h52; //R
			default: char_addr_TIMER = 7'h00;//Espacio en blanco
			
		endcase
	end
	
	//7. Mostrar digitos del Timer
	assign NumTIMER_on = (pixel_y[9:5]==11) && (pixel_x[9:5]>=4) && (pixel_x[9:5]<=7);
	assign row_addr_NumTIMER = pixel_y[4:1];
	assign bit_addr_NumTIMER = pixel_x[3:1];

	always@*
	begin
		case(pixel_x[6:4]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en NumTIMER_on
			3'h0: char_addr_NumTIMER = {3'b011, digitDec_TimerHORA};//(decenas dia)
			3'h1: char_addr_NumTIMER = {3'b011, digitUni_TimerHORA};//(unidades dia)
			3'h2: char_addr_NumTIMER = 7'h3a;// /
			3'h3: char_addr_NumTIMER = {3'b011, digitDec_TimerMIN};//(decenas Mes)
			3'h4: char_addr_NumTIMER = {3'b011, digitUni_TimerMIN};//(unidades mes)
			3'h5: char_addr_NumTIMER = 7'h3a;// /
			3'h6: char_addr_NumTIMER = {3'b011, digitDec_TimerSEG};//(decenas año)
			3'h7: char_addr_NumTIMER = {3'b011, digitUni_TimerSEG};//(unidades año)
			default: char_addr_NumTIMER = 7'h00;//Espacio en blanco
		endcase	
	end

	//8. Mostrar Simbolo para la alarma
	assign SIMBOLO_on = (pixel_y[9:5]<=9) && (pixel_y[9:5]>=8) && (pixel_x[9:5]>=13) && (pixel_x[9:6]<=18);
    assign row_addr_SIMBOLO = pixel_y[5:2]; //pix_y[5:1]
    assign bit_addr_SIMBOLO = pixel_x[4:2]; //pix_x[4:1]

    always@*
    begin
        case(pixel_x[9:5]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en SIMBOLO_on
            5'd13: char_addr_SIMBOLO = 7'h52; //R
            5'd14: char_addr_SIMBOLO = 7'h49; //I
            5'd15: char_addr_SIMBOLO = 7'h4e; //N
            5'd16: char_addr_SIMBOLO = 7'h47; //G
            5'd18: char_addr_SIMBOLO = 7'h13; //simbolo de signos de admiracion
            default: char_addr_SIMBOLO = 7'h00;//Espacio en blanco
        endcase    
    end              
	
	assign rom_addr = {char_addr, row_addr};
    assign font_bit = font_word[~bit_addr];
   
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
   
	
	//Mostrar en pantalla las letras con los colores definidos
	//Multiplexar las direcciones del font ROM con salida RBG
	always @(posedge clk) begin
		
		rgb_text = 12'h000;

          
        ////////////////////////////////////////////////////////////////////
		if (FECHA_on) //palabra FECHA
		begin
			char_addr = char_addr_FECHA;
			row_addr = row_addr_FECHA;
			bit_addr = bit_addr_FECHA;
				if (font_bit) begin
					rgb_text = 12'hF60; //naranja
				end
				else if(~font_bit) rgb_text = 12'h360; //Mismo color que el fondo
		end
		

          
        ////////////////////////////////////////////////////////////////////
		else if(NumFECHA_on) //Digitos de la fecha
		begin
			char_addr = char_addr_NumFECHA;
			row_addr = row_addr_NumFECHA;
			bit_addr = bit_addr_NumFECHA;
			//Evalúa que se está configurando (0: modo normal, 1: config.hora, 2: config.fecha, 4: config.timer)
				if (font_bit) begin
					rgb_text = 12'hFFF; //blanco
				end
				else if ((font_bit)&&/*(switch_cursor == 1)&&*/(pixel_y[9:5]<=3) && (pixel_y[9:5]>=2) &&(pixel_x[9:5]>=6)&&(pixel_x[9:5]<8)&&(bandera_cursor[8]==1)) //DIA QUITE UN = EN SEGUNDO X
					rgb_text = 12'h000;//Hace numero color Amarillo
				else if ((font_bit)&&/*(switch_cursor == 1)&&*/(pixel_y[9:5]<=3) && (pixel_y[9:5]>=2) &&(pixel_x[9:5]>=9)&&(pixel_x[9:5]<11)&&(bandera_cursor[7]==1))   //MES  QUITE UN = EN SEGUNDO X
					rgb_text = 12'h000;//Hace numero color Amarillo
				else if ((font_bit)&&/*(switch_cursor == 1)&&*/(pixel_y[9:5]<=3) && (pixel_y[9:5]>=2) &&(pixel_x[9:5]>=12)&&(pixel_x[9:5]<14)&&(bandera_cursor[6]==1))  //AÑO  QUITE UN = EN SEGUNDO X
					rgb_text = 12'h000;//Hace numero color Amarillo
				else if(~font_bit) rgb_text = 12'h360; //Mismo color que el fondo	
		end
		

          
        ////////////////////////////////////////////////////////////////////
		else if (HORA_on)  //Palabra HORA
		begin
			char_addr = char_addr_HORA;
			row_addr = row_addr_HORA;
			bit_addr = bit_addr_HORA;
				if (font_bit) begin
					rgb_text = 12'hF60; //naranja
				end
				else if(~font_bit) rgb_text = 12'h360; //Mismo color que el fondo
		end
		
          
        ////////////////////////////////////////////////////////////////////

		else if (NumHORA_on)  //Digitos de la HORA
		begin
			char_addr = char_addr_NumHORA;
			row_addr = row_addr_NumHORA;
			bit_addr = bit_addr_NumHORA;
			//Evalúa que se está configurando (0: modo normal, 1: config.hora, 2: config.fecha, 4: config.timer)
				if (font_bit) begin
					rgb_text = 12'hFFF; //blanco
				end
				else if ((~font_bit)&&/*(switch_cursor == 2)&&*/(pixel_y[9:5]==7)&&(pixel_x[9:4]>=8)&&(pixel_x[9:4]<10)&&(bandera_cursor[5]==1)) //HORA QUITE UN = EN SEGUNDO X
					rgb_text = 12'hFF0;//Hace numero color Amarillo
				else if ((~font_bit)&&/*(switch_cursor == 2)&&*/(pixel_y[9:5]==7)&&(pixel_x[9:4]>=11)&&(pixel_x[9:4]<13)&&(bandera_cursor[4]==1))   //MINUTO  QUITE UN = EN SEGUNDO X
					rgb_text = 12'hFF0;//Hace numero color Amarillo
				else if ((~font_bit)&&/*(switch_cursor == 2)&&*/(pixel_y[9:5]==7)&&(pixel_x[9:4]>=14)&&(pixel_x[9:4]<16)&&(bandera_cursor[3]==1))  //SEGUNDO  QUITE UN = EN SEGUNDO X
					rgb_text = 12'hFF0;//Hace numero color Amarillo
			   else if(~font_bit) rgb_text = 12'h360; //Mismo color que el fondo
		end
		

          
        ////////////////////////////////////////////////////////////////////
		else if (ForMili_on) //Palabra 24H. Posteriormente se hará cambio
		begin
			char_addr = char_addr_ForMili;
			row_addr = row_addr_ForMili;
			bit_addr = bit_addr_ForMili;
				if (font_bit) begin
					rgb_text = 12'hFF0; //Amarillo
				end
				else if(~font_bit) rgb_text = 12'h360; //Mismo color que el fondo
		end
		
		
		else if (Fordoce_on) //Palabra 24H. Posteriormente se hará cambio
                begin
                    char_addr = char_addr_Fordoce;
                    row_addr = row_addr_Fordoce;
                    bit_addr = bit_addr_Fordoce;
                        if (font_bit) begin
                            rgb_text = 12'hFF0; //Amarillo
                        end
                        else if(~font_bit) rgb_text = 12'h360; //Mismo color que el fondo
                end
		
          
        ////////////////////////////////////////////////////////////////////

		else if (TIMER_on) //Palabra TIMER
		begin
			char_addr = char_addr_TIMER;
			row_addr = row_addr_TIMER;
			bit_addr = bit_addr_TIMER;
				if (font_bit) begin
					rgb_text = 12'hF60; //naranja
				end
				else if(~font_bit) rgb_text = 12'h360; //Mismo color que el fondo
		end
		

          
        ////////////////////////////////////////////////////////////////////
		else if (NumTIMER_on)  //Digitos del Timer
		begin
			char_addr = char_addr_NumTIMER;
			row_addr = row_addr_NumTIMER;
			bit_addr = bit_addr_NumTIMER;
			//Evalúa que se está configurando (0: modo normal, 1: config.hora, 2: config.fecha, 4: config.timer)
				if (font_bit) begin
					rgb_text = 12'hFFF;  //blanco
				end
				else if ((~font_bit)&&/*(switch_cursor == 4)&&*/(pixel_y[9:5]==11)&&(pixel_x[9:4]>=8 )&&(pixel_x[9:4]<10)&&(bandera_cursor[2]==1)) //HORA QUITE UN = EN SEGUNDO X
					rgb_text = 12'hFF0;//Hace numero color Amarillo
				else if ((~font_bit)&&/*(switch_cursor == 4)&&*/(pixel_y[9:5]==11)&&(pixel_x[9:4]>=11)&&(pixel_x[9:4]<13)&&(bandera_cursor[1]==1))   //MINUTO  QUITE UN = EN SEGUNDO X
					rgb_text = 12'hFF0;//Hace numero color Amarillo
				else if ((~font_bit)&&/*(switch_cursor == 4)&&*/(pixel_y[9:5]==11)&&(pixel_x[9:4]>=14)&&(pixel_x[9:4]<16)&&(bandera_cursor[0]==1))  //SEGUNDO  QUITE UN = EN SEGUNDO X
					rgb_text = 12'hFF0;//Hace numero color Amarillo
			    else if(~font_bit) rgb_text = 12'h360; //Mismo color que el fondo
		end
		

          
        ////////////////////////////////////////////////////////////////////
		else if (SIMBOLO_on) //Impresion del Simbolo
		begin
			char_addr = char_addr_SIMBOLO;
			row_addr = row_addr_SIMBOLO;
			bit_addr = bit_addr_SIMBOLO;
				if (font_bit) begin
					if (Alarma_on==1 && CLK1Hz==1)
						rgb_text = 12'hFFF; //Blanco
					else
					rgb_text = 12'h360;   //Mismo color que el fondo
				end
				else if(~font_bit) rgb_text = 12'h360; //Mismo color que el fondo
		end
		
		////////////////////////////////////////////////////////////////////
        //PARA IMPRIMIR LAS CAJAS
        else if (Caja_FECHA_on)
        begin
            rgb_text = 12'hFF0;//Amarillo
        end
		
        ////////////////////////////////////////////////////////////////////
		else begin
			rgb_text = 12'h360; //Fondo verde musgo
		end
	end
	
endmodule
