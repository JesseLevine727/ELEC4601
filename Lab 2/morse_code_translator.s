.syntax unified
.thumb

.global morse_to_char
.type morse_to_char, %function

morse_to_char:
    push {r4, r5, lr}        
    mov r4, r0               
    ldr r5, =morse_table    
    mov r0, #1               

morse_loop:
    ldrb r1, [r4], #1        
    cmp r1, #0               
    beq translate            

    lsl r0, r0, #1           

    
    cmp r1, #'.'             
    beq morse_loop_continue  
    cmp r1, #'-'             
    bne invalid_code		 
    add r0, r0, #1           

morse_loop_continue:
    b morse_loop             

translate:
    cmp r0, #31              
    bhi invalid_code         

    ldrb r0, [r5, r0]        
    cmp r0, #0               
    beq invalid_code         

    pop {r4, r5, pc}         

invalid_code:
    mov r0, #'?'             
    pop {r4, r5, pc}         

.align 4
morse_table:
    .byte '?', '?', 'E', 'T', 'I', 'A', 'N', 'M', 'S'   @ Indices 0-7
    .byte      'U', 'R', 'W', 'D', 'K', 'G', 'O', 'H'   @ Indices 8-15
    .byte      'V', 'F', '?', 'L', '?', 'P', 'J', 'B'   @ Indices 16-23
    .byte      'X', 'C', 'Y', 'Z', 'Q', '?', '?', '?'   @ Indices 24-31
