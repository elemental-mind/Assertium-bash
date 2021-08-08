#!/bin/bash

assert()
{
    assert_base "$@"

    if [ $? == 0 ]
    then
        tput setaf 2; echo Pass: $@ ; tput sgr0
        return 0
    else
        tput setaf 1; echo FAIL: $@ ; tput sgr0
        return 1
    fi 
}

assert_base()
{
    case "$2" in
        is)
            if [ "$3" == "not" ]
            then
                assert_is_not "$@"
            else
                assert_is "$@"
            fi 
            ;;
        all)
            assert_all "$@"
            ;;
        any)
            assert_any "$@"
            ;;
        none)
            assert_none "$@"
            ;;
        piecewise)
            assert_piecewise "$@"
            ;;
        returns)
            outputTrap=$(eval $1) # using a trap here to catch the output of the original assert
            test "$?" == $3
            ;;
        *)
            test "$@"
            ;;
    esac

    return "$?"
}

###
### Type assertions
###

assert_is()
{
    # for the regex we can not use the test command (which is just another way to write [ ... ]).
    # We need to use double brackets. Even though they are used "standalone" here (you may be used to them embedded in if statements), they set their exit code ($?) as expected
    case "$3" in
        Number|number|numeric|Integer|integer)
            [[ $1 =~ ^[0-9]*$ ]]
            ;;
        String|string|Text|text)
            [[ $1 =~ ^[0-9A-Za-z\ .,!]*$ ]]
            ;;
        alphabetic)
            [[ $1 =~ ^[A-Za-z]*$ ]]
            ;;
        alphanumeric)
            [[ $1 =~ ^[0-9a-zA-Z]*$ ]]
            ;;
        *)
            echo "Unknown assertion $3"
            return 1
            ;;
    esac
}

assert_is_not()
{
    assert_is "$1" $2 $4

    if [ $? == 0 ]
    then
        return 1
    else
        return 0
    fi
}

###
### Array assertions
### 

assert_all()
{
    local mismatch=0
    for i in "${!1}"
    do
        assert_base "$i" $3 "$4"
        if [ $? != 0 ]
        then
            mismatch=1
            break
        fi
    done

    return $mismatch
}

assert_any()
{
    local noElementFound=1

    for i in "${!1}"
    do
        assert_base "$i" $3 "$4"
        if [ $? == 0 ]
        then
            noElementFound=0
            break
        fi
    done

    return $noElementFound
}

assert_none()
{
    local match=0

    for i in "${!1}"
    do
        assert_base "$i" $3 $4
        if [ $? == 0 ]
        then
            match=1
            break
        fi
    done

    return $match
}

assert_piecewise()
{
    local mismatch=0
    local array1=( ${!1} )
    local array2=( ${!4} )

    if [ ${#array1[@]} != ${#array2[@]} ]
    then
        return 1
    else
        for i in "${!array1[@]}"
        do
            assert_base "${array1[i]}" $3 "${array2[i]}"

            if [ $? == 1 ]
            then
                mismatch=1
                break
            fi
        done

        return $mismatch
    fi
}