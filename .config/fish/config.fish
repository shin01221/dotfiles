function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

set -g fish_key_bindings fish_vi_key_bindings
bind -M insert jj 'set fish_bind_mode default; commandline -f repaint-mode'
# sourcing my functions
for f in ~/.config/fish/functions/user/*.fish
    source $f
end

set -gx PATH $HOME/.local/bin $PATH

if status is-interactive # Commands to run in interactive sessions can go here
    # No greeting
    set fish_greeting

    # Auto-attach to tmux if not already inside one
    # Use starship
    # if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    #     cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    # end

    starship init fish | source

    # auto-attach logic (run only when not already in tmux)
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

    # Aliases
    alias pamcan pacman
    alias ls 'eza --icons'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'

end

# function fish_prompt
#     set_color cyan
#     echo (pwd)
#     set_color green
#     echo '> '
# end

# aliases

alias down360='down 360'
alias down480='down 480'
alias down720='down 720'
alias down1080='down 1080'

alias df="_df"
alias mirrors='sudo reflector --country Germany,France,Italy --latest 30 --sort age --protocol https --save /etc/pacman.d/mirrorlist'
alias grep='grep --color=auto'
alias p='sudo pacman'
alias rm='trash -d'
alias cd='z'
alias cp='cp -r'
alias cat="bat --theme=base16"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias c='clear' # clear terminal
alias l='eza -lh --icons=auto' # long list
alias ls='eza -1 --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias un='yay -Rns' # uninstall package
alias up='yay -Syu' # update system/package/aur
alias pl='yay -Qs' # list installed package
alias pa='yay -Ss' # list available package
alias pc='yay -Sc' # remove unused cache
alias po='yay -Qtdq | yay -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias vc='code' # gui code editor
alias fastfetch='fastfetch --logo-type kitty'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias mkdir='mkdir -p'

zoxide init fish | source
