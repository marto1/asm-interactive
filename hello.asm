extern open
extern mmap64


SECTION .text
	global _start
_start:
	push 2
	push "inject.o"
	call open
	;; mmap
	;; jmp addr ; jmp to mmap-ed instructions here
	;; 
	jmp    _start
        xor    ebx, ebx 	; 0
	mov	eax, 1
        int    0x80
