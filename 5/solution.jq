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

def solve($part):

  # Calculate how many stacks there are
  ((first|length + 1) / 4) as $stackcount

  # Stack numbers then empty line separates stacks from moves
  | (.[index("") + 1:] | tomoves) as $moves
  | (.[:index("") - 1] | tostacks(stackmatchpattern($stackcount))) as $stacks

  # Apply all the move instructions
  | $moves | reduce .[] as $move (
      $stacks;
      
      # Determine the block of crates to move:
      # Part 1 is one at a time, Part 2 is as a chunk
      (
        .[$move.from - 1][$move.move * -1:]
        | if ($part == 1) then reverse else . end 
      ) as $block

      # Add block to target stack
      | .[$move.to - 1] += $block

      # Remove block from source stack
      | .[$move.from - 1] |= .[:$move.move * -1]

    )

  # Concatenate the top letter (crate) from each stack
  | map(.[-1] | gsub("[^A-Z]+";"")) | add
  ;

lib::getinput as $input
| 
  ($input | solve(1)),
  ($input | solve(2))
  
