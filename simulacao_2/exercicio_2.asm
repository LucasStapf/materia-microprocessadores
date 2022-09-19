; ******************************* ;
; Lucas Carvalho Freiberger Stapf
; NUSP 11800559
; ******************************* ;

	ORG	0
LED1:	JB	P3.5,LED2
	CPL	P1.0
LED2:	JB	P3.6,LED3
	CPL	P1.1
LED3:	JB	P3.7,DLY_1HZ
	CPL	P1.2
	CPL	P1.0
DLY_1Hz:
	MOV	R2, #00Eh
	MOV	R1, #089h
	MOV	R0, #0EEh
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	DJNZ	R2, $-9
	MOV	R1, #002h
	MOV	R0, #0DEh
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	NOP
	NOP
	NOP
	NOP
	SJMP	LED1
	END