# Assertium - Assertion library for bash
Assertium exposes an easy to use assert function to use in bash scripts for unit testing purposes.

# Example
Source:
````
source ./Assertium.sh
...
    local myNumber=100
    local myString="Hello World"
    local myArray=(1 2 3 4 5 6 7 8 9)

    assert $myNumber -gt 0
    assert "$myString" == "Hello World"
    assert "$myString" is alphabetic

    assert myArray[@] none == 5         # -> fails because a value of 5 is in the array
    assert myArray[@] all is numeric

    assert -f ./examples/HelloWorld.sh
...
````
Outputs:
````
Pass: 100 -gt 0
Pass: Hello World == Hello World
Pass: Hello World is alphabetic
FAIL: myArray[@] none == 5
Pass: myArray[@] all is numeric
Pass: -f ./examples/HelloWorld.sh
````

# Installation
To use Assertium you only need the `Assertium.sh` file from the main branch of this repository on the machine where you intend to use it.

Once downloaded add the following line to your bash script to be able to use the `assert` function:

```
source /path/to/Assertium.sh
```

# Usage
## Assert values
```
assert $myNumber == 1                           # -> Pass: 1 == 1
assert $myNumber -eq 2                          # -> FAIL: 1 -eq 2
assert "$myText" == "I equal this string!"      # -> Pass: ...
```
Usage is simple! If you know how to write an if condition in bash you know how to write an assertion: Put everything you would normally put into angle brackets after the assert function specifier. Instead of `if [ <Expression> ] ...` write `assert <Expression>`. 
Make sure that variables that might contain spaces are surrounded by either single or double quotes.

All comparison operators are supported: `=`, `==`, `!=`, `-eq`, `-gt`, `-ge`, `-lt`, `-le`, `-o`, `-a`. 

Expressions with preceding flags (like `-f` to check for file existance) are also possible - given that the second argment is not be one of the following values: `is`, `none`, `all`, `piecewise` or `returns`. To check which other flags are supported check the operator reference in the documentation.
````
assert -f ./file/which/should/exist
```` 
## Assert types
```
assert $myNumber is numeric             # -> Pass: 1 is numeric
assert $myNumber is alphabetic          # -> FAIL: 1 is alphabetic
assert $myNumber is not alphabetic      # -> Pass: 1 is not alphabetic
assert "$myText" is string              # -> Pass: ...
```
Assertium allows you to use the `is` operator to check the content type of a variable. You can negate the type by adding a not after the `is`. The syntax is as follows: `assert <Variable> is [not] <Type>`. `Type` can be one of the following:
- `Number`, `numerical`, `numeric`, `Integer`, `integer` to check for non-decimal numbers as content.
- `String`, `string`, `Text`, `text` to check for a valid string (composed only of numbers, letters, and `.`, `,`, `?`, `!`).
- `alphabetic` to check that a variable only contains letters.
- `alphanumeric` to check that a variable only contains letters and numbers. Also true if only numbers or numbers are present.

## Assert on values of an array
```
assert myArray[@] all -gt 0                             # -> Pass: myArray[@] all -gt 0
assert myArray[@] none == 10                            # -> Pass: myArray[@] none == 10
assert myArray[@] all is Integer                        # -> Pass: myArray[@] all is Integer
assert myArray[@] any is alphabetic                     # -> FAIL: myArray[@] any is alphabetic
assert myStrings[@] any == "String I am looking for"    # -> Pass: ...
```
Assertium enables assertions on arrays as well. The syntax is as follows: `assert <ArrayReference> <Quantifier> <ComparativeExpression>`. `ArrayReference` is simply your array variable name followed by `[@]`. `ComparativeExpression` is the assertion operator followed by an optional comparative value (depending on the Expression type). `ComparativeExpression` must be comparative as of now (most of the file assertions don't work, for example). `Quantifier` can be one of the following:
- `all` to ensure that `ComparativeExpression` evaluates to true on all elements of the array.
- `none` to ensure that `ComparativeExpression` evaluates to false on all elements of the array.
- `any` to ensure that `ComparativeExpression` evaluates to true on at least one element of the array.
> :warning: Make sure to pass the array "by reference" -> Only use your array name followed by `[@]` like in the example above. Nothing else. Do not destructure the array through `${myArray[@]}` or any similar forms.

## Assert between arrays
```
assert myArray[@] piecewise == myArrayCopy[@]           # -> Pass: myArray[@] piecewise == myArrayCopy[@]
assert myArray[@] piecewise -gt myMultipliedArray[@]    # -> Pass: myArray[@] piecewise -gt myMultipliedArray[@]
assert myTextArray[@] piecewise != myMirroredStrings[@] # -> Pass: myTextArray[@] piecewise != myMirroredStrings[@]
```
To compare two arrays element by element use the `piecewise` operator. The syntax is as follows: `assert <ArrayReference1> piecewise <ComparativeOperator> <ArrayReference2>`.
> :warning: Make sure to pass both arrays "by reference" -> Only use your array name followed by `[@]` like in the example above. Nothing else. Do not destructure the arrays through `${myArray[@]}` or any similar forms.

## Full assertion expression reference
An exhaustive list of expressions can be found in the documentation in the following path of this repository: `documentation/OperatorReference.md`

# Output/Return values
## Exit code
A call to `assert` sets an exit code through `return` depending on the truthiness of the assertion. As an exit code of 0 is generally regarded as successful `0` is used to signal an assertion pass and `1`to signal a failed assertion. Quite unintuitive if you are used to boolean true or false, I know - however this is in line with bash's interpretation of return value truthiness in the if function for example.

To get the return value after calling `assert` use the `$?` return value variable.
````
assert $myVar is numerical

if [ $? == 0 ]
then
    echo Test succeeded!
else
    echo Test failed!
fi
````
## Console output
By default Assertium prints assertion results to the console. Passing assertions will be printed in green and preceded by `Pass: `, failing ones will be printed in red and preceded by `FAIL: `. If you'd like to suppress output you can wrap your assertion in a nested expression: `$(assert ...)`.

# Common Questions & Issues
## My assertion breaks my code
The most common error you will get is:
```
test: too many arguments
```
You probably have passed a string without quotes to the assertion or have passed an array as values (and not by reference). Should you not have done either, raise an issue here providing your sample input.

## My assertion evaluates to true in my code and I don't know why.
Make sure you don't call any other function between your `assert` call and queriying `$?` - even a simple call to `echo` sets `$?` back to 0.

## I do not want console output/I want different output
No problem. You have two options here:
- Replace all your calls to `assert` with `assert_base`. `assert_base` has the same API - and also sets the same exit code as `assert` that you can grab through `$?` after running `assert_base`.
- Jump into the source: Change line 9 and 12 in `Assertium.sh` to any output you fancy.

# Contributing
Contributions welcome! Feel free to send pull requests to fix bugs that you have discovered or to add functionality you were missing. Added tests in the `specification/Assertium.h` are a bonus.
 
Topics that might need attention are:
- Support for regular expressions as comparisons: Support for `assert "$myString" =~ "^[A-B]+$"`. For that the test command yould have to replaced with `[[ ]]`. 
- Non-comparative file array assertions: Support e.g. `assert myFilePaths[@] all -f`.
- Enhanced string assertions: Support operators like `assert $myVar startsWith "abc"`, `... contains ...`, `... endsWith ...` to ease readibility by not relying on regular expressions.

# License
MIT