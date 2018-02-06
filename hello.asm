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
	add eax, 20 		; return to _start extra space
	mov DWORD [fsize], eax 	; assign file size

	mov rdi, 0
	mov rsi, QWORD [fsize]
	mov rdx, 7
	mov r10, 1
	mov r8,  r14
	xor r9, r9
	mov rax, 9	; mmap
	syscall

	mov r15, rax 	; preserve address of mmap-ed

	mov rdi, r14
	mov rax, 3 	; close
	syscall
	
	;; ensure last instruction is jmp _start TODO
	mov r14, QWORD [fsize]
dev:	mov QWORD [r15 + r14 - 20], 0x90
	
	jmp r15 	; jmp to address

	;; jmp addr ; jmp to mmap-ed instructions here
	;; jmp    _start
        xor    	rbx, rbx 	; 0
	mov	rax, 1
        int	0x80
