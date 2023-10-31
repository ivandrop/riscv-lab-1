// Lab 1 template file
.data
.global lowercase_string
lowercase_string:
    // Specify a string ending with '\0'
    // The lowercase 'e' in eCE is not a typo!
    // You'll convert it to uppercase later.
    .asciz "eCE 362 is awesome!"

.global login_name
login_name:
    .asciz "iandreop"

.global puid
puid:
    .asciz "0033426341"

// Align to 4bytes boundary as we have a string above
.balign 4

.text

.global q2_1_example
q2_1_example:
    // Assembly example
    /* Enter your code after this comment */
    add x10, x10, x11  // x10 = x10 + x11
    add x12, x12, x13  // x12 = x11 + x12
    add x10, x10, x12  // x10 = x10 + x11 + x12 + x13
    /* Enter your code above this comment */
    ret


.global q2_2_delta
q2_2_delta:
    // Compute the discriminant of a quadratic
    // function: b^2 - 4ac
    // x10: a
    // x11: b
    // x12: c
    // Put result back in x10

    /* Enter your code after this comment */
    mul x11, x11, x11  // x11 = x11 ^ 2 (b^2)
    li x28, 4  // x28 = 4
    mul x10, x28, x10  // x10 = 4 * x10 (4a)
    mul x10, x10, x12  // x10 = x10 * x12 (4ac)
    sub x10, x11, x10  // x10 = x11 - x10 (b^2 - 4ac)
    /* Enter your code above this comment */
    ret


.global q2_3_dot_product
q2_3_dot_product:
    // Compute the dot product of two 2-D vectors
    // dot(A, B) = a1b1 + a2b2
    // x10: a1
    // x11: a2
    // x12: b1
    // x13: b2
    // Put result back in x10

    /* Enter your code after this comment */
    mul x10, x10, x12  // x10 = x10 * x12 (a1b1)
    mul x11, x11, x13  // x11 = x11 * x13 (a2b2)
    add x10, x10, x11  // x10 = x10 + x11 (a1b1 + a2b2)
    /* Enter your code above this comment */
    ret

.global q3_1_MSB
q3_1_MSB:
    // Extract the MSB of the incoming
    // 32-bit word and store in register
    // x10

    /* Enter your code after this comment */
    srli x10, x10, 24  // x10 = x10 >> 24
    /* Enter your code above this comment */
    ret

.global q3_1_LSB
q3_1_LSB:
    // Extract the LSB of the incoming
    // 32-bit word and store in register x10
    
    /* Enter your code after this comment */
    andi x10, x10, 0xff  // x10 = x10 & 0xff
    /* Enter your code above this comment */
    ret

.global q3_2_flag_set
q3_2_flag_set:
    // Set the flag of a 32-bit value to 1
    // value: x10
    // flag:  x11
    // Put result back in x10

    /* Enter your code after this comment */
    or x10, x10, x11  // x10 = x10 | x11
    /* Enter your code above this comment */
    ret

.global q3_2_flag_reset
q3_2_flag_reset:
    // Set the flag of a 32-bit value to 0
    // value: x10
    // flag:  x11
    // Put result back in x10

    /* Enter your code after this comment */
    xori x11, x11, 0xffffffff  // x11 = ~x11
    and x10, x10, x11  // x10 = x10 & x11
    /* Enter your code above this comment */
    ret

.global q3_2_flag_toggle
q3_2_flag_toggle:
    // Toggle the flag of a 32-bit value
    // value: x10
    // flag:  x11
    // Put result back in x10

    /* Enter your code after this comment */
    xor x10, x10, x11  // x10 = x10 ^ x11
    /* Enter your code above this comment */
    ret

.global q3_3_swap_byte
q3_3_swap_byte:
    // Swap the LSB and MSB of a 32-bit word

    /* Enter your code after this comment */
    andi x28, x10, 0xff  // LSB of x10
    slli x28, x28, 24  // Move LSB to MSB position
    srli x29, x10, 24  // MSB of x10

    slli x10, x10, 8  // Clear MSB
    srli x10, x10, 16  // Clear LSB
    slli x10, x10, 8  // Shift back into place

    or x10, x10, x29  // Add in MSB
    or x10, x10, x28  // Add in LSB

    /* Enter your code above this comment */
    ret

.global q4_1_toupper
q4_1_toupper:
    // Take in an address of a lowercase letter and save its uppercase form
    // to that address

    /* Enter your code after this comment */
    lb x28, 0(x10)  // Load value into temp x28
    li x29, 32  // Offset from CAPS to lowercase
    sub x28, x28, x29  // Subtract 32 from the value
    sb x28, 0(x10)  // Store back into address
    /* Enter your code above this comment */
    ret

.global q4_2_swap
q4_2_swap:
    // Take two 32-bit integers addresses and swap the content

    /* Enter your code after this comment */
    lw x28, 0(x10)  // Load x10
    lw x29, 0(x11)  // Load x11

    sw x29, 0(x10)  // Store x10
    sw x28, 0(x11)  // Store x11
    /* Enter your code above this comment */
    ret

.global q4_3_cutter
q4_3_cutter:
    // Take two arguments, a C character string starting address and a cut position
    // Passed in x10 and x11 respectively
    // After the function return, the string will be cut to position in register x11
    // i.e. string "Hello World!" with cut position 5 will results in "Hello"

    /* Enter your code after this comment */
    li x13, 0  // Null '\0' Terminator
    add x28, x10, x11  // Set x28 to the address of the null terminator
    sb x13, 0(x28)  // Store null terminator at new address
    /* Enter your code above this comment */
    ret

.global q4_4_cvt_endian
q4_4_cvt_endian:
    // Take in an 32-bit integer and reverse its endianness

    /* Enter your code after this comment */
    lw x5, 0(x10)
    
    slli x28, x5, 24  // New MSB
    slli x29, x5, 16
    srli x29, x29, 24
    slli x29, x29, 16  // New 2nd-Byte
    srli x30, x5, 16
    slli x30, x30, 24
    srli x30, x30, 16  // New 3nd-Byte
    srli x31, x5, 24  // New LSB

    li x5, 0  // Clear x10
    
    or x5, x5, x28  // MSB
    or x5, x5, x29  // 2
    or x5, x5, x30  // 3
    or x5, x5, x31  // LSB

    sw x5, 0(x10)
    /* Enter your code above this comment */
    ret
