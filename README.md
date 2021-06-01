# Notes on Assembly

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

  1. Data Segment(section .data-for constants and section .bss - for variables)
  3. Code Segment(section .text - main area in application)
  4. Stack Segment(contains data and any return addresses of any function)

### Processor Registers - 3 types

6 16bit processor registers
10 32bit processor registers

#### General registers - 3 types
   
   * Data registers - 4 types of registers
      
      types           32bit   16bit   16-8    7-0
      -----------------------------------------------
      1. Accumulator   EAX     AX      AH      AL
      3. Base          EBX     BX      BH      BL
      4. Counter       ECX     CX      CH      CL
      5. Data          EDX     DX      DH      DL
   
   2.Pointer registers - 3 types of registers
      
      types                 15-0    32bit
      ------------------------------------
      1.Instruction pointer IP      EIP     
      2.Stack pointer       SP      ESP
      3.Base pointer        BP      EBP
   
   3.Index registers - 2 types of registers
      
      types                 32bit   15-0
      -----------------------------------------------
      1.Source Index        ESI     SI
      2.Destination Index   EDI     DI
   
2. Control registers - a 32bit Instruction pointer register & a 32bit flag resgister combination
  
  9 common flag registers types
    1.Overflow flag(OF)- overflow of a higher order bit(ex.leftmost bit of data after some arithmatic operation) 
    2.Direction flag(DF)- left or right direction moving(ex.strings comparision)
    3.Interrupt flag(IF)- external input devices like keyboard interrupt control flag(enable-1/disable-0)
    4.Trap flag(TF) - allows to set the operation of the processor in sigle step mode
    5.Sign flag(SF) - take the sign of the result
    6.Zero flag(ZF) - if zero then 1 else 0 for non-zero
    7.Auxiliary Carry flag(AF) - contains carry bit from leftmost bit
    8.Parity flag(PF) - total number of single bits from result(odd=1,even=0)
    9.Carry flag(CF) - contains 0/1 from higher ordered bit/leftmost bit or last bit of shift operation or last bit of rotate operation

3.Segment registers - 3 types
  1.Data Segment(section .data-for constants and section .bss - for variables)
  2.Code Segment(section .text - main area in application)
  3.Stack Segment(contains data and any return addresses of any function)
  


Register Addressing - different ways of addressing modes
--------------------------------------------------------------
mov eax,4 ;immediate addressing mode ; The system call for write(sys_write) eax - general data accumulator register and 4 its write mode,tells the system to write
mov ebx.1                 ; File descriptor 1 - standard output
mov ecx,constant/varible  ; Put the offset of variable/constant in ecx
mov edx                   ; its print mode, prints what we put in eax,4
mov eax,1                 ; The system call for exit (sys_exit)
mov ebx,0                 ; Exit with return code of 0 (no error)

direct addressing mode ---- variable/constant
direct offset addressing mode
indirect memory addressing mode --- example moving variable/constant/direct data in ebp/general base pointer register 
                                    and addressing that pointer register to access data


     ;8421
4 = 0b0100

defining points - use in constants
--------------------------------------
db - define byte - 1 byte
dw - define word - 2 byte
dd - define doubleword - 4 bytes
dq - define quadword - 8 bytes
dt - define ten bytes - 10 bytes

allocating storage space for uninitialize data - use in variable
-------------------------------------------------------------------
resb - reserve byte - 1 byte
resw - reserve word - 2 bytes
resd - reserve doubleword - 4 bytes
resq - reserve quadword - 8 bytes
rest - reserve ten bytes - 10 bytes

TIMES <value> ; used for repeating a value of variable

Constant
-----------------------
CONSTANT_NAME: <value> ;this tyoe of constant cannot be reassigned or redefined
%assign CONSTANT_NAME <numeric_value> ; this type of constant can be reassigned or redefined only numeric constant can be defined
%define CONSTANT_NAME <numeric/string_value> ; same as %assign bt it can be string constant also

Increment/Decrement
---------------------------
inc register/[variable] ; to increment numerical value
dec register/[variable] ; to decrement numerical value(including newline character)

Addition , Subtraction, multiplication, division
------------------------------------------------------
add register1,register2 ; register1 = register1+register2
sub register1,register2 ; register1 = register1-register2
mul register ; unsigned data multiplication
imul register ; unsigned data multiplication
div register ; unsigned data division
idiv register ; unsigned data division

bitwise operators
------------------------
and register1,register2
or register1,register2
xor register1,register2
not register

Compare instruction
-------------------------
cmp register, value
Label: ; label declaration
jmp ; unconditional jump

  conditional jumps
  -----------------
  ja/jnbe - above/not below nor zero
  jae/jnb - above or equal/not below
  jb/jnae - below or not above nor equal
  jbe/jna - below or equal/ not above
  jc - carry
  je/jz - equal/zero
  jg/jnle - greater/not less not equal
  jge/jnl - greater or equal/not less
  jl/jnge - less/not greater nor equal
  jle/jng - less or equal/not greater
  jnc - not carry

ASCII number system
------------------------
mov register, number
mov [variable], register

mov ecx, variable
mov edx, length

int kernal ; call kernal

output: character from ASCII code of number
------------------------

Function
--------------
function_name:
  code
  ret ; return

call function_name

Stacks Data Structure (LIFO-Last in First Out)
-------------------------
push
pop
(don't understand yet)

