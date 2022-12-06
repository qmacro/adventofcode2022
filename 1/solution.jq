#!/usr/bin/env jq

import "lib" as lib;

# Run with:
# -R (read raw strings, not JSON texts)
# -s (slurp all inputs into an array)
# i.e. jq -f solution.jq -R -s input.dat

# Need some extra input processing to turn this:
# [["1000"],["2000"],["3000"],[],["4000"],...]
# into this:
# [[1000,2000,3000],[4000],...]
def processinput: 
  reduce .[] as $value (
    [[]];
    if ($value | length > 0)
    then .[-1] += [$value[0]|tonumber] 
    else . + [[]]
    end
  )
  ;

def part1:
  map(add) | max;

def part2:
  map(add) | sort[-3:] | add;

def main:
  lib::getinput_split_on("\n") | processinput as $input
  | ($input | part1), ($input | part2)
  ;

main
