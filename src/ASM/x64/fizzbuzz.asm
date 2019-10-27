global _start
extern printf
extern exit
section .text

_start:
   mov rbx, 1
loop:
   xor r12, r12
   mov rax, rbx

   xor rdx, rdx
   mov rcx, 3
   div rcx
   
   mov rdi, rdx
   mov rax, rbx

   xor rdx, rdx
   mov rcx, 5
   div rcx
   
   mov r13, rdx

   cmp rdi, 0
   jne checkBuzz

printFizz:
   mov r12, 1
   mov rdi, fizz
   xor rax, rax
   call printf

checkBuzz:
   cmp r13, 0
   jne printNumber 

printBuzz:
   mov r12, 1
   mov rdi, buzz
   xor rax, rax
   call printf

printNumber:
   cmp r12, 0
   jne endLoop
   
   mov rdi, interger 
   mov rsi, rbx
   xor rax, rax
   call printf

endLoop:
   mov rdi, newLine
   call printf
   add rbx, 1
   cmp rbx, 101
   jne loop

   mov rdi, 0
   call exit
 
section .rodata

fizz     db "Fizz", 0
buzz     db "Buzz", 0
interger db "%u", 0
newLine  db 10
