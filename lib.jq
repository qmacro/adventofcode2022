#!/usr/bin/env jq

def getinput:
  sub("\n$";"")
  | split("\n")
  ;

def getinput_split_on(sep):
  getinput
  | map(split(sep))
  ;

# Similar to https://ramdajs.com/docs/#aperture
def aperture($size):
  . as $list
  | reduce range($list | length - $size + 1) as $i (
      [];
      . + [$list[$i:$i + $size]]
    )
  ;
 
