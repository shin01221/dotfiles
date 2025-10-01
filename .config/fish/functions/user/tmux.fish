function tmux-set
    if status is-interactive # Commands to run in interactive sessions can go here
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

            # gather sessions, skipping 'scratch' and any session that has a window named 'rmpc'
            set -l sessions
            for s in (tmux list-sessions -F "#{session_name}" 2>/dev/null)
                if test "$s" = scratch -o "$s" = rmpc
                    continue
                end

                # skip session if any of its windows is exactly named "rmpc"
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
                    # Build fzf input so last_choice appears first (and therefore is preselected)
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
                        set chosen (printf "%s\n" $fzf_input | fzf-tmux -p 60%,40% --prompt="Attach tmux session > ")
                    else if type -q fzf
                        set chosen (printf "%s\n" $fzf_input | fzf --height=40% --border --layout=reverse --prompt="Attach tmux session > ")
                    else
                        # no fzf available, attach to first
                        tmux attach -t $sessions[1]
                        return
                    end

                    if test -n "$chosen"
                        printf "%s" "$chosen" >$last_choice_file
                        tmux attach -t "$chosen"
                    else
                        # user cancelled fzf -> start fresh session
                        tmux
                    end
            end
        end
    end
end
