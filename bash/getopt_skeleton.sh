#!/bin/bash

# Call getopt to validate the provided input. 
options=$(getopt \
            -o a:b:c: \
            --long option-a:,option-b:,option-c: -- "$@")

if [ $# -eq 0 ]; then
    echo "No parameters provided"
    exit 1
fi

eval set -- "$options"

while true; do
    case "$1" in
    -a)
        echo "Option a short"
        shift;
        VAR=$1
        ;;
    -b)
        echo "Option b short"
        shift;
        VAR=$1
        ;;
    -c)
        echo "Option c short"
        shift;
        VAR=$1
        ;;
    --option-a)
        shift; # The arg is next in position args
        echo "Option a long"
        VAR=$1
        ;;
    --option-b)
        shift; # The arg is next in position args
        echo "Option b long"
        VAR=$1
        ;;
    --option-c)
        shift; # The arg is next in position args
        echo "Option c long"
        VAR=$1
        ;;
    -:)
        echo "$0: -$OPTARG needs a value" >&2;
        exit 2
        ;;
    --)
        shift
        break
        ;;
    -*)
        echo "ERROR: no arguments were provided!"
        shift
        exit 1
        ;;
    esac
    shift
done

echo "VAR is $VAR"
exit 0;