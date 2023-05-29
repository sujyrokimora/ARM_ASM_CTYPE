@ Aula AC 1805/2023
@ Code Section
.section .text
.global _start
.arm

_start:
    LDR R1, =str @ Memory address of the string to printed
    LDR R4,= str1
    BL _cout
    B _exit

_cout:
    PUSH {LR} @ Keep LR - Link Regster in stack
    BL _strlen
    MOV R2, R0 @ Lenght of the string to print
    POP {LR} @ Return last LR value
    MOV R0, #1 @ 1=StdOut
    MOV R7, #4 @ Linux write system call (R7 = #4 -> print stdout)
    SVC 0 @ Call Linux to print the string
    BX LR

_strlen:
    MOV R0, #0
loop_str:
    LDRB R3, [R1, R0]
    ADD R0, #1
    CMP R3, #0
    BNE  loop_str
    SUB R0, #1
    BX LR

_exit:
MOV R7, #1 @ Linux write system call (R7= #1 - exit)
SVC #0 @ Call Linux to exit

.data
str: .asciz "aaaa\n"
str1:.asciz "bbbbbbb\n"