#!/usr/bin/env jq

def getinput_split_on(sep):
  sub("\n$";"")
  | split("\n")
  | map(split(sep))
  ;

