;LPC1778_REG_ASM.s
;Register LPC1778 10/2017
;


;GPIO Port 0
LPC_GPIO0_DIR		equ	(0x20098000)	;Direction control register
LPC_GPIO0_MASK		equ (0x20098010)	;Mask register
LPC_GPIO0_PIN		equ	(0x20098014)	;Pin value register
LPC_GPIO0_SET		equ	(0x20098018)	;Output Set register
LPC_GPIO0_CLR		equ	(0x2009801C)	;Output Clear register

;GPIO Port 1
LPC_GPIO1_DIR		equ	(0x20098020)	;Direction control register
LPC_GPIO1_MASK		equ (0x20098030)	;Mask register
LPC_GPIO1_PIN		equ	(0x20098034)	;Pin value register
LPC_GPIO1_SET		equ	(0x20098038)	;Output Set register
LPC_GPIO1_CLR		equ	(0x2009803C)	;Output Clear register
	
;GPIO Port 2
LPC_GPIO2_DIR		equ	(0x20098040)	;Direction control register
LPC_GPIO2_MASK		equ (0x20098050)	;Mask register
LPC_GPIO2_PIN		equ	(0x20098054)	;Pin value register
LPC_GPIO2_SET		equ	(0x20098058)	;Output Set register
LPC_GPIO2_CLR		equ	(0x2009805C)	;Output Clear register	
	
;GPIO Port 3
LPC_GPIO3_DIR		equ	(0x20098060)	;Direction control register
LPC_GPIO3_MASK		equ (0x20098070)	;Mask register
LPC_GPIO3_PIN		equ	(0x20098074)	;Pin value register
LPC_GPIO3_SET		equ	(0x20098078)	;Output Set register
LPC_GPIO3_CLR		equ	(0x2009807C)	;Output Clear register
	

;GPIO Interrupts
LPC_GPIO_INT_STATUS		equ	(0x40028080)	;GPIO overall Interrupt Status register (
LPC_GPIO0_INT_STATR		equ (0x40028084)	;GPIO Interrupt Status for port 0 Rising Edge Interrupt
LPC_GPIO0_INT_STATF		equ	(0x40028088)	;GPIO Interrupt Status for port 0 Falling Edge Interrupt
LPC_GPIO0_INT_CLR		equ	(0x4002808C)    ;GPIO Interrupt Clear register for port 0
LPC_GPIO0_INT_ENR		equ	(0x40028090)    ;GPIO Interrupt Enable for port 0 Rising Edge	
LPC_GPIO0_INT_ENF		equ	(0x40028094)    ;GPIO Interrupt Enable for port 0 Falling Edge	
	
	
;NVIC  EXTINT
LPC_ISER0			equ (0xE000E100)	;Interrupt Set-Enable 0
LPC_ISER1			equ (0xE000E104)	;Interrupt Set-Enable 1
LPC_ICER0			equ (0xE000E180)	;Interrupt Clear-Enable 0
LPC_ICER1			equ (0xE000E184)	;Interrupt Clear-Enable 1
LPC_ISPR0           equ (0xE000E200)    ;Interrupt Set-Pending 0
LPC_ISPR1           equ (0xE000E204)    ;Interrupt Set-Pending 1
LPC_ICPR0           equ (0xE000E280)    ;Interrupt Clear-Pending 0
LPC_ICPR1           equ (0xE000E284)    ;Interrupt Clear-Pending 2

	
;EXTINT
LPC_EXTINT			equ (0x400FC140)	;External Interrupt Flag Register
LPC_EXTMODE			equ (0x400FC148)	;External Interrupt Mode register
LPC_EXTPOLAR		equ (0x400FC14C)	;External Interrupt Polarity Register




;TIMER 0
LPC_TIM0_IR			equ (0x40004000)	;Interrupt Register
LPC_TIM0_TCR		equ (0x40004004)	;Timer Control Register
LPC_TIM0_TC			equ (0x40004008)	;Timer Counter
LPC_TIM0_PR			equ (0x4000400C)	;Prescale Register
LPC_TIM0_PC			equ (0x40004010)	;Prescale Counter
LPC_TIM0_MCR		equ (0x40004014)	;Match Control Register
LPC_TIM0_MR0		equ (0x40004018)	;Match Register 0
	
;TIMER 1
LPC_TIM1_IR			equ (0x40008000)	;Interrupt Register
LPC_TIM1_TCR		equ (0x40008004)	;Timer Control Register
LPC_TIM1_TC			equ (0x40008008)	;Timer Counter
LPC_TIM1_PR			equ (0x4000800C)	;Prescale Register
LPC_TIM1_PC			equ (0x40008010)	;Prescale Counter
LPC_TIM1_MCR		equ (0x40008014)	;Match Control Register
LPC_TIM1_MR0		equ (0x40008018)	;Match Register 0


;UART 0
LPC_UART0_RBR		equ (0x4000C000)	;Receiver Buffer Register (RO)
LPC_UART0_THR		equ (0x4000C000)	;Transmit Holding Register (WO)
LPC_UART0_DLL		equ (0x4000C000)	;Divisor Latch LSB
LPC_UART0_DLM		equ (0x4000C004)	;Divisor Latch MSB	
LPC_UART0_IER		equ (0x4000C004)	;Interrupt Enable Register
LPC_UART0_IIR		equ (0x4000C008)	;Interrupt ID Register
LPC_UART0_FCR		equ (0x4000C008)	;FIFO Control Register (WO)
LPC_UART0_LCR		equ (0x4000C00C)	;Line Control Register
LPC_UART0_LSR		equ (0x4000C014)	;Line Status Register (RO)
LPC_UART0_FDR		equ (0x4000C028)	;Fractional Divider Register
	
;UART 2
LPC_UART2_RBR		equ (0x40098000)	;Receiver Buffer Register (RO)
LPC_UART2_THR		equ (0x40098000)	;Transmit Holding Register (WO)
LPC_UART2_DLL		equ (0x40098000)	;Divisor Latch LSB
LPC_UART2_DLM		equ (0x40098004)	;Divisor Latch MSB	
LPC_UART2_IER		equ (0x40098004)	;Interrupt Enable Register
LPC_UART2_IIR		equ (0x40098008)	;Interrupt ID Register
LPC_UART2_FCR		equ (0x40098008)	;FIFO Control Register (WO)
LPC_UART2_LCR		equ (0x4009800C)	;Line Control Register
LPC_UART2_LSR		equ (0x40098014)	;Line Status Register (RO)
LPC_UART2_FDR		equ (0x40098028)	;Fractional Divider Register
	
;I/O Control registers for port 0	
IOCON_P0_0			equ	(0x4002C000)	;I/O Control register (IOCON)P0.0 usw.
IOCON_P0_1			equ	(0x4002C004)
IOCON_P0_2			equ	(0x4002C008)
IOCON_P0_3			equ	(0x4002C00C)	
IOCON_P0_4			equ	(0x4002C010)
IOCON_P0_5			equ	(0x4002C014)
IOCON_P0_6			equ	(0x4002C018)
IOCON_P0_7			equ	(0x4002C01C)
	
IOCON_P0_8			equ	(0x4002C020)
IOCON_P0_9			equ	(0x4002C024)
IOCON_P0_10			equ	(0x4002C028)
IOCON_P0_11			equ	(0x4002C02C)	
IOCON_P0_12			equ	(0x4002C030)
IOCON_P0_13			equ	(0x4002C034)
IOCON_P0_14			equ	(0x4002C038)
IOCON_P0_15			equ	(0x4002C03C)
	
IOCON_P0_16			equ	(0x4002C040)
IOCON_P0_17			equ	(0x4002C044)
IOCON_P0_18			equ	(0x4002C048)
IOCON_P0_19			equ	(0x4002C04C)	
IOCON_P0_20			equ	(0x4002C050)
IOCON_P0_21			equ	(0x4002C054)
IOCON_P0_22			equ	(0x4002C058)
IOCON_P0_23			equ	(0x4002C05C)
	
IOCON_P0_24			equ	(0x4002C060)
IOCON_P0_25			equ	(0x4002C064)
IOCON_P0_26			equ	(0x4002C068)
IOCON_P0_27			equ	(0x4002C06C)	
IOCON_P0_28			equ	(0x4002C070)
IOCON_P0_29			equ	(0x4002C074)
IOCON_P0_30			equ	(0x4002C078)
IOCON_P0_31			equ	(0x4002C07C)		
	
;I/O Control registers for port 2	
IOCON_P2_8			equ	(0x4002C120)	;U2_TXD	= 0x00000032
IOCON_P2_9			equ	(0x4002C124)	;U2_RXD = 0x00000032

IOCON_P2_11			equ	(0x4002C12C)	;EINT1 = 0x00000031
IOCON_P2_12			equ	(0x4002C130)	;EINT2 = 0x00000031
	
	
	
		END