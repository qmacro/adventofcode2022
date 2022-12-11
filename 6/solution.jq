#!/usr/bin/env jq

import "lib" as lib;

def solve(seqsize):
  map(.
    | lib::aperture(seqsize)
    | map(split("") | unique | length)
    | index(seqsize) + seqsize
  )
  ;

def main:
  lib::getinput as $input
  |
    ($input | solve(4)), 
    ($input | solve(14))
  ;

main

  
