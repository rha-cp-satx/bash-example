#!/bin/bash

select ANS in foo bar exit
do 
  case $ANS in
    foo)
      echo "bar"
      break
      ;;
    bar)
      echo "foo"
      break
      ;;
    exit)
      echo "exiting from script"
      exit
      ;;
  esac
done
