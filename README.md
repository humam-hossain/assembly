# Notes on Assembly
---
## i8086 legacy processor architecture

* This processor works on real mode/ legacy mode.
* It's a 16 bit processor.
* total 13 registers.
* can work with 1 memory segment.

### format
```assembly
org 100h    ; setting origin to 100h

; code here

ret
```

### Interrupt Vector Table
* 0000:0000 is the memory address of interrupt vector table.
* This table holds 256 different addresses corresponds to each interrupts.

### Registers - 2 bytes/16 bit

* **General Purpose registers - 4**
  1. ax - 
  2. bx - 
  3. cx - this register is used for counting operations.
  4. dx - 

  > General Purpose registers are divided by highs byte (ex. ah) and low bytes (ex. al)

* **Special registers - total 9**
  1. cs - code segment. it holds segment address of current memory.
  2. ip - index pointer. it holds offset address of current memory. It's the second byte of memory address.
  3. ss - stack segment. it holds segment address of current stack.
  4. sp - stack pointer. it holds offset address of current stack.
  5. bp -  base pointer.
  6. si - source index
  7. di - destination index
  8. ds - destination segment register. First byte of the memory address. to write in the memory this register is used. to manually change the register:
  ```assembly
  mov ax, [memory_address_segment]
  mov ds, ax 
  ```
  9. es

  > these registers are not divided into high and low byte.

* There are 9 flags

## Build & Assembling with nasm x86_64

**creating object file**
```bash
nsam -f elf64 -o object_file.o assembly_file.asm
```
> '-f' = format
> 
> 'elf64' = x86_64
> 
> '-f elf64' = x86_64 format
> 
> '-o object_file.o'  = output object file 

**creating executable file from object file using linker**
```bash
ld object_file.o -o exe_file
```
> ld=linker

**running executable file**
```bash
./exe_file
```

### Memory segment - 3 types

  1. Data Segment(section ```.data```-for constants and section ```.bss``` - for variables)
  2. Code Segment(section ```.text``` - main area in application)
  3. Stack Segment(contains data and any return addresses of any function)

### Processor Registers - 3 types

> 6 16bit processor registers
> 
> 10 32bit processor registers

#### General registers - 3 types
   
   1. ***Data registers - 4 types of registers***
      
   | types       | 32bit |  16bit |  16-8  |  7-0  |
   | ----------- | ----- | ------ | ------ | ----- |
   | Accumulator |  EAX  |   AX   |   AH   |  AL   |
   | Base        |  EBX  |   BX   |   BH   |  BL   |
   | Counter     |  ECX  |   CX   |   CH   |  CL   |
   | Data        |  EDX  |   DX   |   DH   |  DL   |

   2. ***Pointer registers - 3 types of registers***
      
   | types               | 15-0  | 32bit |
   | ------------------- | ----- | ----- |
   | Instruction pointer | IP    | EIP   |  
   | Stack pointer       | SP    | ESP   |
   | Base pointer        | BP    | EBP   |

   3. ***Index registers - 2 types of registers***
      
   | types                | 32bit |  15-0 |
   | ---------------------| ----- | ----- |
   | 1.Source Index       | ESI   |  SI   |
   | 2.Destination Index  | EDI   |  DI   |

#### Control registers - combination a 32bit Instruction pointer register & a 32bit flag resgister.  
  
  9 common flag registers types
    
  1. ***Overflow flag(OF)*** - overflow of a higher order bit(ex.leftmost bit of data after some arithmatic operation)
  2. ***Direction flag(DF)*** - left or right direction moving(ex.strings comparision)
  3. ***Interrupt flag(IF)*** - external input devices like keyboard interrupt control flag(enable-1/disable-0)
  4. ***Trap flag(TF)*** - allows to set the operation of the processor in sigle step mode
  5. ***Sign flag(SF)*** - take the sign of the result
  6. ***Zero flag(ZF)*** - if zero then 1 else 0 for non-zero
  7. ***Auxiliary Carry flag(AF)*** - contains carry bit from leftmost bit
  8. ***Parity flag(PF)*** - total number of single bits from result(odd=1,even=0)
  9. ***Carry flag(CF)*** - contains 0/1 from higher ordered bit/leftmost bit or last bit of shift operation or last bit of rotate operation

#### Segment registers - 3 types
  
  1. ***Data Segment*** - section ```.data```-for constants and section ```.bss``` - for variables
  2. ***Code Segment*** - section ```.text``` - main area in application
  3. ***Stack Segment*** - contains data and any return addresses of any function
  


## Register Addressing - different ways of addressing modes

```assembly
mov eax,4                 ;immediate addressing mode  
mov ebx.1                 
mov ecx,constant/varible  ; Put the offset of variable/constant in ecx          
```
* direct addressing mode - variable/constant
* direct offset addressing mode
* indirect memory addressing mode - example moving variable/constant/direct data in ***ebp/general base pointer register*** and addressing that pointer register to access data


## Defining points - use in constants

1. **db** - define byte - 1 byte
2. **dw** - define word - 2 byte
3. **dd** - define doubleword - 4 bytes
4. **dq** - define quadword - 8 bytes
5. **dt** - define ten bytes - 10 bytes

## Allocating storage space for uninitialize data - use in variable

1. **resb** - reserve byte - 1 byte
2. **resw** - reserve word - 2 bytes
3. **resd** - reserve doubleword - 4 bytes
4. **resq** - reserve quadword - 8 bytes
5. **rest** - reserve ten bytes - 10 bytes

```assembly
TIMES <value> ; used for repeating a value of variable
```

## Constant

```assembly
CONSTANT_NAME: <value> ;this type of constant cannot be reassigned or redefined
%assign CONSTANT_NAME <numeric_value> ; this type of constant can be reassigned or redefined only numeric constant can be defined
%define CONSTANT_NAME <numeric/string_value> ; same as %assign bt it can be string constant also
```

## Increment/Decrement
```assembly
inc register/[variable] ; to increment numerical value
dec register/[variable] ; to decrement numerical value(including newline character)
```
## Addition , Subtraction, multiplication, division
```assembly
add register1,register2 ; register1 = register1+register2
sub register1,register2 ; register1 = register1-register2
mul register ; unsigned data multiplication
imul register ; unsigned data multiplication
div register ; unsigned data division
idiv register ; unsigned data division
```

## bitwise operators
```assembly
and register1,register2
or register1,register2
xor register1,register2
not register
```

## Compare instruction
```assembly
cmp register, value
Label: ; label declaration
jmp Label; unconditional jump
```
  ### conditional jumps
  
  1. **ja/jnbe** - above/not below nor zero
  2. **jae/jnb** - above or equal/not below
  3. **jb/jnae** - below or not above nor equal
  4. **jbe/jna** - below or equal/ not above
  5. **jc** - carry
  6. **je/jz** - equal/zero
  7. **jg/jnle** - greater/not less not equal
  8. **jge/jnl** - greater or equal/not less
  9. **jl/jnge** - less/not greater nor equal
  10. **jle/jng** - less or equal/not greater
  11. **jnc** - not carry

## ASCII number system
```assembly
mov register, number
mov [variable], register

mov ecx, variable
mov edx, length

int kernal ; call kernal

; output: character from ASCII code of number
```

## Function
```assembly
function_name:
  ; code
  ret ; return

call function_name
```

## Stacks Data Structure (LIFO-Last in First Out)

push
pop
> don't understand yet

