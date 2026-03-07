# function venvoff
#     set -eU VENV_PATH
#     deactivate
# end
function venvoff
    if functions -q deactivate
        deactivate
    end

    rm -f ~/.config/fish/venv_state
end
