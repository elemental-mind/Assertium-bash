source ./Assertium.sh

testHelloWorld()
{
    local myNumber=100
    local myString="Hello World"
    local myArray=(1 2 3 4 5 6 7 8 9)

    assert $myNumber == 100
    assert $myNumber -gt 0
    assert $myNumber -lt 1000

    assert "$myString" == "Hello World"

    assert myArray[@] all -gt 0
    assert myArray[@] none == 5         # -> fails because 5 is contained in the arra
    assert myArray[@] all is numeric

    assert -f ./examples/HelloWorld.sh
}

testHelloWorld