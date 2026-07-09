
build/smoke/main.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_start>:
_start:
//*****************************
//zero_int_regs
//*****************************
#ifndef __RVE_EXT
    zero_int_regs 1, 31
    80000000:	00000093          	li	ra,0
    80000004:	00000113          	li	sp,0
    80000008:	00000193          	li	gp,0
    8000000c:	00000213          	li	tp,0
    80000010:	00000293          	li	t0,0
    80000014:	00000313          	li	t1,0
    80000018:	00000393          	li	t2,0
    8000001c:	00000413          	li	s0,0
    80000020:	00000493          	li	s1,0
    80000024:	00000513          	li	a0,0
    80000028:	00000593          	li	a1,0
    8000002c:	00000613          	li	a2,0
    80000030:	00000693          	li	a3,0
    80000034:	00000713          	li	a4,0
    80000038:	00000793          	li	a5,0
    8000003c:	00000813          	li	a6,0
    80000040:	00000893          	li	a7,0
    80000044:	00000913          	li	s2,0
    80000048:	00000993          	li	s3,0
    8000004c:	00000a13          	li	s4,0
    80000050:	00000a93          	li	s5,0
    80000054:	00000b13          	li	s6,0
    80000058:	00000b93          	li	s7,0
    8000005c:	00000c13          	li	s8,0
    80000060:	00000c93          	li	s9,0
    80000064:	00000d13          	li	s10,0
    80000068:	00000d93          	li	s11,0
    8000006c:	00000e13          	li	t3,0
    80000070:	00000e93          	li	t4,0
    80000074:	00000f13          	li	t5,0
    80000078:	00000f93          	li	t6,0
//*****************************
//__global_pointer
//*****************************
  .option push
  .option norelax
  la    gp, __global_pointer$
    8000007c:	00000197          	auipc	gp,0x0
    80000080:	16418193          	addi	gp,gp,356 # 800001e0 <__BSS_END__>
  .option pop

//*****************************
//clean bss
//*****************************
  la a0,__BSS_START__
    80000084:	00018513          	mv	a0,gp
  la a1,__BSS_END__
    80000088:	00018593          	mv	a1,gp

000000008000008c <_clean_bss_start>:
_clean_bss_start:
  beq a0,a1,_clean_bss_end
    8000008c:	00b50663          	beq	a0,a1,80000098 <_clean_bss_end>
  add a0,a0,1
    80000090:	00150513          	addi	a0,a0,1
  j _clean_bss_start
    80000094:	ff9ff06f          	j	8000008c <_clean_bss_start>

0000000080000098 <_clean_bss_end>:
_clean_bss_end:

  la t0,exit
    80000098:	00000297          	auipc	t0,0x0
    8000009c:	02c28293          	addi	t0,t0,44 # 800000c4 <exit>
  csrw mtvec,t0
    800000a0:	30529073          	csrw	mtvec,t0

//*****************************
//stack
//*****************************
  la sp,__C_STACK_TOP__
    800000a4:	00040117          	auipc	sp,0x40
    800000a8:	f5c10113          	addi	sp,sp,-164 # 80040000 <__C_STACK_TOP__>

//*****************************
//go to system_initial
//*****************************
  li    a0, 0
    800000ac:	00000513          	li	a0,0
  li    a1, 0
    800000b0:	00000593          	li	a1,0
  call system_initial
    800000b4:	014000ef          	jal	800000c8 <system_initial>
//*****************************
//go to main
//*****************************
  li    a0, 0
    800000b8:	00000513          	li	a0,0
  li    a1, 0
    800000bc:	00000593          	li	a1,0
  call main
    800000c0:	0da000ef          	jal	8000019a <main>

00000000800000c4 <exit>:

//*****************************
//exit
//*****************************
exit:
  j .
    800000c4:	0000006f          	j	800000c4 <exit>

00000000800000c8 <system_initial>:

#include "uart.h"

void system_initial(void){
    800000c8:	1141                	addi	sp,sp,-16
    800000ca:	e406                	sd	ra,8(sp)
    800000cc:	e022                	sd	s0,0(sp)
    800000ce:	0800                	addi	s0,sp,16
  // uart_initial((uart_t *)0x54000000,115200);
}
    800000d0:	0001                	nop
    800000d2:	60a2                	ld	ra,8(sp)
    800000d4:	6402                	ld	s0,0(sp)
    800000d6:	0141                	addi	sp,sp,16
    800000d8:	8082                	ret

00000000800000da <_putchar>:

void _putchar(char character)
{
    800000da:	1101                	addi	sp,sp,-32
    800000dc:	ec06                	sd	ra,24(sp)
    800000de:	e822                	sd	s0,16(sp)
    800000e0:	1000                	addi	s0,sp,32
    800000e2:	87aa                	mv	a5,a0
    800000e4:	fef407a3          	sb	a5,-17(s0)
  uart_putc((uart_t *)0x10000000,character);
    800000e8:	fef44783          	lbu	a5,-17(s0)
    800000ec:	85be                	mv	a1,a5
    800000ee:	10000537          	lui	a0,0x10000
    800000f2:	044000ef          	jal	80000136 <uart_putc>
}
    800000f6:	0001                	nop
    800000f8:	60e2                	ld	ra,24(sp)
    800000fa:	6442                	ld	s0,16(sp)
    800000fc:	6105                	addi	sp,sp,32
    800000fe:	8082                	ret

0000000080000100 <uart_initial>:
#include "stdint.h"
#include "uart.h"
#include "system.h"

void uart_initial(uart_t *periph,uint32_t baund){
    80000100:	1101                	addi	sp,sp,-32
    80000102:	ec06                	sd	ra,24(sp)
    80000104:	e822                	sd	s0,16(sp)
    80000106:	1000                	addi	s0,sp,32
    80000108:	fea43423          	sd	a0,-24(s0)
    8000010c:	87ae                	mv	a5,a1
    8000010e:	fef42223          	sw	a5,-28(s0)
  periph->div = 417;//FREQUENCY_CPU_CLK / baund;
    80000112:	fe843783          	ld	a5,-24(s0)
    80000116:	1a100713          	li	a4,417
    8000011a:	cf98                	sw	a4,24(a5)
  periph->tx_ctrl  = 1;
    8000011c:	fe843783          	ld	a5,-24(s0)
    80000120:	4705                	li	a4,1
    80000122:	c798                	sw	a4,8(a5)
  periph->rx_ctrl  = 1;
    80000124:	fe843783          	ld	a5,-24(s0)
    80000128:	4705                	li	a4,1
    8000012a:	c7d8                	sw	a4,12(a5)
}
    8000012c:	0001                	nop
    8000012e:	60e2                	ld	ra,24(sp)
    80000130:	6442                	ld	s0,16(sp)
    80000132:	6105                	addi	sp,sp,32
    80000134:	8082                	ret

0000000080000136 <uart_putc>:

void uart_putc(uart_t *periph,char ch){
    80000136:	1101                	addi	sp,sp,-32
    80000138:	ec06                	sd	ra,24(sp)
    8000013a:	e822                	sd	s0,16(sp)
    8000013c:	1000                	addi	s0,sp,32
    8000013e:	fea43423          	sd	a0,-24(s0)
    80000142:	87ae                	mv	a5,a1
    80000144:	fef403a3          	sb	a5,-25(s0)
  // while(periph->tx_fifo & (1<<31));
  periph->tx_fifo = ch;
    80000148:	fe744783          	lbu	a5,-25(s0)
    8000014c:	0007871b          	sext.w	a4,a5
    80000150:	fe843783          	ld	a5,-24(s0)
    80000154:	c398                	sw	a4,0(a5)
}
    80000156:	0001                	nop
    80000158:	60e2                	ld	ra,24(sp)
    8000015a:	6442                	ld	s0,16(sp)
    8000015c:	6105                	addi	sp,sp,32
    8000015e:	8082                	ret

0000000080000160 <u_puts>:
#include "stdio.h"

void _putchar(char character);

void u_puts(char *str){
    80000160:	1101                	addi	sp,sp,-32
    80000162:	ec06                	sd	ra,24(sp)
    80000164:	e822                	sd	s0,16(sp)
    80000166:	1000                	addi	s0,sp,32
    80000168:	fea43423          	sd	a0,-24(s0)
  while(*str){
    8000016c:	a821                	j	80000184 <u_puts+0x24>
    _putchar(*str++);
    8000016e:	fe843783          	ld	a5,-24(s0)
    80000172:	00178713          	addi	a4,a5,1
    80000176:	fee43423          	sd	a4,-24(s0)
    8000017a:	0007c783          	lbu	a5,0(a5)
    8000017e:	853e                	mv	a0,a5
    80000180:	f5bff0ef          	jal	800000da <_putchar>
  while(*str){
    80000184:	fe843783          	ld	a5,-24(s0)
    80000188:	0007c783          	lbu	a5,0(a5)
    8000018c:	f3ed                	bnez	a5,8000016e <u_puts+0xe>
  }
}
    8000018e:	0001                	nop
    80000190:	0001                	nop
    80000192:	60e2                	ld	ra,24(sp)
    80000194:	6442                	ld	s0,16(sp)
    80000196:	6105                	addi	sp,sp,32
    80000198:	8082                	ret

000000008000019a <main>:

int main(void){
    8000019a:	1141                	addi	sp,sp,-16
    8000019c:	e406                	sd	ra,8(sp)
    8000019e:	e022                	sd	s0,0(sp)
    800001a0:	0800                	addi	s0,sp,16
  u_puts("hello world\r\n");
    800001a2:	fe018513          	addi	a0,gp,-32 # 800001c0 <main+0x26>
    800001a6:	fbbff0ef          	jal	80000160 <u_puts>
  return 0;
    800001aa:	4781                	li	a5,0
}
    800001ac:	853e                	mv	a0,a5
    800001ae:	60a2                	ld	ra,8(sp)
    800001b0:	6402                	ld	s0,0(sp)
    800001b2:	0141                	addi	sp,sp,16
    800001b4:	8082                	ret
    800001b6:	0001                	nop
