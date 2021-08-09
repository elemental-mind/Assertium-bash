 # Assertium expression reference
Use this guide to find the right `expression` to your problem, then insert `expression` after your assert function call:
````
assert <Expression>
````

# Integer assertions
| Expression			| Evaluates
|---					|---
|NUMBER1 == NUMBER2 	|True if NUMBER1 is equal to NUMBER2
|NUMBER1 -eq NUMBER2	|True if NUMBER1 is equal to NUMBER2
|NUMBER1 != NUMBER2 	|True if NUMBER1 is not equal to NUMBER2
|NUMBER1 -ne NUMBER2	|True if NUMBER1 is not equal to NUMBER2
|NUMBER1 -ge NUMBER2	|True if NUMBER1 is greater or equal to NUMBER2
|NUMBER1 -gt NUMBER2	|True if NUMBER1 is greater than NUMBER2
|NUMBER1 -le NUMBER2	|True if NUMBER1 is less than or equal to NUMBER2
|NUMBER1 -lt NUMBER2	|True if NUMBER1 is less than NUMBER2

# String assertions
| Expression			| Evaluates
|---					|---
|STRING1 == STRING2 	|True if the strings are equal.
|STRING1 != STRING2 	|True if the strings are not equal.
|STRING1 < STRING2 		|True if STRING1 sorts before STRING2 lexicographically in the current locale.
|STRING1 > STRING2 		|True if STRING1 sorts after STRING2 lexicographically in the current locale.
|-z STRING 				|True of the length if STRING is zero.
|-n STRING 				|True if the length of STRING is non-zero.

# Boolean assertions
| Expression			| Evaluates
|---					|---
|BOOLEAN1 -o BOOLEAN2 	|True if BOOLEAN1 or BOOLEAN2 are true.
|BOOLEAN1 -a BOOLEAN2	|True if BOOLEAN1 and BOOLEAN2 are true.

# Type assertions
| Expression					| Evaluates
|---							|---
|VARIABLE is Number 			|True if VARIABLE is of integer type.
|VARIABLE is number 			|True if VARIABLE is of integer type.
|VARIABLE is numeric 			|True if VARIABLE is of integer type.
|VARIABLE is Integer 			|True if VARIABLE is of integer type.
|VARIABLE is integer			|True if VARIABLE is of integer type.
|VARIABLE is String 			|True if VARIABLE is a valid string (which includes plain numbers represented as text).
|VARIABLE is string 			|True if VARIABLE is a valid string (which includes plain numbers represented as text).
|VARIABLE is Text	 			|True if VARIABLE is a valid string (which includes plain numbers represented as text).
|VARIABLE is text	 			|True if VARIABLE is a valid string (which includes plain numbers represented as text).
|VARIABLE is alphabetic			|True if VARIABLE is a string that only contains letters.
|VARIABLE is alphanumeric		|True if VARIABLE is a string that only contains letters and numbers. Also returns true if only numbers or only letters are present.
|VARIABLE is not Number 		|True if VARIABLE is not of integer type.
|VARIABLE is not number 		|True if VARIABLE is not of integer type.
|VARIABLE is not numeric 		|True if VARIABLE is not of integer type.
|VARIABLE is not Integer 		|True if VARIABLE is not of integer type.
|VARIABLE is not integer		|True if VARIABLE is not of integer type.
|VARIABLE is not String 		|True if VARIABLE is not a valid string.
|VARIABLE is not string 		|True if VARIABLE is not a valid string. 
|VARIABLE is not Text	 		|True if VARIABLE is not a valid string.
|VARIABLE is not text	 		|True if VARIABLE is not a valid string.
|VARIABLE is not alphabetic		|True if VARIABLE is a string that does not contain letters.
|VARIABLE is not alphanumeric	|True if VARIABLE is a string that neither contains letters nor numbers.

# Array assertions
| Expression							| Evaluates
|---									|---
|ARRAY all EXPRESSION 					|True if EXPRESSION evaluates to true on all elements of the array. EXPRESSION can be one of all the expressions listed here on this page, except the ones in this table.		
|ARRAY none EXPRESSION 					|True if EXPRESSION evaluates to false on all elements of the array. EXPRESSION can be one of all the expressions listed here on this page, except the ones in this table.
|ARRAY any EXPRESSION 					|True if EXPRESSION evaluates to to true on at least one element of the array. EXPRESSION can be one of all the expressions listed here on this page, except the ones in this table.
|ARRAY1 piecewise EXPRESSION ARRAY2 	|Traverses both arrays element by element and compares the respective elements with EXPRESSION. True if EXPRESSION evaluates to true on all piecewise comparisons and the ARRAY1 and ARRAY2 are of the same length. EXPRESSION can be one of the expressions listed on this page as long as it is comparative (contains two operands).

# File Assertions 
| Expression		| Evaluates
|---				|---
|-a FILE 			|True if FILE exists.
|-e FILE 			|True if FILE exists.
|-f FILE 			|True if FILE exists and is a regular file.
|-s FILE 			|True if FILE exists and has a size greater than zero.
|-d FILE 			|True if FILE exists and is a directory.
|-h FILE 			|True if FILE exists and is a symbolic link.
|-L FILE 			|True if FILE exists and is a symbolic link.
|-S FILE 			|True if FILE exists and is a socket.
|-r FILE 			|True if FILE exists and is readable.
|-w FILE 			|True if FILE exists and is writable.
|-x FILE 			|True if FILE exists and is executable.
|FILE1 -nt FILE2 	|True if FILE1 has been changed more recently than FILE2, or if FILE1 exists and FILE2 does not.
|FILE1 -ot FILE2 	|True if FILE1 is older than FILE2, or is FILE2 exists and FILE1 does not.
|FILE1 -ef FILE2	|True if FILE1 and FILE2 refer to the same device and inode numbers.