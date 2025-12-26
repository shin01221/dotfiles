set EDITOR nvim
if test -f ~/.config/fish/colors.fish
    source ~/.config/fish/colors.fish
end
set -g fish_term24bit 1
set -g fish_key_bindings fish_vi_key_bindings
set -Ux fifc_editor nvim
set -gx MANPAGER "nvim +Man!"
bind -M insert jj 'set fish_bind_mode default; commandline -f repaint-mode'

# sourcing my functions
for f in ~/.config/fish/functions/user/*.fish
    source $f
end

set -gx PATH $HOME/.local/bin $HOME/go/bin $HOME/.cargo/bin $PATH

starship init fish | source
if status is-interactive # Commands to run in interactive sessions can go here
    # No greeting
    set fish_greeting
    # if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    #     cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    # end
    set cur_wall (jq -r '.background.wallpaperPath' ~/.config/illogical-impulse/config.json)
end

zoxide init fish | source
atuin init fish --disable-up-arrow | source
bind k _atuin_search
bind \cr _atuin_search
bind -M insert \cr _atuin_search
source ~/.config/fish/atuin.fish

# Auto start Hyprland on tty1
if test -z "$DISPLAY"; and test "$XDG_VTNR" -eq 1
    mkdir -p ~/.cache
    exec Hyprland >~/.cache/hyprland.log 2>&1
end

tmux-set

# aliases
alias pamcan pacman
alias ls 'eza --icons'
# alias ip 'ip -c'
alias clear "printf '\033[2J\033[3J\033[1;1H'"
alias q 'qs -c ii'
alias pn="source ~/.local/venvs/nudenet/bin/activate.fish"
alias down360='down 360'
alias down480='down 480'
alias down720='down 720'
alias down1080='down 1080'
alias df="_df"
# alias mirrors='sudo reflector --country Germany,France,Italy --latest 30 --sort age --protocol https --save /etc/pacman.d/mirrorlist'
alias mirrors='sudo reflector --verbose --protocol https --sort rate --latest 70 --download-timeout 6 --save /etc/pacman.d/mirrorlist'
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
