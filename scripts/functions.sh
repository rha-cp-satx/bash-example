#!/bin/bash

#functions can be used for a variety of things, but generally
#they are used to group things together. For example: 
#create, delete, or updating things would have the procedures
#for each high-level function.

#The key thing to remember is that you have to define the function
#before you can use it.

#create the function:

hello_world() {
#This function will be invoke printing hello world

echo "Hello World!"

}

hello_you() {
#This function will say hello to what you enter
echo "[enter your name]"
read NME
echo hello ${NME}
}

#------------------------------------------------------------------
#invoking the function
#
#------------------------------------------------------------------
hello_world

hello_you
