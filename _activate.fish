# We use a subshell for process isolation; no need to unset any variables
# Don't run this file directly or it will pollute your env
#
# This file must be run like so:
#   fish -i -C". <this file>"

# Put these variables in the outter scope
set -g venv_dir .venv
set -g cwd (pwd)

function _findvenv
    if test (count $argv) -gt 0
        set -g venv_dir $argv[1]
        if test (count $argv) -gt 1
            set -g cwd $argv[2]
        end
    end

    if test -d $cwd/$venv_dir
        return 0
    else if [ $cwd = '/' ]
        set -e cwd
        return 1
    else
        _findvenv $venv_dir (dirname $cwd)
        return $status
    end
end

function _setvenv
    _findvenv $argv[1] $argv[2]
    if [ $status != 0 ]
        echo "Couldn't find a virtualenv. Looked for $venv_dir/ here and in all parents" 1>&2
        echo "Usage: ./activate.fish [venv dir=.venv] [initial search path=./]" 1>&2
        exit 1
    else
        # Give some feedback if we found the virtual env directory somewhere other than the currenct directory
        if [ $cwd != (pwd) ]
            echo "Found virtualenv $venv_dir/ in: $cwd"
        end
        set -gx VIRTUAL_ENV $cwd/.venv
        set -gx PATH "$VIRTUAL_ENV/bin" $PATH

        # unset PYTHONHOME if set
        if set -q PYTHONHOME
            set -e PYTHONHOME
        end

        if test -z "$VIRTUAL_ENV_DISABLE_PROMPT"
            # fish uses a function instead of an env var to generate the prompt.

            # save the current fish_prompt function as the function _old_fish_prompt
            functions -c fish_prompt _old_fish_prompt

            # with the original prompt function renamed, we can override with our own.
            function fish_prompt
                # Save the return status of the last command
                set -l old_status $status
                # Prepend env
                printf "(%s) " (basename (dirname "$VIRTUAL_ENV"))

                # Restore the return status of the previous command.
                echo "exit $old_status" | .
                _old_fish_prompt
            end
        end
        exit 0
    end
end

# Check for args and execute
if test (count $argv) -gt 0
    set -g venv_dir $argv[1]
    if test (count $argv) -gt 1
        set -g cwd $argv[2]
    else
        set -g cwd (pwd)
    end
else
    set -g venv_dir .venv
end

_setvenv $venv_dir $cwd
