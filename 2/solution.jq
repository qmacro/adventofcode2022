#!/usr/bin/envjq

import "lib" as lib;

# Each move has a corresponding number of points; this 
# table also shows what A, B & C and X, Y and Z represent
def points(play):
  {
    "A": 1, "X": 1, # Rock
    "B": 2, "Y": 2, # Paper
    "C": 3, "Z": 3  # Scissors
  }[play]
  ;

# The possible outcomes and their score values
def win: 6;
def draw: 3;
def loss: 0;

# A matrix of plays and their outcomes:
# - Opponent 1 plays A, B or C
# - Opponent 2 then plays X, Y or Z
def table:
  {
    "A": { "X": draw, "Y": win, "Z": loss },
    "B": { "X": loss, "Y": draw, "Z": win },
    "C": { "X": win, "Y": loss, "Z": draw }
  }
  ;

# Look up the score in the table
def score(a; b): table[a][b];

# In part 2, X, Y and Z denote the required outcome
def required_outcome: { "X": loss, "Y": draw, "Z": win };

def play(a;outcome):
  required_outcome[outcome] as $score 
  | table[a]
  | to_entries
  | map(select(.value == $score))
  | first.key
  ;

# Calculate the total (common for parts 1 and 2)
def calculate(a;b):
  points(b) + score(a;b)
  ;
  
def part1:
  map(calculate(.[0];.[1]))
  | add
  ;

def part2:
  map(
    play(.[0];.[1]) as $move
    | calculate(.[0];$move)
  ) | add
  ;

def main:
  lib::getinput_split_on(" ") as $input
  | ($input | part1), ($input | part2)
  ;

main
