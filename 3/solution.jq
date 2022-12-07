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

# Given an array of arrays of letters (letter lists),
# find the letter common to all letter lists. 
# Don't like this, but it will do for now.
def findcommonletter:

  # Get all but the first letter list as $rest
  (.[1:] | map(unique)) as $rest

  # Then start with the first letter list
  | first

  # and go through each letter in it, checking if it's in the other letter lists
  | map(. as $letter | $rest | map(if (contains([$letter])) then $letter else null end))

  # This will result in an array like this:
  # [[[null,"v"],[null,null],...]] but one inner item will be like this: ["r", "r"]
  # and that's the common letter. So just grab that item, and pull out the (first) letter
  | map(select(all)) | flatten | first ;

def part2:
  [_nwise(3)]
  | map(findcommonletter)
  | map(priority)
  | add
  ;

def main:
  lib::getinput_split_on("") as $input
  | ($input | part1), ($input | part2)
  ;

main 
