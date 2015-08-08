.global main
.func main

main:
        BL _getOperand          @ branch to _getOperand
        MOV R6, R0              @ move return value from R0 to R6
        BL _getOperand          @ branch to _getOperand
        MOV R7, R0              @ move return value from R0 to R7
        MOV R1, R6              @ move from R6 to R1
        MOV R2, R7              @ move from R7 to R2
        BL GCD_ITERATIVE        @ branch to GCD_ITERATIVE
        MOV R1, R0              @ move return value from R0 to R1
        BL _displayPromptComputation    @ branch to _displayPromptComputation 
        B main                  @ calling main  so that it works as loop

_getOperand:
        MOV R4, LR               @ store LR since printf call ourselves
        SUB SP, SP, #4           @ make room for stack
        LDR R0, =prompt_operand  @ R0 contains address of format string
        BL printf                @ call printf
        LDR R0, =user_input      @ R0 contains address of format sting
        MOV R1, SP               @ move SP to R1 to store entry of stack
        BL scanf                 @ call scanf
        LDR R0, [SP]             @ load value at SP into R0
        ADD SP, SP, #4           @ restore the stack pointer
        MOV PC, R4               @ return

GCD_ITERATIVE:
        MOV R8, R2              @ move the (parameter or) R2 to R8
        B _loopThroughMain      @ branch to _loopThroughMain
        _iterate:
                MOV R1, R6      @ move the value at R6 to R1
                MOV R2, R7      @ move the value at R7 to R2
                SUB R8, R8, #1  @ Substract 1 from R8 and copy to R8
                B _iterateMain; @ branch to _iterateMain

        _loopThroghMain:
                B _switchIterate        @ branch to _switchIterate
                
                _switchIterateOnce:     
                        SUB R1, R1, R8  @ Substract R8 from R1 and copy to R1

                _switchIterate:
                        CMP R1, R8              @ compare R1 and R8
                        BHS _switchIterateOnce  @ branch to _switchIterateOnce using Unsigned comparison gave higher or same result

                B _switchIterateTwice           @ branch to _switchIterateTwice
                _switchIterate2:
                        SUB R2, R2, R8          @ Substract R2 from R8 and copy to R2
                        
                _switchIterateTwice:
                        CMP R2, R8              @ compare R2 and R8
                        BHS _switchIterate2     @ branch to _switchIterateOnce using Unsigned comparison gave higher or same result

                MOV R5, R1                      @ move the value at R1 to R5
                MOV R9, R2                      @ move the value at R2 to R9
                CMP R5, #0                      @ compare R1 and 0
                BNE _iterate                    @ branch not equal to _iterate
                MOV R0, R8                      @ move the value at R8 to R0
                MOV PC, LR                      @ return

_return:
        MOV R0, R8                              @ move the value at R8 to R0
        MOV PC, LR                              @ return

_displayPromptComputation:
        MOV R4, LR                              @ store LR since printf call ourselves
        LDR R0, =display_format                 @ R0 contains address of format sting
        BL printf                               @ branch link to printf
        MOV PC, R4                              @ return

.data
prompt_operand:
        .asciz "Please enter the positive Integer: "
user_input:
        .asciz "%d"
display_format:
        .asciz "The gcd of two positive integers is:  %d \n"



        
        
        
