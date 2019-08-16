;******************************************************************************
; P0101.asm
; Created: 11/07/2019 12:19:41 p. m.
; Author : Sergio F Hern�ndez Machuca
;******************************************************************************
;	Revisar en:
; Tools -> Device Programming -> [Simulador] - [Atmega328P] -> Apply
; - Verificar toda la informaci�n que se encuentra ah� [�Preguntas?]
;------------------------------------------------------------------------------
; Depurar el c�digo, una vez que no contiene errores.
; Debug -> 
; ... Ajustes de ventanas a observar
; ... Revisi�n de ejecuci�n del c�digo, instrucci�n por instrucci�n
; ... Memory - iRAM - "Processor Status" - Memory "data REGISTERS"
;------------------------------------------------------------------------------
; Propuesta del c�digo a ensayar:
;
start:
	ldi R16, 0x57		; R16 <- 0x57
	sts 0x100, R16	; [0x100] <- R16, lo que es igual a: [0x100] <- 0x99
	ldi R17, 0x58		; R17 <- 0x58 (se pierde el anterior valor de R16)
	sts 0x101, R17	;	[0x93] <- R16
	ldi R18, 0x59		; R17 <- 0x3F
	sts 0x102, R18	; [0x94] <- R17
	ldi R19, 0x60		;
	sts 0x103, R19	;
	ldi R20, 0x61		;
	sts 0x104, R20	;
Aqui: 
	rjmp Aqui
;******************************************************************************