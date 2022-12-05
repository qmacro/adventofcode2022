#!/usr/bin/env jq

import "lib" as lib;

# Run with:
# -R (read raw strings, not JSON texts)
# -s (slurp all inputs into an array)
# i.e. jq -f solution.jq -R -s input.dat

# When initially read in, the input will look like this:
# "1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000\n"

def part1:
  map(add) | max;

def part2:
  map(add) | sort[-3:] | add;

lib::getinput_1 as $input
| ($input | part1), ($input | part2)
  
