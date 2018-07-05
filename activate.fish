#!/usr/bin/env fish

set activate_path (dirname (status -f))/_activate.fish
fish -i -C". $activate_path $argv"
