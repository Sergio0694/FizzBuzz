rm fizzbuzz -f
rm fizzbuzz.o -f

nasm -f elf64 fizzbuzz.asm
gcc -no-pie -nostartfiles fizzbuzz.o -o fizzbuzz -lc
