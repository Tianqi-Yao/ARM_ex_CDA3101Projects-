# CDA3101Projects-
A collection of CDA3101 Projects 

## Project 1
Write an ARM program that implements a simple four-function calculator and prompts the user to enter a pair of decimal integers (A and B) followed by a character that specifies one of the operators:

* ‘+’ for addition to compute A+B                            

* ‘-‘ for subtraction to compute A-B

* ‘*’ for multiplication to produce the product A*B

* ‘/’ for division to produce the quotient A/B.

* Input should be the pair of numbers followed by the operand followed by a return.

* For example

5 5 + [enter]

Your program should display the result produced by performing the indicated operation on the two input operands A and B. Only the four operators listed above should be allowed and an attempt to divide by zero should be prohibited.


Define a separate function for each of the allowed operators and use the function names ADD, SUB, MUL, and DIV.

 

Upon return from the function, the main program should display the result on the console

## Project 2 
Write an ARM program that takes a string as input, then outputs a string that replaces all the vowels in the input string with 'x'.

Your program should give the following input prompt:

"Input a string: "

Then, your program should output the string with the vowel(s) replaced with x. Your program should terminate upon printing the output.

For example:

Input a string: Hello

Hxllx

## Project 3
Write a recursive program that takes two integers as input and outputs the greatest common divisor.

Use the following algorithm:

// Given two integers m and n:

```
if (m < n)

        gcd(n, m) 

if n is a divisor of m

        gcd(m, n) = n

  else

        gcd (m, n) = gcd (n, m % n)
```
Your program must be recursive.  You must create a function that calls itself, and saves variables to the stack, and creates a stack frame. Your program should restore the stack as it returns from recursive calls.

 

Your program should have the following prompt:

"Enter Two Integers: "

Your program should then output the greatest common divisor then terminate.
