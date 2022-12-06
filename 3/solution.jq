#!/usr/bin/envjq

import "lib" as lib;

# Takes a string
# Splits it into two halves
# Returns an array containing those two halves
def halves:
  (length / 2) as $half
  | [.[0:$half], .[$half:]]
  ;

# Takes an array of two arrays of letters
# Returns the letter common to both letter arrays
def common:
  .[1] as $lookup
  | .[0]
  | map(. as $c | if ($lookup | contains([$c])) then $c else empty end)
  | unique
  | first
  ;
  
# Takes a character
# Returns the priority (a=1,z=26,A=27,Z=52)
def priority:
  explode | first as $value
  | if $value > 96 then $value - 96 else $value - 38 end
  ;

def part1:
  map(halves)
  | map(common)
  | map(priority)
  | add
  ;

def part2:
  null
  ;

def main:
  lib::getinput_split_on("") as $input
  | ($input | part1), ($input | part2)
  ;

main 
