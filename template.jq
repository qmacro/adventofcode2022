#!/usr/bin/envjq

import "lib" as lib;

def getinput:
  .
  ;

def part1:
  "pending..."
  ;

def part2:
  "pending..."
  ;

getinput as $input
| [
    ($input | part1),
    ($input | part2)
  ]
