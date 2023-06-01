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
  LDRB R2, [R1, #0] @ Read byte caracter.
  MOV R3, #0
  BL isadigit
   BL islower      @ Call islower().
   BL isupper      @ Call isupper
  MOV  R1, R3      @ R1=R3
  LDR  R0, =out    @ Loads R0 from out var
  BL   printf      @ Calls printf
  B   _exit        @ Exit the program


isadigit:
  PUSH {LR}
  CMP   R2, #'0'     @ If R2<0
  MOVLT R3, #0       @ Then R3=0
  BLT   exit_isalnum @ Exit this prevents the NEXT CMP from being true
  CMP   R2, #'9'     @ If R2>=9
  MOVLE R3, #1       @ Then R3=1
  POP {LR}
  BX LR   

islower:
  PUSH {LR}
  CMP   R2, #'a'     @ If R2<a
  # MOVLT R3, #0     @ 
  BLT   exit_isalnum @ Exit
  CMP   R2, #'z'     @ If R2>z
  MOVLT R3, #1       @ Then R3=1
  POP {LR} 
  BX LR

isupper:
  PUSH {LR}
  CMP   R2, #'A'     @ If R2<A
  # MOVLT R3, #0     @ 
  BLT   exit_isalnum @ Exit
  CMP   R2, #'Z'     @ If R2<Z
  MOVLE R3, #1       @ Then R3=1
  POP {LR}
  BX LR   
  

exit_isalnum:
 BX   LR            @ return;
    
_exit:
  MOV R7, #1         @ Exit syscall
  SVC 0              @ Invoke
