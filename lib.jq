#!/usr/bin/env jq

def getinput_1:
  sub("\n$";"")
  | split("\n\n")
  | map(split("\n")|map(tonumber))
  ;


