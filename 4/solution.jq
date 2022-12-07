#!/usr/bin/env jq

import "lib" as lib;

# Starting to tire of writing map(select())
def filter(condition): map(select(condition));

# Takes a range string like this: "1-3"
# Returns an array of two numbers representing that range: [1,3]
def torange:
  split("-") 
  | map(tonumber)
  ;

# Takes an array of two ranges: [[3,7],[2,8]]
# Returns whether one is fully contained within the other
def isfullycontained:
  (((.[0][0] - .[1][0]) * (.[0][1] - .[1][1])) <= 0)
  ;
  
# Takes an array of two ranges: [[3,7],[2,8]]
# Returns whether they overlap at all
def doesoverlap:
  (((.[0][0] - .[1][1]) * (.[0][1] - .[1][0])) <= 0)
  ;
  
def part1: isfullycontained;
def part2: doesoverlap;

lib::getinput_split_on(",") as $input
|
  ($input | map(map(torange) | part1) | filter(.) | length),
  ($input | map(map(torange) | part2) | filter(.) | length)
  
