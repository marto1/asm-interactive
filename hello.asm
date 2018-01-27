SECTION  .data

  msg: db "Hello World",10
 
SECTION .text
	global _start
_start:
        mov    eax, 6
        mov    eax, 1
        xor    ebx, ebx
        int    0x80
