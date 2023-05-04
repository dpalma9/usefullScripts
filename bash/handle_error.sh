#!/bin/bash

## FUNCTIONS
my_func() {
  echo "Hi, I'm my_func!"
  mkdir tmp
  rm tmp || { echo "command failed"; rm -r tmp; exit 1; }
  echo "Bye!"
}

my_func2() {
  echo "Hi, I'm my_func2!"
  mkdir tmp
  rm tmp
  #echo "Bye!" # --> this cannot be added because it would be a correct command and the trap won't work, since last command was success.
}

my_func3() {
  echo "Hi, I'm my_func3!"
  mkdir tmp 2>> errors.txt
  rm tmp 2>> errors.txt
  echo "Bye!"
}
# Auxiliar:
error() {
  local parent_lineno="$1"
  local message="$2"
  local code="${3:-1}"
  if [[ -n "$message" ]] ; then
    echo "Error on or near line ${parent_lineno}: ${message}; exiting with status ${code}"
  else
    echo "Error on or near line ${parent_lineno}; exiting with status ${code}"
  fi
  exit "${code}"
}

### MAIN
## Using ||
#my_func

## Using trap
#trap my_func2 0
#trap 'error ${LINENO}' ERR

## Another trap example
trap "echo Something went wrong; exit" 0
my_func3
