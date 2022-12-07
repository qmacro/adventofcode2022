#!/usr/bin/env jq

import "lib" as lib;

def second: .[1];

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
  . as $ranges
  | sort
  | (
  #        first          second
  #   [[first,second],[first,second]]
      (first|first) <= (second|first) 
      and
      (first|second) >= (second|second)
    ) as $result 
  | if $result then [$ranges, $result] | debug | .[1] else $result end
  ;
  
def part1:
  map(
    map(torange)
    | isfullycontained
  )
  | filter(.)
  | length
  ;

def part2:
  null
  ;

lib::getinput_split_on(",") as $input
| ($input | part1), ($input | part2)
  
