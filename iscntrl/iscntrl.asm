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
  BL   isaprint     @ Call isaprint
  MOV  R1, R0       @ Ajustar segundo parâmetro do printf com o valor de retorno.
  LDR  R0, =out     @ Carregar string de saída como primeiro parâmetro do printf.
  BL   printf       @ Chamar printf para mostrar o resultado.
  B   _exit         @ Pedir ao SO para sair do programa.


isaprint:
  CMP   R0, #0x20    @ If R0<#0x20==" " 
  MOVLT R0, #1       @ Then R3=1
  BLT   exit_islower @ Exit this prevents the NEXT CMP from being true
  CMP   R0, #0x7E    @ If R2>=z.
  MOVGT R0, #1       @ Then R0=1
  BGT   exit_islower @ Exit
  MOVLE R0, #0       @   
  
  exit_islower:
  BX   LR            @ return;
    
_exit:
  MOV R7, #1         @ Exit syscall
  SVC 0              @ Invoke
