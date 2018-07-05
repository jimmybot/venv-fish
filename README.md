# venv-fish
Minimal project-independent virtual environment activate script for the fish shell

## Why?
I had renamed a project only to find that virtualenv was now broken even though I had specified that the .venv be local, ie inside the project directory.
The reason virtualenvs aren't movable even when they are local is the activate script refers to an absolute path.  But actually, absolute paths are not necessary at all.

Other features:
* Activates the virtualenv in a subshell so there's no pollution of the environment and no cleanup needed
* Will recursively look for a virtualenv directory named .venv in any parent directory so you can activate from anywhere
* Shows the project name in the prompt

## Installation
Put these two fish scripts in your PATH.  Put them in the same directory because one refers to the other.

## Usage
Activate: ```path/to/activate.fish```
Deactivate: <ctrl-d> (exit the subshell, no cleanup needed!)

I would suggest using a function to alias it to something shorter.
