function tmux-set
    # Skip tmux-set if NO_TMUX is set
    if set -q NO_TMUX
        return
    end
    # Skip if already inside tmux
    if set -q TMUX
        return
    end
    if not set -q TMUX
        # remember file
        switch (count $sessions)
            case 0
                tmux new -As main
            case '*'
                tmux attach -t "$last_choice"
        end
    end
end
