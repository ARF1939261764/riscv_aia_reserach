
#include "uart.h"

#include <sys/times.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/unistd.h>
#include <unistd.h>

void system_initial(void){
  // uart_initial((uart_t *)0x54000000,115200);
}

void _putchar(char character)
{
  uart_putc((uart_t *)0x10000000,character);
}

// 实现 _write 系统调用，将 printf 重定向到 UART
int _write(int fd, char *ptr, int len) {
    // 遍历缓冲区中的每个字符，并通过串口发送
    for (int i = 0; i < len; i++) {
        _putchar(*ptr++);
    }
    return len;
}

int _system (const char *i)
{

}
int _rename (const char *i, const char *j)
{

}
int _isatty (int i)
{

}
clock_t _times (struct tms *i)
{

}
int _gettimeofday (struct timeval *i, void *j)
{

}
int _unlink (const char *i)
{

}
int _link (void)
{

}
int _stat (const char *i, struct stat *j)
{

}
int _fstat (int j, struct stat *i)
{

}
int _swistat (int fd, struct stat * st)
{

}
caddr_t _sbrk (int i)
{
  extern char __HEAP_START;
  extern char __HEAP_END;
  static void *current_heap_end = &__HEAP_START;
  current_heap_end += i;
  if((size_t)current_heap_end > (size_t)&__HEAP_END) {
    _exit(-1);
  }
  return current_heap_end;
}
int _getpid (int i)
{

}
int _close (int i)
{

}
clock_t _clock (void)
{

}
int _swiclose (int i)
{

}
int _open (const char *i, int j, ...)
{

}
int _swiopen (const char *i, int j)
{

}

int _swiwrite (int k, char *i, int j)
{

}
int _lseek (int i, int j, int k)
{
  return 0;
}
int _swilseek (int i, int j, int k)
{
  return 0;
}
int _read (int i, char *j, int k)
{

}
int _swiread (int i, char *j, int k)
{

}
// 裸机环境下，_kill 直接返回失败即可
int _kill(int pid, int sig) {
    (void)pid;
    (void)sig;
    return -1; 
}

// 裸机环境下，_exit 通常实现为死循环，防止程序跑飞
void _exit(int status) {
    (void)status;
    while (1) {
        // 可选：在此处触发断点指令，方便 GDB 调试捕获退出
        // asm volatile("ebreak"); 
    }
}