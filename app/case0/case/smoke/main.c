#include "stdio.h"

void _putchar(char character);

void u_puts(char *str){
  while(*str){
    _putchar(*str++);
  }
}

int main(void){
  u_puts("hello world\r\n");
  return 0;
}
