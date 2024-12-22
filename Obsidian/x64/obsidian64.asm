bits 64

section .data
    title db "OBSIDIAN V1.0", 10, 0
    input db " > ", 0

    shell db "/bin/bash", 0
    args db "-c", 0
    command db "bash save.sh" , 0
    final dq shell, args, buffer, 0 ;final

section .bss
    buffer resb 16
section .text
    global _start
    _start:
        mov rax, 1;title
        mov rdi, 1
        mov rsi, title
        mov rdx, 13
        syscall

        mov rax, 1;enter
        mov rdi, 1
        mov rsi, input
        mov rdx, 4
        syscall

        mov rax, 0 ;input
        mov rdi , 0
        mov rsi , buffer
        mov rdx, 16
        syscall

        mov rax, 1 ;output
        mov rdi, 1
        mov rsi, buffer
        mov rdx, 16
        syscall


        mov rdi, shell;command
        lea rsi, [final]
        xor rdx, rdx

        mov rax, 59;execute
        syscall

        jmp _exit

        
    _exit:
        
        mov rax , 60; exit
        mov rdi, 0
        syscall