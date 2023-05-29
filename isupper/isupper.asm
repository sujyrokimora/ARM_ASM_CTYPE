@ Data Section
.data
in: .asciz "A"              @ Input string
out:  .asciz "Result: %d\n" @ Output string

.global printf  @ Write to console output
.global scanf   @ Read from console input

.section .text
.global main
.arm

main:
  LDR  R1, =in      @ Charge string with caracter.
  LDRB R0, [R1, #0] @ Read byte caracter.
  BL   islower      @ Call islower().
  MOV  R1, R0       @ Ajustar segundo parâmetro do printf com o valor de retorno.
  LDR  R0, =out     @ Carregar string de saída como primeiro parâmetro do printf.
  BL   printf       @ Chamar printf para mostrar o resultado.
  BL   _exit        @ Pedir ao SO para sair do programa.

/*
 * islower(R0)
 * R0 - char
 */
islower:
  CMP   R0, #'A'     @ Check if R0 value is < code char 'a'.
  MOVLT R0, #0       @ If true is not lower, return 0.
  BLT   exit_islower @ Exit
  CMP   R0, #'Z'     @ Check if R0 value is > char 'z'.
  MOVGT R0, #0       @ If true is not lower, return 0.
  BGT   exit_islower @ Exit
  MOVLE R0, #1       @   
  
  exit_islower:
  BX   LR            @ return;
    
_exit:
  MOV R7, #1         @ Exit syscall
  SVC 0              @ Invoke
