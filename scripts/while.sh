#!/bin/bash

X=1

while [ $X -lt 10 ]

do
  echo $X
  X=$(( ${X} +1 ))
done
