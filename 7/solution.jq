#!/usr/bin/env jq

import "lib" as lib;

# Array push with autovivification (see
# https://qmacro.org/blog/posts/2022/12/13/array-push-with-autovivification-in-jq/)
def apush($pexp;$item):
  setpath($pexp;(getpath($pexp) // []) + [$item])
;

def what:
  (split(" ")) as $parts 
  | if (startswith("$ cd")) then
      if ($parts[2] == "..") then ["up"] else ["down", $parts[2]] end
    else
      if ($parts[0] | match("^[0-9]+$")) then ["file"] + $parts else empty end
    end
;

def part1:
  reduce map(what)[] as $what (
    {
      # A list of dirs that the next file(s) are "in"
      dirlist: [],

      # An object with file sizes by (direct and also indirect) dir
      dircontents: {}
    };

      ([$what, .dirlist] | debug) as $_

      # If we descend into a dir, add it to the list
    | if ($what[0] == "down") then .dirlist += [$what[1]] else . end

      # If we ascend out of a dir (..), then remove the most recent dir 
      # from the list
    | if ($what[0] == "up") then delpaths([["dirlist", -1]]) else . end

      # The only other thing we're interested in now is file info
    | if ($what[0] == "file") then 

        # Record the file as being in all of the dirs in the current path
        reduce .dirlist[] as $dir (
          .;
          . | apush(["dircontents", $dir];$what[1] | tonumber)
        )

      else . end
  )
  | .dircontents
  #| with_entries(.value |= add)
  | map(add | select(. <= 100000)) | add
;

def part2:
  null
;

lib::getinput as $input
|
  ($input | part1), 
  ($input | part2)
  
