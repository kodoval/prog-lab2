; Задание 3, вариант 2 — числа из одинаковых цифр
; x86-64 NASM для Linux
; Компиляция: nasm -f elf64 task3.asm -o task3.o && ld task3.o -o task3
; Запуск: echo "4\n33\n12\n11\n245" | ./task3

section .data
    msg_n    db "Введите N, затем числа (каждое с новой строки):", 10, 0
    msg_out  db "Результат: ", 0
    newline  db 10, 0
    space    db " ", 0
    not_found db "не найдено", 10, 0

section .bss
    buf      resb 20
    outbuf   resb 20

section .text
    global _start

; Читает число из stdin, возвращает в rax (или -1 при EOF)
read_int:
    push rbx
    push rcx
    push rdx
    xor rbx, rbx        ; результат
    xor rcx, rcx        ; флаг: прочитан ли хоть один символ
.loop:
    mov rax, 0          ; sys_read
    mov rdi, 0          ; stdin
    lea rsi, [buf]
    mov rdx, 1
    syscall
    test rax, rax
    jle .eof
    movzx rdx, byte [buf]
    cmp rdx, 10         ; newline
    je .done
    cmp rdx, '0'
    jl .loop
    cmp rdx, '9'
    jg .loop
    imul rbx, rbx, 10
    sub rdx, '0'
    add rbx, rdx
    mov rcx, 1
    jmp .loop
.done:
    test rcx, rcx
    jz .eof
    mov rax, rbx
    pop rdx
    pop rcx
    pop rbx
    ret
.eof:
    mov rax, -1
    pop rdx
    pop rcx
    pop rbx
    ret

; Выводит число из rdi в stdout
print_int:
    push rbx
    push rcx
    push rdx
    mov rax, rdi
    lea rbx, [outbuf+19]
    mov byte [rbx], 0
    mov rcx, 10
.ploop:
    xor rdx, rdx
    div rcx
    add rdx, '0'
    dec rbx
    mov [rbx], dl
    test rax, rax
    jnz .ploop
    ; вычислить длину
    lea rdx, [outbuf+19]
    sub rdx, rbx
    mov rax, 1
    mov rdi, 1
    mov rsi, rbx
    syscall
    pop rdx
    pop rcx
    pop rbx
    ret

; Проверяет, все ли цифры числа rdi одинаковы. Возвращает 1 в rax если да.
all_same:
    push rbx
    push rcx
    push rdx
    mov rax, rdi
    xor rdx, rdx
    mov rcx, 10
    div rcx
    mov rbx, rdx        ; первая цифра (остаток)
.check:
    test rax, rax
    jz .yes
    xor rdx, rdx
    div rcx
    cmp rdx, rbx
    jne .no
    jmp .check
.yes:
    mov rax, 1
    jmp .ret
.no:
    xor rax, rax
.ret:
    pop rdx
    pop rcx
    pop rbx
    ret

_start:
    ; Вывести приглашение
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_n
    mov rdx, 48
    syscall

    ; Читаем N
    call read_int
    mov r12, rax        ; r12 = N (счётчик)
    xor r13, r13        ; r13 = найдено хоть одно?

    ; Вывести "Результат: "
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_out
    mov rdx, 11
    syscall

.main_loop:
    test r12, r12
    jz .done_loop
    dec r12

    call read_int
    cmp rax, -1
    je .done_loop

    mov rdi, rax
    push rdi
    call all_same
    pop rdi
    test rax, rax
    jz .main_loop

    ; Вывести число
    call print_int

    ; Вывести пробел
    mov rax, 1
    mov rdi, 1
    mov rsi, space
    mov rdx, 1
    syscall

    mov r13, 1
    jmp .main_loop

.done_loop:
    test r13, r13
    jnz .end
    ; Вывести "не найдено"
    mov rax, 1
    mov rdi, 1
    mov rsi, not_found
    mov rdx, 20
    syscall
    jmp .exit

.end:
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

.exit:
    mov rax, 60
    xor rdi, rdi
    syscall
