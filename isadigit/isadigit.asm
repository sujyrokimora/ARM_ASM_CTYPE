@ Data Section
.data
in: .asciz "1"           @ Input string
out:  .asciz "Result: %d\n" @ Output string

.global printf  @ Write to console output
.global scanf   @ Read from console input

.section .text
.global main
.arm

main:
  LDR  R1, =in      @ Charge string with caracter.
  LDRB R0, [R1, #0] @ Read byte caracter.
  BL   isadigit     @ Call isadigit().
  MOV  R1, R0
  LDR  R0, =out     @ Loads the output string
  BL   printf       @ Calls the print. 
  BL   _exit        @ Exit the program 



isadigit:
  CMP   R0, #'0'     @ If r0<=0
  MOVLT R0, #0       @ Then R0=0
  BLT   exit_islower @ Exit
  CMP   R0, #'9'     @ If else R0>=9.
  MOVGT R0, #0       @ Then R0=0.
  BGT   exit_islower @ Exit
  MOVLE R0, #1       @ Else R0=1  
  
  exit_islower:
  BX   LR            @ return;
    
_exit:
  MOV R7, #1         @ Exit syscall
  SVC 0              @ Invoke
