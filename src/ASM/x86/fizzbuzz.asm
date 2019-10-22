global _start
extern printf
extern exit
section .text

_start:
   mov ebx, 1
loop:
   xor edi, edi
   mov eax, ebx

   xor edx, edx
   mov ecx, 3
   div ecx
   
   push edx
   mov eax, ebx

   xor edx, edx
   mov ecx, 5
   div ecx
   
   push edx

   pop edx
   cmp edx, 0
   jne checkBuzz

printFizz:
   mov edi, 1
   push fizz
   xor eax, eax
   call printf
   add esp, 4

checkBuzz:
   pop eax
   cmp eax, 0
   jne printNumber

printBuzz:
   mov edi, 1
   push buzz
   xor eax, eax
   call printf
   add esp, 4

printNumber:
   cmp edi, 0
   jne endLoop

   push ebx
   push integer
   xor eax, eax
   call printf
   add esp, 8

endLoop:
   push newLine
   call printf
   add esp, 4
   add ebx, 1
   cmp ebx, 101
   jne loop

   push 0
   call exit
 
section .rodata

fizz     db "Fizz", 0
buzz     db "Buzz", 0
integer  db "%u", 0
newLine  db 10
