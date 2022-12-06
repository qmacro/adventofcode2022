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
  debug |
  explode | first as $value
  | if $value > 96 then $value - 96 else $value - 38 end
  ;

def alphabet: "abcdefghijklmnopqrstuvwxyz";
def alphaupper: alphabet | ascii_upcase;
def alphalower: alphabet | ascii_downcase;

def part1:
  map(halves)
  | map(common)
  | map(priority)
  | add
  ;

# Takes an array of arrays of letters, plus a letter to search for
def rucksackcontains(letter):
  all(
    .[0] | contains([letter]),
    .[1] | contains([letter]),
    .[2] | contains([letter])
  )
  ;

def part2:
  (alphaupper + alphalower | split("")) as $letters
  | [_nwise(3)]
  ;

def main:
  lib::getinput_split_on("") as $input
  | ($input | part1), ($input | part2)
  ;

main 
