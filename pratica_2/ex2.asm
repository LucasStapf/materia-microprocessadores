; ********************************************** ;
; PRATICA 2 - LABORATORIO DE MICROPROCESSADORES
; GUSTAVO ROMANINI GOIS BARCO 10749202
; LEONARDO HANNAS DE CARVALHO SANTOS 11800480
; LUCAS CARVALHO FREIBERGER STAPF 11800559
; ********************************************** ;

	ORG	0h	; Programa principal
	SJMP	PROG

	ORG	03h	; Interrupção 0
	ACALL	INTER
	RETI
	
	ORG	1Bh	; Contador 1
	ACALL	CONTA
	RETI
	
; ********************************************************* ;
; 			Programa Principal
; ********************************************************* ;

PROG:
	SETB	EA		; Habilita interrupções

	SETB	EX0		; Habilita interrupção externa 0
	SETB	IT0		; Interrupção na descida de borda
	
	SETB 	ET1		; Habilita o contador 1
	MOV	TMOD,#01010000b	; Contador 1 no Modo 1
	MOV	TH1,#0FFh	; Carregando o valor 65525 no contador
	MOV	TL1,#0F5h
	
	MOV	A,#0		; Acumulador controlará os LEDs
	SETB	TR1		; Inicia a contagem

LOOP:	JNB	A.2, $
	CLR	TR1
	SJMP	LOOP

; ********************************************************* ;
; 			Sub-Rotina: CONTA
; ********************************************************* ;

CONTA:
	CLR	EA		; Desabilita interrupções
	MOV	TH1,#0FFh	; Carregando o valor 65525 no contador
	MOV	TL1,#0F5h
	SETB	A.7		; Seta bit 7 do acumulador
	RL	A		; Rotaciona para esquerda o acumulador
	MOV	P2,A		; Copia o acumulador para P2
	SETB	EA		; Habilita interrupções
	RET

; ********************************************************* ;
; 			Sub-Rotina: INTER
; ********************************************************* ;

INTER:
	CLR	EA		; Desabilita interrupções
	MOV	A,#0h		; Reseta acumulador
	MOV	P2,#0h		; Reseta LEDs
	MOV	TH1,#0FFh	; Carregando o valor 65525 no contador
	MOV	TL1,#0F5h
	SETB	TR1		; Inicia a contagem
	SETB 	EA		; Habilita interrupções
	RET
	
	END