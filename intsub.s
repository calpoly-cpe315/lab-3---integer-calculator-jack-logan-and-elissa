    // intsub function in this file

    .arch armv8-a
    .global intsub

intsub:
    stp x29, x30, [sp, -16]!
    mov x29, sp

    mov x19, x0 // 1st number
    mov x20, x1 // 2nd number
    // x21 and x22 are used for carry

loop:
    cmp x20, #0 // continue until carry is 0
    b.eq endloop
    // Carry = ~x & y
    eor x22, x19, 0xFFFFFFFF
    and x21, x22, x20 

    // XOR (or eor I guess)
    eor x19, x20, x19

    // Compute carry
    lsl x20, x21, #1 // shift left
    // loop
    b loop

endloop:
   mov x0, x19
   ldp x29, x30, [sp], 16
   ret



