section .data
    msg_n     db "Enter N: "
    len_n     equ $ - msg_n
    msg_num   db "Enter number: "
    len_num   equ $ - msg_num
 
section .bss
    byte_buf  resb 1        ; буфер для чтения по 1 байту
    num_buf   resb 64       ; буфер для хранения числа
 
section .text
    global _start
 
; --- Макро-функция: читает одну строку в num_buf ---
; Возвращает длину строки в r10
read_line:
    xor r10, r10            ; длина = 0
.rl_loop:
    mov rax, 0              ; sys_read
    mov rdi, 0              ; stdin
    mov rsi, byte_buf       ; читаем 1 байт
    mov rdx, 1
    syscall
    cmp rax, 0
    jle .rl_done            ; EOF или ошибка
    movzx rax, byte [byte_buf]
    cmp al, 10              ; '\n'
    je .rl_done             ; конец строки
    mov [num_buf + r10], al ; сохраняем символ
    inc r10
    cmp r10, 63             ; защита от переполнения
    jl .rl_loop
.rl_done:
    ret
 
_start:
    ; Вывод "Enter N: "
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_n
    mov rdx, len_n
    syscall
 
    ; Читаем N побайтово
    call read_line          ; r10 = длина, num_buf = строка N
 
    ; Конвертируем N в число → r9
    xor r9, r9
    xor rbx, rbx
.conv_n:
    cmp rbx, r10
    jge .conv_done
    movzx rax, byte [num_buf + rbx]
    cmp al, '0'
    jb .conv_done
    cmp al, '9'
    ja .conv_done
    sub rax, '0'
    imul r9, r9, 10
    add r9, rax
    inc rbx
    jmp .conv_n
.conv_done:
    cmp r9, 0
    je .exit
 
.loop:
    ; Вывод "Enter number: "
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_num
    mov rdx, len_num
    syscall
 
    ; Читаем число побайтово → num_buf, длина → r10
    call read_line
 
    cmp r10, 0
    jle .skip
 
    ; Проверка на '-' (отрицательное)
    movzx r12, byte [num_buf]
    cmp r12, 45             ; '-' = 45
    je .skip
 
    ; Все символы одинаковые?
    mov r12, 0
    movzx r12, byte [num_buf]   ; r12 = эталон
    mov rbx, 1
.check:
    cmp rbx, r10
    jge .do_print
    xor r13, r13
    movzx r13, byte [num_buf + rbx]
    cmp r12, r13
    jne .skip
    inc rbx
    jmp .check
 
.do_print:
    ; Вывод числа
    mov rax, 1
    mov rdi, 1
    mov rsi, num_buf
    mov rdx, r10
    syscall
    ; Вывод пробела
    mov byte [num_buf + r10], ' '
    mov rax, 1
    mov rdi, 1
    lea rsi, [num_buf + r10]
    mov rdx, 1
    syscall
 
.skip:
    dec r9
    jnz .loop
 
.exit:
    mov rax, 60
    xor rdi, rdi
    syscall
