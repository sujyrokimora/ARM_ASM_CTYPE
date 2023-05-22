.section .text
.global _start
.arm

_start:
 LDR R0,= str1
 LDR R1,[R0]


 CMP R1, #0x00000030  //hexa para o numero 0
 BLT _false // se o enfreço do r0 for maior que o endreço do 0

 CMP R1, #0x0000007B //z
 BGT _false // se mais alto que z

CMP R1, #0x00000041 //ultimo numero
 BLT _false // no caso de A ser menor que que o r0

 CMP R1, #0x0000003A //ultimo numero
 BLT _true // no caso de : ser maior que que o r0

 CMP R1, #0x0000005A //ultimo numero
 BLT _true // no caso de : ser maior que que o r0



    B _false

_true:
    //MOV R2, #1
    //MOV R7, #4
    //SVC #0

    BLT _exit

_false:
    //MOV R1, #0
    //PUSH {R1}
    //POP {R1}
    BLT _exit

_exit:
    MOV R7, #1
    SVC #0
.data
   str1: .asciz "Y"