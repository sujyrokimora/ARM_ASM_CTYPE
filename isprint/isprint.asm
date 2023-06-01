@ Data Section
.data
in: .asciz "L"           @ Input string
out:  .asciz "Result: %d\n" @ Output string

.global printf  @ Write to console output
.global scanf   @ Read from console input

.section .text
.global main
.arm

main:
  LDR  R1, =in      @ Charge string with caracter.
  LDRB R0, [R1, #0] @ Read byte caracter.
  BL   isaprint     @ Call isprint
  MOV  R1, R0       @ Ajustar segundo parâmetro do printf com o valor de retorno.
  LDR  R0, =out     @ Carregar string de saída como primeiro parâmetro do printf.
  BL   printf       @ Chamar printf para mostrar o resultado.
  B   _exit         @ Pedir ao SO para sair do programa.

/*
 * islower(R0)
 * R0 - char
 */
isaprint:
  CMP   R0, #0x20    @ If R0<" "
  MOVLT R0, #0       @ Then R0=0
  BLT   exit_islower @ Exit this prevents the NEXT CMP from being true
  CMP   R0, #0x7E    @ If R2>=#0x7E 
  MOVGT R0, #0       @ Then R0=0
  BGT   exit_islower @ Exit this prevents the NEXT CMP from being true
  MOVLE R0, #1       @ Else R0=1
  
  exit_islower:
  BX   LR            @ return;
    
_exit:
  MOV R7, #1         @ Exit syscall
  SVC 0              @ Invoke
