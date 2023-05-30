@ Data Section
.data
in: .asciz "9"           @ Input string
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
  BL islower      @ Call islower().
  BL isupper
  MOV  R1, R3       @ Ajustar segundo parâmetro do printf com o valor de retorno.
  LDR  R0, =out     @ Carregar string de saída como primeiro parâmetro do printf.
  BL   printf       @ Chamar printf para mostrar o resultado.
  B   _exit        @ Pedir ao SO para sair do programa.

/*
 * islower(R0)
 * R0 - char
 */
islower:
  PUSH {LR}
  CMP   R2, #'a'     @ Check if R0 value is < code char 'a'.
  MOVLT R3, #0       @ If true is not lower, return 0.
  BLT   exit_isalnum @ Exit
  CMP   R2, #'z'     @ Check if R0 value is > char 'z'.
  MOVLE R3, #1 
  POP {LR} 
  BX LR

isupper:
  PUSH {LR}
  CMP   R2, #'A'     @ Check if R0 value is < code char 'a'.
  MOVLT R3, #0       @ If true is not lower, return 0.
  BLT   exit_isalnum @ Exit
  CMP   R2, #'Z'     @ Check if R0 value is > char 'z'.
  MOVLE R3, #1
       @
  POP {LR}
  BX LR   
  

exit_isalnum:
 BX   LR            @ return;
    
_exit:
  MOV R7, #1         @ Exit syscall
  SVC 0              @ Invoke
