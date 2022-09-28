#!/bin/bash

# Declare an array of string with type
declare -a Packages=( 
   "git" 
   "gh"
   "htop" 
   "neofetch" 
   "stow"
)

test="dnf install -y"
 
# Iterate the string array using for loop
for val in ${Packages[@]}; do
   test="$test $val"
done

dnf update -y
eval $test
