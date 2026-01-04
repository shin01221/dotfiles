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
        set -l last_choice_file ~/.local/state/tmux_last_session
        set -l last_choice ""
        set -l sessions (tmux list-sessions -F "#{session_name}" 2>/dev/null)
        if test -f $last_choice_file
            set last_choice (cat $last_choice_file)
        end
        switch (count $sessions)
            case 0
                tmux new -As main
            case '*'
                if test -n "$last_choice"
                    tmux attach -t "$last_choice"
                end
        end
    end
end
