; ******************************* ;
; Lucas Carvalho Freiberger Stapf
; NUSP 11800559
; ******************************* ;

	ORG	0
LOOP:	MOV	A,P3
	SWAP	A
	RR	A
	MOV	P1,A
	JMP 	LOOP
	END