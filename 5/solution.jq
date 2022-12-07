#!/usr/bin/env jq

import "lib" as lib;

def part1:

  # Calculate how many stacks there are
  # (assuming single letter cargo).
  ((first|length + 1) / 4) as $stackcount

  # Build regex for capturing the stack contents
  | ([range(1;$stackcount + 1)] | map("(?<S\(.)>...)") | join(" ")) as $pattern

  # Stack numbers then empty line separates stacks from moves
  | .[:index("") - 1] as $stacks
  | .[index("") + 1:] as $moves

  | [$stacks | map(capture($pattern)), $moves]
  ;

def part2:
  null
  ;

lib::getinput as $input
| ($input | part1), ($input | part2)
  
