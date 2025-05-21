BUILD = build
ISO = isodir

all: run

$(BUILD)/kernel.elf: boot/boot.s kernel/kernel.c linker.ld
	mkdir -p $(BUILD)
	i686-elf-gcc -ffreestanding -m32 -c boot/boot.s -o $(BUILD)/boot.o
	i686-elf-gcc -ffreestanding -m32 -c kernel/kernel.c -o $(BUILD)/kernel.o
	i686-elf-gcc -ffreestanding -m32 -nostdlib -T linker.ld -o $(BUILD)/kernel.elf $(BUILD)/boot.o $(BUILD)/kernel.o

iso: $(BUILD)/kernel.elf
	mkdir -p $(ISO)/boot/grub
	cp $(BUILD)/kernel.elf $(ISO)/boot/kernel.elf
	echo 'set timeout=0' > $(ISO)/boot/grub/grub.cfg
	echo 'menuentry "CreateOS" { multiboot /boot/kernel.elf }' >> $(ISO)/boot/grub/grub.cfg
	grub-mkrescue -o $(BUILD)/CreateOS.iso $(ISO)

run: iso
	qemu-system-x86_64 -cdrom $(BUILD)/CreateOS.iso

clean:
	rm -rf $(BUILD) $(ISO)
