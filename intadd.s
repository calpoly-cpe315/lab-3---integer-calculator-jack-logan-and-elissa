    // intadd function in this file

    .arch armv8-a
    .global intadd

intadd:
    //input parameters
        //in
            //x0 = numA
            //x1 = numB
        //out
            //x0 = sum

    /*
    //reference code

    // Iterate till there is no carry
    while (y != 0)
    {
        // carry should be unsigned to
        // deal with -ve numbers
        // carry now contains common
        //set bits of x and y
        unsigned carry = x & y;
 
        // Sum of bits of x and y where at
        //least one of the bits is not set
        x = x ^ y;
 
        // Carry is shifted by one so that adding
        // it to x gives the required sum
        y = carry << 1;
    }
    return x
    */

    stp     x29, x30, [sp, #-48]! // Store FP, LR
    mov     x29, sp
    //Calle Setup
    stp x19, x20, [sp, 16]
    stp x21, x22, [sp, 32]

    //start add
        //x19 = numA
        //x20 = numB
        //x21 = carry
    //make copy of input registers
    mov x19,x0
    mov x20,x1
        //Note to self might have to store to stack snce callee saved
    
    loop:
        cmp x20, #0
        b.eq endloop     //if carry == 0, end loop
        and x21, x19, x20       //carry = x & y;
        eor x19, x19, x20       //x = x ^ y;
        lsl x20, x21, #1                //y = carry << 1;
        b loop

    endloop:
        mov x0,x19      //set output parameter
        ldp x19, x20, [sp, 16]     //x19 = numA, x20 = numB
        ldp x21, x22, [sp, 32]     //x21 = carry1 x22 = carry2
        ldp    x29, x30, [sp], 48  // Caller Teardown
        ret
