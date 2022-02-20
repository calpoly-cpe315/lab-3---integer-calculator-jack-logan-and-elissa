    // intmul function in this file

    .arch armv8-a
    .global intmul

intmul:
    stp x29, x30, [sp, -16]!
    mov x29, sp

    mov x19, x0 // numA
    mov x20, x1 // numB
    mov x21, #0 // result
loop:

    cmp x20, 0
    b.eq endfunc

    // result += a
    mov x0, x21
    mov x1, x19
    bl intadd
    mov x21, x0
    
    // b -= 1
    mov x0, x20
    mov x1, #1
    bl intsub
    mov x20, x0

    b loop

endfunc:

    ldp    x29, x30, [sp], 16
    ret
