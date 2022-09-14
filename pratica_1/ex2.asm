; 20h.0 = 0 -> FREQ = 1 HZ
; 20h.0 = 1 -> FREQ = 4 HZ

	ORG 0
	SJMP PROG

	ORG 0003H
	CLR EA
	CPL 20h.0
	SETB EA
	RETI


PROG: 			; Início do Programa Principal
	SETB EA 	; Habilita o uso de Interrupções
	SETB IE.0 	; Habilita a Interrupção Externa 0
	SETB IT0 	; Sensível a descida de borda
	CLR  20h.0 	; Começa piscar em 1Hz
LOOP:	
	CPL P0.0
	JB 20h.0, CALL4HZ
	ACALL DELAY_1HZ
	SJMP LOOP 
CALL4HZ: 
	ACALL DELAY_4HZ
	SJMP LOOP


; START: Wait loop, time: 1 s
; Clock: 11059.2 kHz (12 / MC)
; Used registers: R0, R1, R2, R3
DELAY_1HZ:
	CLR EA
	MOV	R3, #002h
	MOV	R2, #0ADh
	MOV	R1, #007h
	MOV	R0, #0BCh
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	DJNZ	R2, $-9
	DJNZ	R3, $-13
	MOV	R0, #061h
	DJNZ	R0, $
	NOP
	SETB EA
	RET
; Rest: -1085.069 ns
; END: Wait loop


; START: Wait loop, time: 0.25 s
; Clock: 11059.2 kHz (12 / MC)
; Used registers: R0, R1, R2
DELAY_4HZ:
	CLR EA
	MOV	R2, #01Ah
	MOV	R1, #0B1h
	MOV	R0, #017h
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	DJNZ	R2, $-9
	MOV	R0, #06Eh
	DJNZ	R0, $
	NOP
	SETB EA
	RET
; Rest: -1085.069 ns
; END: Wait loop
	END