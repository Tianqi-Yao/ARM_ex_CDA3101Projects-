.data
stringFmt: .asciz "%d%d %c"
newLine: .asciz "\n"
output: .asciz "%d"
input1_buffer:    .space 256
input2_buffer:    .space 256
input3_buffer:    .space 1
prompt: .asciz "Data:"
prompt2: .asciz "Error\n"

.text
.global main

main:

ldr x0, =prompt
bl printf

ldr x0, = stringFmt
ldrsw x1, = input1_buffer

ldrsw x2, = input2_buffer

ldrsw x3, =input3_buffer

bl scanf

ldrsw x1, = input1_buffer

ldrsw x2, = input2_buffer

ldrsw x3, =input3_buffer


# Load register x20 with the address of the input

ldrsw x20, [x1]
ldrsw x21, [x2]
ldrb w22, [x3]

bl label

 #print the value of the requested operation
ldr x0, =output
bl printf

#flush the buffer
ldr x0, =newLine
bl printf

exit:
#exit from the program
mov x0, #0
mov x8 ,#93
svc #0


label:
# 42 is the ASCII value of *
cmp x22, #42
b.eq MUL

#43 is the ASCII value of +
cmp x22, #43
b.eq ADD

#45 is the ASCII value of -
cmp x22, #45
b.eq SUB

#47 is the ASCII value of /
cmp x22, #47
b.eq DIV




MUL:
 MUL x2, x20, x21
 mov x1, x2
br x30

ADD:
 add x2, x20, x21
 mov x1, x2
br x30

SUB:
sub x2, x20, x21
mov x1, x2
br x30 //takes back to the next function immediately after b.eq SUB

DIV:
cbz w21, zero
SDIV w2, w20, w21          // X0 = X1 / X2 (signed, 64-bit divide)\
mov w1, w2
br x30
zero:
ldr x0, =prompt2

bl printf

b exit
