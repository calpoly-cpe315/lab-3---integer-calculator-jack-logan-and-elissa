    // intmul function in this file

    .arch armv8-a
    .global intmul

intmul:
    stp x29, x30, [sp, -16]!
    mov x29, sp

    mov x23, x0 // numA
    mov x24, x1 // numB
    mov x25, #0 // result
loop:

    cmp x24, 0
    b.eq endfunc

    // result += a
    mov x0, x25
    mov x1, x23
    bl intadd
    mov x25, x0
    
    // b -= 1
    mov x0, x24
    mov x1, #1
    bl intsub
    mov x24, x0

    b loop

endfunc:
    mov    x0, x25
    ldp    x29, x30, [sp], 16
    ret
