bits 32

section .data
    title db "OBSIDIAN V1.0", 10, 0
    input db " > ", 0

    shell db "/bin/bash", 0
    args db "-c", 0
    command db "bash save.sh", 0
    final dd shell, args, buffer, 0 ; final

section .bss
    buffer resb 16

section .text
    global _start
    _start:
        ; Print title
        mov eax, 4        ; sys_write
        mov ebx, 1        ; file descriptor (stdout)
        mov ecx, title    ; pointer to the title string
        mov edx, 13       ; length of title
        int 0x80          ; make the syscall

        ; Print input prompt
        mov eax, 4        ; sys_write
        mov ebx, 1        ; file descriptor (stdout)
        mov ecx, input    ; pointer to the input prompt
        mov edx, 4        ; length of input prompt
        int 0x80          ; make the syscall

        ; Read user input
        mov eax, 3        ; sys_read
        mov ebx, 0        ; file descriptor (stdin)
        mov ecx, buffer   ; pointer to the buffer
        mov edx, 16       ; size of the buffer
        int 0x80          ; make the syscall

        ; Output the input back to the user
        mov eax, 4        ; sys_write
        mov ebx, 1        ; file descriptor (stdout)
        mov ecx, buffer   ; pointer to the buffer
        mov edx, 16       ; size of the buffer
        int 0x80          ; make the syscall

        ; Prepare to execute the command
        mov ebx, shell    ; pointer to the shell string
        lea ecx, [final]  ; pointer to the final arguments array
        xor edx, edx      ; zero the edx register

        mov eax, 11       ; sys_execve
        int 0x80          ; make the syscall

    _exit:
        ; Exit the program
        mov eax, 1        ; sys_exit
        mov ebx, 0        ; exit status
        int 0x80          ; make the syscall
