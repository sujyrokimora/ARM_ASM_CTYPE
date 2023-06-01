@ Data Section
.data
in: .asciz " "           @ Input string
out:  .asciz "Result: %d\n" @ Output string

.global printf  @ Write to console output
.global scanf   @ Read from console input

.section .text
.global main
.arm

main:
  LDR  R1, =in      @ Charge string with caracter.
  LDRB R0, [R1, #0] @ Read byte caracter.
  BL   iswhite      @ Call iswhite
  MOV  R1, R0       
  LDR  R0, =out     @ Loads R0 from out var
  BL   printf       @ Calls printf
  B   _exit         @ Exit the program

/*
 * islower(R0)
 * R0 - char
 */
iswhite:
  CMP   R0, #0x20    @ If R0<" ".
  MOVLT R0, #0       @ Then R0=0
  BLT   exit_iswhite @ Exit this prevents the NEXT CMP from being true
  CMP   R0, #0x20    @ If R0> " "
  MOVGT R0, #0       @ Then R0=0
  BGT   exit_iswhite @ Exit this prevents the NEXT CMP from being true
  MOVLE R0, #1       @ Else R0=1 
  
  exit_iswhite:
  BX   LR            @ return;
    
_exit:
  MOV R7, #1         @ Exit syscall
  SVC 0              @ Invoke
