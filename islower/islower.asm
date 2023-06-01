@ Data Section
.data
in: .asciz "a"              @ Input string
out:  .asciz "Result: %d\n" @ Output string

.global printf  @ Write to console output
.global scanf   @ Read from console input

.section .text
.global main
.arm

main:
  LDR  R1, =in      @ Charge string with caracter.
  LDRB R0, [R1, #0] @ Read byte caracter.
  BL   islower      @ Call islower
  MOV  R1, R0       
  LDR  R0, =out     @ Loads R0 from out var
  BL   printf       @ Calls printf
  BL   _exit        @ Exit the program

islower:
  CMP   R0, #'a'     @ If R0<a
  MOVLT R0, #0       @ Then R0=0
  BLT   exit_islower @ Exit
  CMP   R0, #'z'     @ @If R2>=z
  MOVGT R0, #0       @ Then R0=0
  BGT   exit_islower @ Exit
  MOVLE R0, #1       @ Else R0=1  
  
  exit_islower:
  BX   LR            @ return;
    
_exit:
  MOV R7, #1         @ Exit syscall
  SVC 0              @ Invoke
