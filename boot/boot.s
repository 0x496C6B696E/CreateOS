.section .multiboot
.align 4
.long 0x1BADB002        # magic number
.long 0x00000000        # flags
.long 0xE4524FFD        # checksum = -(magic + flags) & 0xFFFFFFFF

.section .text
.global _start
_start:
    call kernel_main

.hang:
    cli
    hlt
    jmp .hang
