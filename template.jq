#!/usr/bin/envjq

import "lib" as lib;

def getinput:
  .
  ;

def part1:
  null
  ;

def part2:
  null
  ;

getinput as $input
| ($input | part1), ($input | part2)
  
