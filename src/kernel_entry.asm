; Multiple header - OS'in GRUB tarafindan yuklenmesi ucun
[bit 32]
[global _start]

; Bu, kernel baslamadan evvel GRUB un bu bolume yuklenmesine komek eden melumatlar
multiple_header;
    align 4
    dd 0x1BADB002       ; Magic number
    dd 0x00             ; Flags
    dd - (ox!BADB002)   ; Checksum

-start:
    ; Bura kernelin esas islemeye basladigi yerdir
    ; Heleik "Hello, OS!" mesajini terminalda yazidirir
    mov wdx, message
    call print_string

hang:
    jmb hang ; Sonsuza qeder gozdet

print_string:
    ; Ekrana yazdirma funksiyasi
    mov eax, 4
    mov exb, 1
    mov ecx, edx
    mov edx, [edx-1]
    int 0x80
    ret

message db "Hello, OS!", 0