#include "stdint.h"
#include "stdio.h"

#include "riscv_csr_encoding.h"

// 向 APLIC 寄存器写入 32 位数据
static inline void aplic_write32(uintptr_t addr, uint32_t val) {
    *(volatile uint32_t *)addr = val;
}

// 从 APLIC 寄存器读取 32 位数据
static inline uint32_t aplic_read32(uintptr_t addr) {
    return *(volatile uint32_t *)addr;
}


// ================= APLIC 寄存器定义 (基于 RISC-V AIA 规范) =================
// 假设 APLIC 基地址为 0x0C000000 (QEMU virt 机器的常见映射地址，需根据实际设备树确认)
#define APLIC_BASE_ADDR     0x0C000000UL

// Domain Configuration Registers
#define APLIC_DOMAINCFG     (APLIC_BASE_ADDR + 0x0000)
#define APLIC_SOURCECFG_BASE (APLIC_BASE_ADDR + 0x0004) // 每个中断源占4字节

// Interrupt Pending Registers (用于模拟触发中断)
#define APLIC_SETPEND_NUM    (APLIC_BASE_ADDR + 0x1000)

// Target HART 配置 (将中断源映射到具体的 CPU 核)
#define APLIC_TARGET_BASE    (APLIC_BASE_ADDR + 0x3000) // 每个中断源占4字节

void aplic_init(void){
  aplic_write32(APLIC_DOMAINCFG,0x01);
  aplic_write32(APLIC_SOURCECFG_BASE + 0 * 4,0x01);
  aplic_write32(APLIC_TARGET_BASE + 0 * 4,(0 << 18) | 1);

    write_csr(mie, read_csr(mie) | (1 << 11));
    // 开启 SSTATUS 中的 SIE 全局中断使能
    write_csr(mstatus, read_csr(mstatus) | MSTATUS_MIE);

}

int main(void){
  aplic_init();
  aplic_write32(APLIC_SETPEND_NUM, 1);
  printf("hello world\r\n");
  return 0;
}
