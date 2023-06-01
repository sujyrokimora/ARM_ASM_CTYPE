@ Data Section
.data
in: .asciz "0"           @ Input string
out:  .asciz "Result: %d\n" @ Output string

.global printf  @ Write to console output
.global scanf   @ Read from console input
.section .text
.global main
.arm

main:
  LDR  R1, =in      @ Charge string with caracter.
  LDRB R0, [R1, #0] @ Read byte caracter.
  BL   isaprint      @ Call islower().
  MOV  R1, R0       @ Ajustar segundo parâmetro do printf com o valor de retorno.
  LDR  R0, =out     @ Carregar string de saída como primeiro parâmetro do printf.
  BL   printf       @ Chamar printf para mostrar o resultado.
  B   _exit        @ Pedir ao SO para sair do programa.

/*
 * islower(R0)
 * R0 - char
 */
isaprint:
  CMP   R0, #0x21    @ Check if R0 value is < code char '[NULL]'.
  MOVLT R0, #1       @ If true is not lower, return 0.
  BLT   exit_islower @ Exit
  CMP   R0, #0x7E     @ Check if R0 value is > char '[UNIT SEPARATOR]'.
  MOVGT R0, #1       @ If true is not lower, return 0.
  BGT   exit_islower @ Exit
  MOVLE R0, #0       @   
  
  exit_islower:
  BX   LR            @ return;
    
_exit:
  MOV R7, #1         @ Exit syscall
  SVC 0              @ Invoke
