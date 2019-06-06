#assemble boot.s file
as --32 boot.s -o boot.o

#compile kernel.c file
gcc -m32 -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -Wall -Wextra

#linking the kernel with kernel.o and boot.o files
ld -m elf_i386 -T linker.ld kernel.o boot.o -o NagOS.bin -nostdlib

#check MyOS.bin file is x86 multiboot file or not
grub-file --is-x86-multiboot NagOS.bin

#building the iso file
mkdir -p isodir/boot/grub
cp NagOS.bin isodir/boot/NagOS.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o NagOS.iso isodir

#run it in qemu
qemu-system-x86_64 -m 512 -cdrom NagOS.iso
