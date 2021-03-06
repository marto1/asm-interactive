extern mmap64


section .bss
    stat resb 144
    fsize resb 4

struc STAT
    .st_dev         resq 1
    .st_ino         resq 1
    .st_nlink       resq 1
    .st_mode        resd 1
    .st_uid         resd 1
    .st_gid         resd 1
    .pad0           resb 4
    .st_rdev        resq 1
    .st_size        resq 1
    .st_blksize     resq 1
    .st_blocks      resq 1
    .st_atime       resq 1
    .st_atime_nsec  resq 1
    .st_mtime       resq 1
    .st_mtime_nsec  resq 1
    .st_ctime       resq 1
    .st_ctime_nsec  resq 1
endstruc

SECTION .data
fname:	db "inject", 0
SECTION .text
	global _start
_start:
	mov rax, 2
	mov rdi, fname 
	mov rsi, 2	; open inject code
	syscall
	mov r14, rax
	
	mov rdi, fname
	mov rsi, stat
	mov rax, 4	; stat inject code
	syscall

	mov eax, dword [stat + STAT.st_size]
	mov DWORD [fsize], eax 	; assign file size

	mov rdi, 0	; kernel allocates address
	mov rsi, QWORD [fsize]
	mov rdx, 7	; PROT_READ|PROT_WRITE|PROT_EXEC
	mov r10, 2	; private
	mov r8,  r14
	xor r9, r9
	mov rax, 9	; mmap
	syscall

	mov r15, rax 	; preserve address of mmap-ed

	mov rdi, r14
	mov rax, 3 	; close
	syscall


	mov r14, QWORD [fsize]
	;; ensure last instruction is register jump to dev
	mov QWORD [r15 + r14 - 8], QWORD 0xB8 ; mov eax, dev
	mov QWORD [r15 + r14 - 7], QWORD dev
	mov QWORD [r15 + r14 - 3], 0xE0FF ; jmp rax

dev:	jmp r15 	; jmp to mmap-ed file

        xor    	rdi, rdi 	; 0
	mov	rax, 60
	syscall
