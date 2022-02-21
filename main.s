    // Template main.s file for Lab 3
    // Jack Meyers, Elissa Covarrubias, Logan Cable

    .arch armv8-a

    // --------------------------------
    .global main
main:
    // driver function main lives here, modify this for your other functions
    
    // each register = 64bits = 8bytes = 8addresses
    // 2 registers = 16 addresses for FP, LR
       stp     x29, x30, [sp, -48]! // Store FP, LR    + reserve space for 4 more registers
       mov     x29, sp
    // Save callee registers
       stp x24, x25, [sp, 16]
       stp x26, x27, [sp, 32]

    // A + B = C
    // x24 = A
    // x25 = B
    // x26 = C
    
intcalc:

    // Get number 1
       ldr     w0, =enterstring1
       bl      printf
       ldr     x0, =number
       mov     x1, sp               // Save stack pointer to x1, you must create space
       bl      scanf                // Scan user's answer
       ldr     x0, [sp]             // Put the user's value in r0
       mov     x24,x0               // Store A
    // Get number 2
       ldr     w0, =enterstring2
       bl      printf
       ldr     x0, =number
       mov     x1, sp               // Save stack pointer to x1, you must create space
       bl      scanf                // Scan user's answer
       ldr     x0, [sp]             // Put the user's value in r0
       mov     x25,x0               // Store B

    // Get operation
       ldr     w0, =enterstring3
       bl      printf
       ldr     w0, =opchar
       mov     x1, sp               // Save stack pointer to x1, you must create space
       bl      scanf                // Scan user's answer
       ldr     x1, =star            // Put address of 'star' in x1
       ldrb    w1, [x1]             // Load the actual character 'star' into x1
       ldrb    w0, [sp]             // Put the user's value in x0
       mov     w2, w0               // Move the user's value in x2
       mov     w3, w1               // Move the actual character in x3
       mov     x0,x24
       mov     x1,x25
       cmp     w2, w3               // Compare user's answer to char 'star'
       b.eq    starcalc
    // Check if Add
       ldr     x3, =add
       ldrb    w3, [x3]
       cmp     w2, w3
       b.eq    addcalc
    // Check if sub
       ldr     x3, =sub
       ldrb    w3, [x3]
       cmp     w2, w3
       b.eq    subcalc
    // Print invalid operator
       ldr     w0, =invalid
       bl      printf
       b       loop                 // Invalid operation branch to again

starcalc:
       bl      intmul
       mov     x26,x0
       b       out

addcalc:
       bl      intadd
       mov     x26,x0
       b       out

subcalc:
       bl      intsub
       mov     x26,x0
       b       out

out:   stp     x29, x30, [sp, -16]!
       mov     x1,x26
       ldr     x0, =outstring
       bl      printf
       ldp     x29, x30, [sp], 16   // Restore FP, LR
       b       loop

    // You'll need to scan characters for the operation and to determine
    // if the program should repeat.
    // To scan a character, and compare it to another, do the following
loop: 
    // Again prompt
       ldr     w0, =again
       bl      printf
    // Used for again detection
       ldr     w0, =scanchar
       mov     x1, sp               // Save stack pointer to x1, you must create space
       bl      scanf                // Scan user's answer
       ldr     x1, =yes             // Put address of 'y' in x1
       ldrb    w1, [x1]             // Load the actual character 'y' into x1
       ldrb    w0, [sp]             // Put the user's value in r0
       cmp     w0, w1               // Compare user's answer to char 'y'
       b.eq    intcalc
       b       endcalc              // Branch to appropriate location

endcalc:
    // Restore Registers
       ldp     x24, x25, [sp, 16]
       ldp     x26, x27, [sp, 32]
       ldp     x29, x30, [sp], 48   // Caller Teardown
       ret


//Again?
yes:
    .byte      'y'
scanchar:
    .asciz     " %c"
again:
    .asciz     "Again? "

//Operation
opchar:
    .asciz     " %c"
star:
    .byte      '*'
add:
    .byte      '+'
sub:
    .byte      '-'
invalid:
    .asciz     "Invalid Operation Entered.\n"

//Input Prompt
number:
    .asciz     "%ld"
enterstring1:
    .asciz     "Enter Number 1: "
enterstring2:
    .asciz     "Enter Number 2: "
enterstring3:
    .asciz     "Enter Operation: "

//Output Prompt
outstring:
    .asciz     "Result is: %ld\n"
