#!/bin/bash

# This is a simple shell script that when passed "foo" echoes "bar and 
# when passed "bar" echoes "foo". If there is nothing passed then it 
# will echo that either foo or bar needs to be passed"

case $1 in 
  foo)
    echo "bar"
    ;;
  bar)
    echo "foo"
    ;;
  *)
    echo "You need to choose either foo or bar"
    exit
    ;;
esac
