;******************************************************************************
; Proyecto:	P0102
; Created:	11/07/2019 12:19:41 p. m.
; Author :	Sergio F Hernández Machuca
;******************************************************************************
;	Revisar en:
; Tools -> Device Programming -> [Simulador] - [Atmega328P] -> Apply
; - Verificar toda la información que se encuentra ahí [¿Preguntas?]
;------------------------------------------------------------------------------
; Depurar el código, una vez que no contiene errores.
; Debug -> 
; ... Ajustes de ventanas a observar
; ... Revisión de ejecución del código, instrucción por instrucción
; ... Memory - iRAM - "Processor Status" - Memory "data REGISTERS"
;------------------------------------------------------------------------------
; Propuesta del código a ensayar:
;
; DDRB   = Selecciona la DIRECCIÓN de la información [0 = Entrada, 1 = Salida]
; PORTB = Registro para Escritura a PORTB
; PINB  = Registro para Lectura de PORTB
;
;------------------------------------------------------------------------------
;-----[ DEFINICIONES de CONSTANTES y VARIABLES ]-----
.DEF Temp1 = r17			; Variables TEMPORALES. Verificar los Rx más adecuados.
.DEF Temp2 = r18			;
.DEF Temp3 = r19			;
.DEF datoa = r20			; Para alojar DATOS
.DEF byte = r21				; Para algún tipo de conversión.
;------------------------------------------------------------------------------
;-----[ ETIQUETAS ]-----
.EQU INPUT = 0x00			;	Todas las terminales son ENTRADAS
.EQU ENTRADAS = 0x00	; Sinónimo
.EQU OUTPUT = 0xFF		; Todas las terminales son SALIDAS
.EQU SALIDAS = 0xFF		; Sinónimo
;------------------------------------------------------------------------------
;.include <m328def.inc>		; NO se INCLUYE, ya lo hace el Proyecto mismo

.ORG 0x0000
;-----[ VECTORES de ATENCIÓN a INTERRUPCIONES ]-----
	rjmp RESET				; Manejador de la señal genérica de RESET.
	rjmp EXT_INT0			; IRQ0 Handler
	rjmp EXT_INT1			; IRQ1 Handler
	rjmp PC_INT0			; PCINT0 Handler
	rjmp PC_INT1			; PCINT1 Handler
	rjmp PC_INT2			; PCINT2 Handler
	rjmp WDT					; Watchdog Timer Handler
	rjmp TIM2_COMPA		; Timer2 Compare A Handler
	rjmp TIM2_COMPB		; Timer2 Compare B Handler
	rjmp TIM2_OVF			; Timer2 Overflow Handler
	rjmp TIM1_CAPT		; Timer1 Capture Handler
	rjmp TIM1_COMPA		; Timer1 Compare A Handler
	rjmp TIM1_COMPB		; Timer1 Compare B Handler
	rjmp TIM1_OVF			; Timer1 Overflow Handler
	rjmp TIM0_COMPA		; Timer0 Compare A Handler
	rjmp TIM0_COMPB		; Timer0 Compare B Handler
	rjmp TIM0_OVF			; Timer0 Overflow Handler
	rjmp SPI_STC			; SPI Transfer Complete Handler
	rjmp USART_RXC		; USART, RX Complete Handler
	rjmp USART_UDRE		; USART, UDR Empty Handler
	rjmp USART_TXC		; USART, TX Complete Handler
	rjmp ADC_RDY			; ADC Conversion Complete Handler
	rjmp EE_RDY				; EEPROM Ready Handler
	rjmp ANA_COMP			; Analog Comparator Handler
	rjmp TWI					; 2-wire Serial Interface Handler
	rjmp SPM_RDY			; Store Program Memory Ready Handler
;------------------------------------------------------------------------------
;-----[ ATENCIÓN a INTERRUPCIONES (si se habilitó su atención)]-----
;------------------------------------------------------------------------------
EXT_INT0:
	reti
EXT_INT1:
	reti
PC_INT0:
	reti
PC_INT1:
	reti
PC_INT2:
	reti
WDT:
	reti
TIM2_COMPA:
	reti
TIM2_COMPB:
	reti
TIM2_OVF:
	reti 
TIM1_CAPT:
	reti
TIM1_COMPA:
	reti
TIM1_COMPB:
	reti
TIM1_OVF:
	reti
TIM0_COMPA:
	reti
TIM0_COMPB:
	reti
TIM0_OVF:
	reti
SPI_STC:
	reti
USART_RXC:
	reti
USART_UDRE:
	reti
USART_TXC:
	reti
ADC_RDY:
	reti
EE_RDY:
	reti
ANA_COMP:
	reti
TWI:
	reti
SPM_RDY:
	reti

Aqui_para_Siempre:
	rjmp Aqui_para_Siempre
;------------------------------------------------------------------------------
;-----[ VECTOR de RESET ]-----
;------------------------------------------------------------------------------
; Aquí se inicia la ejecución de las aplicaciones, después de aplicar energía;
; pulsar el interruptor de "RESET", desbordamiento del WDT.
RESET:
	ldi r16, high(RAMEND)		; Inicio del Programa Principal
	out SPH,r16							; Ajuste del Apuntador de Stack al final de RAM
	ldi r16, low(RAMEND)		;
	out SPL,r16							;
	sei											; Habilita interrupciones
;------------------------------------------------------------------------------
; -----[ AJUSTES PRINCIPALES ]-----
;------------------------------------------------------------------------------
	ldi temp1,0xFF					; Ajuste de terminales de PORTB como SALIDAS
	out DDRB,temp1					;
;********************************************
; -----[ CICLO PRINCIPAL ]-----
;********************************************
Ciclo:
	call delayXms						; Retardo en tiempo (calcular con herramienta)
	sbi PORTB,0							; El bit "0" de PORTB puesto a "1"
	call delayXms						; Retardso de tiempo (verificar)
	cbi PORTB,0							; El bit "0" de PORTB puesto a "0"

	rjmp Ciclo							; ...repetir...
;******************************************************************************
;------------------------------------------------------------------------------
;Rutinas de Retardo de 5ms
;------------------------------------------------------------------------------
; hacer un llamado tarda 5 ciclos
delayYms:
	ldi Temp1, 66		;para 8mhz ; 1 ciclo
LOOP0:
	ldi temp2, 200	; 1 ciclo
LOOP1:
	dec temp2				; 1 ciclo
	brne LOOP1			; 1 si es falso 2 si es verdadero
	dec Temp1				; 1
	brne LOOP0			; 2
	ret
;------------------------------------------------------------------------------
;Rutinas de Retardo de 500ms
;------------------------------------------------------------------------------
delayXms:
	ldi temp3,5			; ¿para 8mhz?
LazoXms:
	call delayYms
	dec temp3
	brne LazoXms
	ret
;------------------------------------------------------------------------------
;******************************************************************************