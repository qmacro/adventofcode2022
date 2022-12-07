#!/usr/bin/env jq

def getinput:
  sub("\n$";"")
  | split("\n")
  ;

def getinput_split_on(sep):
  getinput
  | map(split(sep))
  ;

