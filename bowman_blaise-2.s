//CDA3101 Spring 2019
//Programming Assignment 3
//Blaise Bowman
.data
        stringFmt: .asciz "%d%d"
        outputFmt: .asciz "%d"
        prompt:    .asciz "Enter Two Integers: "
        newLine:   .asciz "\n"
        int1buffer: .space 256
        int2buffer: .space 256

.text

.global main

main:
	ldr			x0, =prompt
	bl			printf //Displays the input prompt
	ldr			x0, =stringFmt
	ldrsw		x1, =int1buffer //x1 will be initially treated as M
	ldrsw		x2, =int2buffer //x2 will be initially treated as N
	bl			scanf //scans the two integers
	ldrsw		x1, =int1buffer
	ldrsw		x2, =int2buffer
	ldrsw		x1,[x1,#0]
	ldrsw		x2,[x2,#0]
	ldr			x3, #0 //GCD will be eventually stored in x3, set as zero initially
bl recursion //branches to recursion method

label:
 //after recursive method is complete, it branches back to here
	mov			x1, x3 //moves contents of x3 into x1, for printing
	ldr			x0, =outputFmt //the output format, an integer
	bl			printf //Prints the GCD of M and N
	ldr			x0, =newLine
	bl			printf //clears the buffer
	b			exit //exits the program

exit:
	mov			x0, #0
	mov			x8, #93
	svc			#0

recursion:
 //the recursive method used to find the gcd
	sub			sp, sp, #32 //allocates room for 3 items on stack (needs to be multiple of 16)
	str			x1, [sp,#16]
	str			x2, [sp,#8]
	str			x3, [sp,#0]
	cmp			x1, #0 //compare x1 and 0
	b.lt		neg1st //branches to negative 1st number case
	b.eq		zero1st //branches to zero 1st number case, (special case)
	cmp			x2, #0
	b.lt		neg2nd
	b.eq		zero2nd
	cmp			x1,x2 //compares value of x1 and x2 (M&N)
	b.lt		mgreaterthann //branches to case where M > N
	udiv		x6, x1, x2 //dividend = x1, divisor = x2
	msub		x7, x6, x2, x1 //x6 = quotient, x7 = remainder
	cmp			x7, #0 //if remainder is zero, then x2 is a divisor of x1
	b.eq		ndivisorm //branches to case where x2 is a divsor of x1
	bl			case3 //branches to case 3 if other 2 cases are not met

neg1st:
 //multiplies input by -1
	neg			x1,x1 //multiples x1 by -1 because gcd will need to be positive
	bl			recursion

zero1st:
 //used if the value of he first input is ZERO
	cmp			x2,#0 //compares value of x2 (N) to 0
	b.eq		bothzero //if x2(N) is 0, branches to bothzero
	b.lt		neg2nd
	ldur		x3, [sp,#8]
	bl			label
neg2nd:
	neg			x2,x2
	bl			recursion
zero2nd:
	cmp			x1, #0
	b.eq		bothzero
	b.lt		neg1st
	ldur		x3, [sp,#8]
	bl			label

mgreaterthann:
 //if m>n....M stored in x1, N stored in x2 change to gcd(n,m)

	mov			x8,x2
	mov			x9,x1
	mov			x1, x8
	mov			x2, x9
	bl			recursion

ndivisorm:
 //if N is a divisor of M.... gcd(m,n) = n
	ldur		x1, [sp,#16]
	ldur		x2, [sp,#8]
	ldur		x3, [sp, #8] //the result stored of the GCD calculation (N)
	bl			label
case3:
 //the else case gcd(m,n) = gcd(n,m % n)...will loop until gcd(m,n) = n
        //M is in x1, N is in x2
	mov			x8,x2 //temporarily
	mov			x9,x1 //temporarily
	udiv		x6, x1, x2 //dividend = x1, divisor = x2
	msub		x7, x6, x2, x1 //x6 = quotient, x7 = remainder
	ldur		x1, [x2] //loads value of n in x1 (from GCD(M,x) to GCD(x, M)
	ldur		x2, [x7] //M mod N
	bl			recursion

bothzero:
 //used when both M & N (X1 & X2) are 0.

 #gcd will be zero
	ldur		x1, [sp,#16] //pops off stack
	ldur		x2, [sp,#8] //pops off stack
	ldr			x3, #0 //pops off stack
	bl			label //branches back to label

