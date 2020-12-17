; ========================================================================================
; | Modulname: main.s 					| Prozessor: LPC1778 	 	 |
; |--------------------------------------------------------------------------------------|
; | Ersteller: 	Simon Hoffmann und Aleksei Svatko	| Datum: 12.11.2020      	 |
; |--------------------------------------------------------------------------------------|
; | Version: 1.0	| Projekt: 	Stoppuhr	| Assembler: ARM-ASM 	 	 |
; |--------------------------------------------------------------------------------------|
; | Aufgabe: 	Eine Stoppuhr realisieren mithilfe Unterprogrammtechnik, Interrupts und	 |
; | 		Timer. Start, Stopp und Reset Taster sollen implementiert werden.	 |
; | 											 |
; |--------------------------------------------------------------------------------------|
; | Bemerkungen: 									 |
; | 											 |
; | 											 |
; |--------------------------------------------------------------------------------------|
; | Aenderungen: 									 |
; | 		19.11.2020		Simon Hoffmann		Zifferblatt Funktion	 |
; | 		26.11.2020		Aleksei Svatko		Stoppuhr ohne Interrupts |
; |		03.12.2020		Simon Hoffmann		Stoppuhr ohne Interrupts |
; |		10.12.2020		Aleksei Svatko		Stoppuhr mit Interrupts	 |
; |		17.12.2020		Simon Hoffmann		Stoppuhr mit Interrupts	 |
; ========================================================================================
; ------------------------------- includierte Dateien ------------------------------------
	include LPC1778_REG_ASM.inc	
; ------------------------------- exportierte Variablen ----------------------------------

; ------------------------------- importierte Variablen ----------------------------------

; ------------------------------- exportierte Funktionen ---------------------------------
	export  main
	export  TIMER0_IRQHandler
	export  TIMER1_IRQHandler
	export	GPIO_IRQHandler
; ------------------------------- importierte Funktionen ---------------------------------

; ------------------------------- symbolische Konstanten ---------------------------------
	AREA const, code
Numbers DCB 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F

; ------------------------------ Datensection / Variablen --------------------------------
	area variablen, readwrite
counter 		DCD 0
multiplexing		DCD 0

; ------------------------------- Codesection / Programm ---------------------------------
	area	main_s,code
		
	
	;--------------------------KONFIGURATIONEN-------------------------
main PROC

	
	;Setzt PINs 8 - 15 als Ausgaenge
	ldr R1, =LPC_GPIO0_DIR
	mov R2, #0x0000FF00
	str R2, [R1]
	
	; ---------------------Timer-Konfiguration 0---------------------
	; Prescale Register
	ldr R0, =LPC_TIM0_PR
	mov R1, #(12000-1) ; -> TC_CLK = 1 ms
	str R1, [R0]
	; Match Register
	ldr R0, =LPC_TIM0_MR0
	mov R1, #9 ; -> T_MATCH = 10 ms
	str R1, [R0]
	; Match control register
	ldr R0, =LPC_TIM0_MCR
	mov R1, #3 ; -> Interrupt und TCR Reset
	; bei Match 0
	str R1, [R0]
	; Timer Control Register
	ldr R0, =LPC_TIM0_TCR
	mov R1, #2 ; -> Reset
	str R1, [R0]
	mov R1, #1 ; -> enable
	str R1, [R0] 
	
	; Timer 0 Interrupt
	ldr R0, =LPC_ICPR0 ; clear pending bit
	mov R1, #0x02 ; recommended
	str R1, [R0]
	ldr R0, =LPC_ISER0 ; Timer 0 Interrupt
	; => ID 1 => ISER0
	mov R1, #0x02 ; Bitnummer:
	; 0000:0010 -> 0x02
	str R1, [R0] 
	
	; ---------------------Timer-Konfiguration 1---------------------
	; Prescale Register
	ldr R0, =LPC_TIM1_PR
	mov R1, #(12000-1) ; -> TC_CLK = 1 ms
	str R1, [R0]
	; Match Register
	ldr R0, =LPC_TIM1_MR0
	mov R1, #99 ; -> T_MATCH = 100 ms
	str R1, [R0]
	; Match control register
	ldr R0, =LPC_TIM1_MCR
	mov R1, #3 ; -> Interrupt und TCR Reset
	; bei Match 0
	str R1, [R0]
	; Timer Control Register
	ldr R0, =LPC_TIM1_TCR
	mov R1, #2 ; -> Reset
	str R1, [R0]
	mov R1, #1 ; -> enable
	str R1, [R0] 
	
	; Timer 1 Interrupt
	ldr R0, =LPC_ICPR0 ; clear pending bit
	mov R1, #0x04 ; recommended
	str R1, [R0]
	ldr R0, =LPC_ISER0 ; Timer 1 Interrupt
	; => ID 1 => ISER0
	mov R1, #0x04 ; Bitnummer:
	; 0000:0010 -> 0x02
	str R1, [R0] 
	
	; ---------------------GPIO-Interrupt Konfiguration Start/Stop/Reset---------------------
	; GPIO Interrupt
	ldr R0, =LPC_GPIO0_INT_ENF
	mov R1, #0x70000  ; Taster 0, 1, 2 -> Pin/Bit 16, 17, 18
	str R1, [R0]    ; 1= enablefallingedge; on Pin 16, 17, 18
	; NVIC
	; GPIO Interrupt = ID 38 => ICPR1 / ISER1
	ldr R0, =LPC_ICPR1 
	mov R1, #0x40; -> 0100:0000 -> 0x40
	str R1, [R0] ; clearpendingbit
	ldr R0, =LPC_ISER1 
	mov R1, #0x40      ; -> 0100:0000 -> 0x40
	str R1, [R0] ; setenablebit
		
	;Variablen Initialisieren
	ldr R0, =multiplexing
	mov R1, #0
	str R1, [R0]
	
	ldr R0, =counter
	mov R1, #0
	str R1, [R0]
	
	mov R4, #0
	mov R5, #0
	
	;--------------------------START STOPPUHR-------------------------

	
stopwatch 
	bl up_display		
	b stopwatch
	ENDP
		
;-----------------------------UNTERPROGRAMME-----------------------------
;LED Anzeige
up_display PROC
	PUSH{R0-R3, LR}

	ldr R2, =LPC_GPIO0_CLR
	mov R3, #0xff00
	str R3, [R2]
	
	;laedt zahlen array
	ldr R2, =Numbers
	
	ldr R0, =multiplexing
	ldr R1, [R0]
	cmp R1, #0
	beq onesplace
	;Zehnerstelle zahl Setzen
	ldrb R0, [R2, R4]
	b continue1
onesplace	
	;Einerstelle zahl Setzen
	ldrb R0, [R2, R5]
continue1
	
	lsl R0, #8
	
	cmp R1, #0
	beq continue
	add R0, #0x8000	
continue
															
	ldr R2, =LPC_GPIO0_SET
	mov R3, R0	
	str R3, [R2]		
	POP{R0-R3, PC}	
	endp
		
;Warteschleife fuer Tasterprellen
up_delay proc
	PUSH{R1, LR}
	;Wartezeit 1ms oder viellfaches davon
	ldr R1, =0x00001770  	
	mul R1, R1, R0			
	align 4
delay1
	sub	R1, #1 		
	cmp R1, #0		
	bgt delay1
	
	POP{R1, PC}

	endp
	
;-----------------------------INTERRUPTS-----------------------------	
; interrupt handler
GPIO_IRQHandler PROC
	push {R4, R5, LR}
	ldr R4, =LPC_GPIO0_INT_STATF
	ldr R5, [R4]
	and R5, #0x70000 ; Bit 16,17,18 markieren		
	
	cmp R5, #0x0 ; ist Bit 16 /	17 / 18			
	beq return ; Interrupt gesetzt?						

	; 10 ms warten (Tasterprellen)
	mov R0, #10 ; nested UP-Aufruf
	bl up_delay ; -> LR sichern
	
	cmp R5, #0x10000		;Start
	beq start
	
	cmp R5, #0x20000		;Stopp
	beq stopp
	b reset					;Wenn kein Stopp und kein Start gedrueckt dann definitiv wurde Reset gedrueckt
	
start	
	mov R7, #1
	b continue3
stopp
	mov R7, #0
	b continue3
reset
	ldr R3, =counter	
	mov R1, #0	
	str R1, [R3]
	
continue3	
	; Interrupt GPIO P0[16] zurücksetzen
	ldr R4, =LPC_GPIO0_INT_CLR
	mov R4, #0x70000
	str R4, [R4]
return
	pop {R4, R5, LR}
	bx LR
	ENDP

; Interrupt Handler um Zehnerstelle oder Einserstelle zu setzen
TIMER0_IRQHandler PROC
	; zuruecksetzen des Timers
	
	ldr R1, =LPC_TIM0_IR
	mov R3, #1
	str R3, [R1]

	ldr R0, =multiplexing
	ldr R1, [R0]
	cmp R1, #0
	bne tozero
	mov R1, #1
	b toone
tozero
	mov R1, #0
toone

	str R1, [R0]
	
	bx LR
	ENDP
	
; Interrupt Handler um Hoch zu zählen
TIMER1_IRQHandler PROC
	; zuruecksetzen des Timers
	ldr R1, =LPC_TIM1_IR
	mov R3, #1
	str R3, [R1]
	
	ldr R3, =counter
	ldr R1, [R3]

	;Vom Zaehler wird Einerstelle und Zehnerstelle berechnet
	mov R0, #10
	udiv R4, R1, R0
	mul R9, R4, R0
	sub R5, R1, R9
	
	cmp R7, #0
	beq continue2
	
	add R1, #1
	cmp R1, #100 ;reset counter
	bne continue2
	mov R1, #0
continue2
	str R1, [R3]
	
	bx LR
	ENDP
	end