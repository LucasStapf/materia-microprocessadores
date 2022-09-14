	ORG 0
	SETB P0.0
	CLR P0.1
LOOP:
	CPL P0.0
	CPL P0.1
	ACALL DELAY
	SJMP LOOP

; START: Wait loop, time: 100 ms
; Clock: 11059.2 kHz (12 / MC)
; Used registers: R1, R2, R3
DELAY:
	MOV R3, #003h
	MOV R2, #0FCh
	MOV R1, #036h
	NOP
	DJNZ R1, $
	DJNZ R2, $-5
	DJNZ R3, $-9
	MOV R2, #015h
	MOV R1, #0B0h
	NOP
	DJNZ R1, $
	DJNZ R2, $-5
	NOP
	RET
; Rest: 0
; END: Wait loop
	END