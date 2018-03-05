extern mmap64

PROT equ 7 ; PROT_READ|PROT_WRITE|PROT_EXEC
NULL equ 0
FLAGS equ 0x22			; MAP_ANONYMOUS | MAP_PRIVATE mmap 
MAIN_SIZE equ 70		; size of mmap
MMAP equ 9

SECTION .text
	global _start
_start:

	mov rdi, NULL	; kernel allocates address
	mov rsi, MAIN_SIZE
	mov rdx, PROT
	mov r10, FLAGS	; private
	mov r8,  NULL
	xor r9,  r9
	mov rax, MMAP	; mmap
	syscall

	mov r15, rax 	; preserve address of mmap-ed

	;; ensure last instruction is register jump to dev
	mov QWORD [rax + 0], QWORD 0xB8 ; mov eax, dev
	mov QWORD [rax + 1], QWORD dev
	mov QWORD [rax + 5], 0xE0FF ; jmp rax

dev:	jmp r15 	; jmp to mmap-ed file

        xor    	rdi, rdi 	; 0
	mov	rax, 60
	syscall
