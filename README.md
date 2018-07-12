# venv-fish
Minimal project-independent Python virtual environment activate script for the fish shell

## Why?
I had renamed a project only to find that virtualenv was now broken even though I had specified that the .venv be local, ie inside the project directory.
The reason virtualenvs aren't movable even when they are local is the activate script refers to an absolute path.  But actually, absolute paths are not necessary at all.

Other features:
* Safety and isolation: Activates the virtualenv in a subshell so there's no pollution of the environment and no cleanup needed
* Easy of use: Will recursively look for a virtualenv directory named .venv in any parent directory so you can activate from anywhere
* Explicit: Shows the project name in the prompt
* Simple: Besides some logic to recursively look in parent directories for a virtual env directory, there is very little logic needed here at all

## Installation
Run ./install

You will be prompted to specify a directory in your PATH to install to

## Usage
Continue to use venv or virtual-env or other wrappers to create your virtual environments.  Then, ignore the local activate/deactivate scripts and instead use:
* Activate: ```path/to/activate.fish```
  * See the virtual env directory using: echo $VIRTUAL_ENV
  * See the project name (name of directory that contains virtual env directory): echo $VIRTUAL_ENV_PROJECT
* Deactivate: <ctrl-d> (exit the subshell, no cleanup needed!)

I would suggest using a function to alias it to something shorter.
