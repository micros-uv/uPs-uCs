;******************************************************************************
; Ensayos de instrucciones para uCs AVR - ATmega328P
; Sergio Fco. Hernández Machuca
;;*****************************************************************************
; Segmentos de código para ensayar instrucciones del uP
; En cada caso agrgegue los comentarios adecuados.
;==============================================================================
; Ejercite el siguiente segmento de código:

.ORG		0x000				; Localidad en donde se ensambla el código que sigue

	jmp		DeNuevo			; Salta a la etiqueta que está aquí como operando

DeNuevo:	
	in		R16,PINB		;	R16 <- [PORTB]
	out		PORTC,R16		;	[PORTC] <- R16
	jmp		DeNuevo			; ...continúa en lo mismo...
;==============================================================================
; Ahora este.

;.ORG		0x000				;
Segundo:
	ldi	R20,0x55			;
	out	PORTB, R20		;
L1:	
	com	R20						;
	out	PORTB, R20		;
	jmp	L1						;
;==============================================================================
; Establezca cómo queda al final del segmento el registro R20.
; Modifique el código para que ahora quede 0xBE en el registro R20

;.ORG		0x000				;
Tercero:
	ldi	R20, 4				;
	dec	R20						;
	dec	R20						;
	dec	R20						;
	dec	R20						;
L2:		
	rjmp	L2					; ¿Cuál es la ventaja de esta instrucción en realción a
										; la anteriormente usada ("jmp")?
;==============================================================================
; Verifique la siguiente suma.
; Agregue el uso del "Carry".
; Haga ejemplos en donde la bandera de "Carry" se ponga a "0" y a "1".

;.ORG		0x000				;
Cuarto:
	ldi	R16,0x38			;
	ldi	R17,0x2F			;
	add	R16,R17				;
L3:
	rjmp	L3					;
;==============================================================================
; Utiliza alguna instrucción distinta a "ldi" en el siguiente segmento y
; realiza una suma parecida

;.ORG		0x000
Quinto:
	ldi	R20, 0x9C			;
	ldi	R21, 0x64			;
	add	R20, R21			;
L4:
	rjmp	L4					;
;==============================================================================
; verifica qué realiza lo que continúa.
; Emplea el simulador de Atmel Studio.

;.ORG			0x000			;
Sexto:
	ldi	R20,0x88			;
	ldi	R21,0x93			;
	add	R20,R21				;
L5:
	rjmp	L5					;

;==============================================================================
; Ensayo de un programa completo
; Crea un proyecto con tu nombre, agrégale el siguiente segmento de código.
; Simula la ejecución y muestra resultados.

.EQU	SUMA	= 0x300	

;.ORG 00										;
	ldi		R16, 0x25						;
	ldi		R17, $34						;
	ldi		R18, 0b00110001			;
	add		R16, R17						;
	add		R16, R18						;
	ldi		R17, 11							;
	add		R16, R17						;
	sts		SUMA, R16						;
PorAca:
	JMP	PorAca
;==============================================================================