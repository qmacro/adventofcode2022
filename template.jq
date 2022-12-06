#!/usr/bin/envjq

import "lib" as lib;

def part1:
  null
  ;

def part2:
  null
  ;

lib::getinput_split_on("") as $input
| ($input | part1), ($input | part2)
  
