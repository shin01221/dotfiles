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

    # Use starship
    # if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    #     cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    # end

    starship init fish | source
    tmux-set
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
