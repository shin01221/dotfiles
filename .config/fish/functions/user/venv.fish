function venv
    set -U VENV_PATH (realpath $argv[1])
    source $VENV_PATH/bin/activate.fish
end
