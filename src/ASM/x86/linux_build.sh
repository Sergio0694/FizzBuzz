rm fizzbuzz -f
rm fizzbuzz.o -f

nasm -f elf32 fizzbuzz.asm
gcc -m32 -no-pie -nostartfiles fizzbuzz.o -o fizzbuzz -lc
