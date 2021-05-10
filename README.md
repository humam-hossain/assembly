# Notes on Assembly

## Build & Assembling with nasm x86_64

**creating object file**
```bash
nsam -f elf64 -o object_file.o assembly_file.asm
```
> '-f' = format ; 'elf64' = x86_64 ; '-f elf64' = x86_64 format ; '-o object_file.o'  = output object file 

**creating executable file from object file using linker**
> ld=linker

```bash
ld object_file.o -o exe_file
```
**running executable file**
```bash
./exe_file
```
