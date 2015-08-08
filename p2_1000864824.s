.global main
.func main

main:
        BL _getOperand
        MOV R6, R0
        BL _getOperand
        MOV R7, R0
        MOV R1, R6
        MOV R2, R7
        BL GCD_ITERATIVE
        MOV R1, R0
        BL _displayPromptComputation
        B main

_getOperand:
        MOV R4, LR
        SUB SP, SP, #4
        LDR R0, =prompt_operand
        BL printf
        LDR R0, =user_input
        MOV R1, SP
        BL scanf
        LDR R0, [SP]
        ADD SP, SP, #4
        MOV PC, R4

GCD_ITERATIVE:
        MOV R8, R2
        B _loopThroughMain
        _iterate:
                MOV R1, R6
                MOV R2, R7
                SUB R8, R8, #1
                B _iterateMain;

        _loopThroghMain:
                B _switchIterate
                
                _switchIterateOnce:
                        SUB R1, R1, R8

                _switchIterate:
                        CMP R1, R8
                        BHS _switchIterateOnce

                B _switchIterateTwice
                _switchIterate2:
                        SUB R2, R2, R8
                        
                _switchIterateTwice:
                        CMP R2, R8
                        BHS _switchIterate2

                MOV R5, R1
                MOV R9, R2
                CMP R5, #0
                BNE _iterate
                MOV R0, R8
                MOV PC, LR

_return:
        MOV R0, R8
        MOV PC, LR

_displayPromptComputation:
        MOV R4, LR
        LDR R0, =display_format
        BL printf
        MOV PC, R4

.data
prompt_operand:
        .asciz "Please enter the positive Integer: "
user_input:
        .asciz "%d"
display_format:
        .asciz "The gcd of two positive integers is:  %d \n"



        
        
        
