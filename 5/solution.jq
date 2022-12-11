#!/usr/bin/env jq

import "lib" as lib;

# Create a regex for capturing n stacks
def stackmatchpattern(n):
  ([range(1;n + 1)] 
  | map("(?<S\(.)>...)") 
  | join(" ")) 
  ;

# Process stacks to an array of arrays representing each stack
def tostacks($pattern):

  # Capture the stack items via the regex
  map(capture($pattern)) | reverse as $stackobjs

  # Get the stack names (S1, S2, S3, ...)
  | $stackobjs | first | keys 

  # Work thru the stack data compiling an array of stack arrays
  # where the bottom stack item is the first element
  | map(
      . as $stackname
      | $stackobjs | map(.[$stackname]) 

      # Remove any empty stack items
      | map(select(test("\\S")))
    )
  ;

def tomoves:
  map(capture("move (?<move>[0-9]+) from (?<from>[0-9]+) to (?<to>[0-9]+)"))
  | map(map_values(tonumber))
  ;

def part1:

  # Calculate how many stacks there are
  ((first|length + 1) / 4) as $stackcount

  # Stack numbers then empty line separates stacks from moves
  | (.[index("") + 1:] | tomoves) as $moves
  | (.[:index("") - 1] | tostacks(stackmatchpattern($stackcount))) as $stacks

  # Apply all the move instructions
  | $moves | reduce .[] as $move (
      $stacks;
      
      # Use a nested reduce to apply a move N times
      reduce range($move.move) as $i (
        .;
        .[$move.to - 1] += [.[$move.from - 1][-1]]
        | del(.[$move.from - 1][-1])
      )
    )

  # Concatenate the top letter (crate) from each stack
  | map(.[-1] | gsub("[^A-Z]+";"")) | add
  ;

def part2:
  null
  ;

lib::getinput as $input
| ($input | part1), ($input | part2)
  
