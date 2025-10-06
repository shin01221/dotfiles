function tmux-set

    # Skip tmux-set if NO_TMUX is set
    if set -q NO_TMUX
        if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
            cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        end
        # pyenv init - fish | source
        # pyenv virtualenv-init - fish | source
        return
    end
    if not set -q TMUX
        # optional: print sequences if present
        if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
            cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        end

        # remember file
        set -l last_choice_file ~/.local/state/tmux_last_session
        set -l last_choice ""
        if test -f $last_choice_file
            set last_choice (cat $last_choice_file)
        end

        # gather sessions, skipping 'scratch' and any session with window 'rmpc'
        set -l sessions
        for s in (tmux list-sessions -F "#{session_name}" 2>/dev/null)
            if test "$s" = scratch -o "$s" = rmpc
                continue
            end
            if tmux list-windows -t "$s" -F "#{window_name}" 2>/dev/null | grep -Fxq rmpc
                continue
            end
            set sessions $sessions $s
        end

        switch (count $sessions)
            case 0
                tmux
            case 1
                tmux attach -t $sessions[1]
            case '*'
                # Build fzf input so last_choice appears first
                set -l fzf_input
                if test -n "$last_choice" && contains -- $last_choice $sessions
                    set fzf_input $last_choice
                    for s in $sessions
                        if test "$s" != "$last_choice"
                            set fzf_input $fzf_input $s
                        end
                    end
                else
                    set fzf_input $sessions
                end

                # show chooser (fzf-tmux if present, else fzf)
                if type -q fzf-tmux
                    set chosen (printf "%s\n" $fzf_input | fzf-tmux -p 60%,40% --prompt="Attach or create tmux session > " --print-query | tail -n1)
                else if type -q fzf
                    set chosen (printf "%s\n" $fzf_input | fzf --height=40% --border --layout=reverse --prompt="Attach or create tmux session > " --print-query | tail -n1)
                else
                    tmux attach -t $sessions[1]
                    return
                end

                if test -n "$chosen"
                    printf "%s" "$chosen" >$last_choice_file
                    if contains -- $chosen $sessions
                        tmux attach -t "$chosen"
                    else
                        tmux new -s "$chosen"
                    end
                else
                    tmux
                end
        end
    end
end
