# Notes on Assembly
---

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
  1. ax - typically used as an acummulator & preferred for most operations.
    * __mov__ = is used to read from a memory address. cs code segment would be it's segment & it will read from offset of that segment.
    ```assembly
    mov ax, [memory_offset]
    ```
  2. bx - base register, typically used to hold an address of a procedure/variable
    * __mov__ = is used to hold the offset address of the memory to write/access. ds register holds the segment byte.
    ```assembly
    mov bx, memory_offset
    mov [bx], value
    ``` 
  3. cx - this register is used for counting operations. typically used for looping.
  4. dx - data register, typically used for multiplication & division.
  > we can set immediate values to general purpose registers.
  >
  > General Purpose registers are divided by highs byte (ex. ah) and low bytes (ex. al)

* **Segment registers - total 4**
	the cpu has four segment registers used as base location for program instructions data or stack
  1. cs - code segment. it sets/holds segment address of current memory.
  2. ss - stack segment. it holds segment address of current stack.
  3. ds - data segment register. First byte of the memory address. to write in the memory data segment register is used. 
  4. es - extra segment/ additional base location for variables in memeory.

* **Index registers - total 4**
  The index registers contains offset from its segment registers.
  
  1. si - source index. it is used in copying strings. ```lodsb``` & ```stosb``` instructions use si register.
  2. di - destination index also used in copying strings
  3. sp - stack pointer. it holds offset address of current stack/ stack's top.
  4. bp -  base pointer. it's the offset from the ss register to locate variables on the stack
  
* **Instruction pointer registers** 
  1. ip - instruction pointer. it sets/holds offset address of current memory. it points to the next instruction that should be executed.
  > Code segment & Index pointer read current memeory

  * we cannot set immdiate value to segment registers, we have to use other register such as general purpose register to set the value of an segment register.
    ```assembly
    ; manually set the value of a segment register
    mov general_reg, value
    mov seg_reg, general_reg  
    ```

* **Flag Registers**
	* There are 9 flags
	
### Flag states (x86)

	* 1 = set
	* 0 = reset/clear
	
	**There are two groups of flags**
	1. control flags - control cpu instructions. 
	2. status flags - reflect outcome of arithmatic & logical operations performed by cpu
		* Overflow(of) - set when the result of an **singed arithmetic** operation is too large to fit into the destination.
		* Sign (sf) - set when the result of an arithmetic or logical operation is **negative**
		* Zero (zf) - set when the result of an arithmetic or logical operation is **zero**
		* Carry (cf) - set when the result of an **unsinged arithmetic** operation is too large to fit into the destination.
		* Parity (pf) - set if **least significant byte** int the result contains an **even number** of 1 bits. typically used for **error** checking.
		* Auxiliary Carry (ac) - set when an arithmetic operation causes a **carry** from **bit 3 to bit 4 in an 8-bit operand** 
		
## x86 SIMD & Floating-point registers

> SIMD = Single Instruction Multiple Data

### MMX Registers

* For advanced multimedia and communication applications.
* Supports SIMD
* Pentium Processors were first to have them.
* Numbers: 8
* Type: 64 bit

* MMX instructions operate in perallel on data values contained in the MMX registers or do they appear to be seperate registers. MMX register names are in fact aliases to the same registers used by the floating point unit. 

### XMM Registers

* Numbers: 8
* type: 128 bit
* these are used by stream in SIMD extensions in the instruction set.

### Floating-point unit

* Floating-point unit is sometimes called x87 architecture. It can perform high speed floating point arithmetic.

**data registers**
* Numbers: 8 ST(1) to ST(8)
* type: 80-bit
* organized as stack

**pointer registers**
* Numbers : 2 (FPU Instruction Pointer & FPU Data Pointer)
* type: 48 bit

> FPU = Floating Point Unit

**Control Registers**
* Numbers: 3 (Tag Register, Control Register, Status register)
* type : 16 bit

* Op code register 

## i80386 processor architecture(x86 32-bit)

***Registers:***
	1. General Purpose registers (32-bit) - 8
	2. Segment Registers (16-bit) - 6
	3. Instruction Pointer (EIP) - 1
	4. Processor Status Flags Register (EFLAGS) - 1
	
### General Purpose Registers of i80386 (32 bit)
	1. eax
	2. ebx
	3. ecx
	4. edx
	** specialized registers : these are index registers**
	5. ebp
	6. esp
	7. esi
	8. edi
	
### Segment Registers of i80386 (16-bit)
	1. cs
	2. ds
	3. ss
	4. es
	5. fs
	6. gs
	
### Instruction pointer register (32-bit)
	1. eip
	
### Processor Status Flags Register (32-bit)
	1. eflags

## Pantium 4 microprocessor architecture (x86_64 bit/ x64)

*** Registers :***
	1. General purpose registers (64-bit) - 16
	2. Instruction pointer register (64-bit) - 1
	3. Processor Status Flags Register (64-bit) - 1
### General purpose registers (64-bit)
	1. rax
	2. rbx
	3. rcx
	4. rdx
	5. rbp
	6. rsp
	7. rsi
	8. rdi
	9. r8
	10. r9
	11. r10
	12. r11
	13. r12
	14. r13
	15. r14
	16. r15

### Instruction pointer register (64-bit)
	1. rip
	
### Processor Status Flags Register (64-bit)
	1. rflags
	
## Overview of x86 Memory Models

1. Real mode

### Real-Address Mode
	* Only __1MB__ of memory can be addressed.
	* From 00000 to fffff
	* Processor can run only one program at a time
	* Application programs can access any memory location.
	
### Protected Mode
	* Processor can run only multiple programs at a time.
	* Each running program is assigned __4GB__ of memory.
	* Programs cannot access each other's code and data.
	
### Virtual-8086 Mode
	* Processor creates a virtual 8086 machine with its own __1MB__ address space.
	
## x86 Integers

***Syntex***
```
+/- digits radix
```

### Radix table

| Symbol | Meaning      |
| ------ | ------------ |
| H		 | Hexadecimal  |
| r 	 | Encoded real |
| q/o	 | Octal		|
| t		 | Decimal		|
| d		 | Decimal		|
| y		 | Binary		|
| b		 | binary		|

### Integer Precedence

1. () : Parantheses
2. +,- : unary plus, unary minus
3. \*,/ : Multiply, Divide
4. MOD : Modulus
5. +,- : Add, Subtract

## x86 Directives

* Assist and control assembly process.
* Are also called __pseudo-ops__
* Not part of the __instruction set__
* They change the way code is assembled.

Some directives:
1. ```.code``` : Indicates the start of a code segment.
2. ```.data``` : Indicates the start of a data segment.
3. ```.stack``` : Indicates the start of a stack segment.
4. ```.end``` : Marks the end of a module
5. ```.dd```/```.dword``` : Allocate a double word (4 bytes) storage. 

## x86 Instruction

***Syntex***
```
[label:] mnemonic [operands] [;comment] 
```

* A statement that becomes executable when a program is assembled.
* Are translated by assembler into machine language bytes.



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

