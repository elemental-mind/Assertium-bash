#!/bin/bash

source "./Assertium.sh"

testAssertions()
{
    assert "assert 1 == 1" returns 0
    assert "assert 1 != 1" returns 1 
}

testNumericalComparisons()
{
    assert "assert 1 -eq 1" returns 0
    assert "assert 1 -ge 1" returns 0
    assert "assert 1 -le 1" returns 0
    assert "assert 1 -lt 2" returns 0
    assert "assert 1 -le 2" returns 0
    assert "assert 2 -gt 1" returns 0
    assert "assert 2 -ge 1" returns 0

    assert "assert 1 -gt 1" returns 1
    assert "assert 1 -lt 1" returns 1
    assert "assert 1 -eq 2" returns 1
    assert "assert 1 -gt 2" returns 1
    assert "assert 1 -ge 2" returns 1
    assert "assert 2 -eq 1" returns 1
    assert "assert 2 -lt 1" returns 1
    assert "assert 2 -le 1" returns 1
}

testStringComparisons()
{
    assert 'assert "string" == "string"' returns 0
    assert 'assert "string with spaces" == "string with spaces"' returns 0
    assert 'assert "string with spaces" != "String with Spaces"' returns 0
    assert 'assert "string with spaces" == "String with Spaces"' returns 1
}

testTypeComparisons()
{
    assert 'assert "123" is Number' returns 0
    assert 'assert "123" is number' returns 0
    assert 'assert "123" is numeric' returns 0
    assert 'assert "123" is integer' returns 0
    assert 'assert "123" is Integer' returns 0
    assert 'assert "123" is string' returns 0
    assert 'assert "123" is not alphabetic' returns 0

    assert 'assert "Sorry, 42 is not the answer." is Text' returns 0
    assert 'assert "Sorry, 42 is not the answer." is text' returns 0
    assert 'assert "Sorry, 42 is not the answer." is String' returns 0
    assert 'assert "Sorry, 42 is not the answer." is string' returns 0
    assert 'assert "Sorry, 42 is not the answer." is not alphabetic' returns 0
    assert 'assert "Sorry, 42 is not the answer." is not numeric' returns 0

    assert 'assert "String" is string' returns 0
    assert 'assert "String" is alphabetic' returns 0
    assert 'assert "String" is alphanumeric' returns 0
    assert 'assert "String" is not numeric' returns 0
}

testArrayElementComparisons()
{
    local numericalArray=(1 2 3 4 5 6 7 8 9)
    local wordArray=(one two three four five six seven eight nine)
    local textArray=("1. Sentence" "2. Sentence" "3. Sentence")

    assert 'assert numericalArray[@] all is numeric' returns 0
    assert 'assert numericalArray[@] all -lt 10' returns 0
    assert 'assert numericalArray[@] all -gt 0' returns 0

    assert 'assert wordArray[@] all is alphabetic' returns 0
    assert 'assert wordArray[@] none is numeric' returns 0

    assert 'assert textArray[@] all is text' returns 0
    assert 'assert textArray[@] none is numeric' returns 0
}

testArrayComparisons()
{
    local numericalArray1=(1 2 3 4 5 6 7 8 9)
    local numericalArray2=(1 2 3 4 5 6 7 8 9)
    local numericalArray3=(10 20 30 40 50 60 70 80 90)

    local wordArray=(one two three four five six seven eight nine)
    local textArray=("1. Sentence" "2. Sentence" "3. Sentence")

    assert 'assert numericalArray1[@] piecewise == numericalArray2[@]' returns 0
    assert 'assert numericalArray2[@] piecewise -lt numericalArray3[@]' returns 0
    assert 'assert numericalArray2[@] piecewise != numericalArray3[@]' returns 0

    assert 'assert wordArray[@] piecewise != textArray[@]' returns 1
}

testSelf
testNumericalComparisons
testStringComparisons
testTypeComparisons
testArrayElementComparisons
testArrayComparisons