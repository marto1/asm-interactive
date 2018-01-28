extern mmap64

SECTION  .data

  msg: db "Hello World",10
 
SECTION .text
	global _start
_start:
        mov    eax, 6
        mov    eax, 1
	mov    ebx, 20
	xchg   eax, ebx
	mov    ebx, 0
        xor    ebx, ebx
        int    0x80
