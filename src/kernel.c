void kernel_main(void) {
    // Video Belleği: Ekranı kontrol etmek için kullanılan bellek adresi
    const char *msg = "Welcome to CreateOS";
    char *video_memory = (char*) 0xb8000;

    // Mesajı video belleğe yazma
    for (int i = 0; msg[i] != '\0'; i++) {
        video_memory[i * 2] = msg[i];        // Karakter
        video_memory[i * 2 + 1] = 0x07;     // Renk: Beyaz metin, siyah arka plan
    }

    // Sürekli döngü: Kernel burada çalışmaya devam eder
    while (1);
}

void putchar(char c) {
    // BIOS interrupt kullanarak ekrana bir karakter yazdırmak
    __asm__("int $0x10" : : "a"(0x0E00 | (c & 0xFF)));
}

