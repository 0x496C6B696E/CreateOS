# CreateOS

A minimal x86 kernel written from scratch in C and assembly. GRUB loads it via the Multiboot spec, and it boots in QEMU and writes to the screen through VGA text memory.

```
GRUB (Multiboot) → boot/boot.s (_start) → kernel_main() → VGA text buffer @ 0xB8000
```

## How it works

| File | Role |
|---|---|
| `boot/boot.s` | Multiboot header (magic `0x1BADB002`, flags, checksum) and the `_start` entry point, which calls `kernel_main` and then halts with `cli; hlt` |
| `kernel/kernel.c` | Freestanding C kernel: writes a string straight into VGA text memory at `0xB8000` (character byte + attribute byte `0x07`) |
| `linker.ld` | Loads the kernel at 1 MiB and puts the `.multiboot` section first so GRUB can find the header |
| `Makefile` | Builds `kernel.elf`, packs it into a bootable ISO with `grub-mkrescue` and starts QEMU |

## Build and run

Requirements: an `i686-elf` cross compiler, `grub-mkrescue` (plus `xorriso`) and `qemu-system-x86_64`.

```bash
make run     # build → ISO → boot in QEMU
make iso     # only build build/CreateOS.iso
make clean
```

On boot the screen shows `Hello from CreateOS!`.

## Roadmap

- [ ] GDT and IDT setup
- [ ] Keyboard and timer interrupts (PIC/PIT)
- [ ] Physical memory manager and paging
- [ ] VGA terminal driver with scrolling and `printf`
- [ ] Screenshot/GIF of the QEMU boot in this README

`src/` contains early experiments and is not part of the build.

## License

[MIT](LICENSE)
