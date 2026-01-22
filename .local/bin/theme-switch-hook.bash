#!/usr/bin/env bash

settings=$HOME/.config/noctalia/settings.json
matugen_conf=$HOME/.config/noctalia/user-templates.toml
auto_colors=$(jq -r '.colorSchemes.useWallpaperColors' "$settings")
theme=$(jq -r '.colorSchemes.predefinedScheme' "$settings")
mode=$(jq -r '.colorSchemes.darkMode' "$settings")
starship_configs=$HOME/.config/starship
tmux_themes=$HOME/.config/tmux/themes
tmux_config=$HOME/.config/tmux/tmux.conf
themes_arr=("Ayu" "Gruvbox" "Eldritch" "Everforest" "GruvboxAlt" "Kanagawa" "Miasma" "Monochrome" "Noctalia (default)" "Nord" "Rose Pine" "Tokyo Night Moon")

if [[ $auto_colors = true ]]; then
    if rg -q '^#\s*source-file .*colors.conf' "$tmux_config" && rg -q '^\s*source-file .*theme.conf' "$tmux_config"; then
        sed -i 's|^#\s*source-file\s.*colors.conf|source-file ~/.config/tmux/colors.conf|' "$tmux_config"
        sed -i 's|^\s*source-file\s.*theme.conf|#source-file ~/.config/tmux/theme.conf|' "$tmux_config"
    else
        sed -i 's|^#\s*source-file\s.*colors.conf|source-file ~/.config/tmux/colors.conf|' "$tmux_config"
    fi
    tmux source-file ~/.config/tmux/colors.conf >/dev/null 2>&1 || true
    exit
else
    if rg -q '^\s*source-file .*colors.conf' "$tmux_config" && rg -q '^#\s*source-file .*theme.conf' "$tmux_config"; then
        sed -i 's|^\s*source-file\s.*colors.conf|#source-file ~/.config/tmux/colors.conf|' "$tmux_config"
        sed -i 's|^#\s*source-file\s.*theme.conf|source-file ~/.config/tmux/theme.conf|' "$tmux_config"
    else
        sed -i 's|^#\s*source-file\s.*theme.conf|source-file ~/.config/tmux/theme.conf|' "$tmux_config"
    fi
    ayu() {
        if [[ "$mode" = "true" ]]; then
            if [[ "${themes_arr[0]}" = "$theme" ]]; then
                cp "$starship_configs/starship.toml-ayu-dark" "$HOME/.config/starship.toml"
                cp "$tmux_themes/ayu-dark.conf" "$HOME/.config/tmux/theme.conf"
            fi
        else
            cp "$starship_configs/starship.toml-ayu-light" "$HOME/.config/starship.toml"
            cp "$tmux_themes/ayu-light.conf" "$HOME/.config/tmux/theme.conf"
        fi
    }
    gruvbox() {
        if [[ "$mode" = "true" ]]; then
            if [[ "${themes_arr[1]}" = "$theme" ]]; then
                cp "$starship_configs/starship.toml-gruvbox-dark" "$HOME/.config/starship.toml"
                cp "$tmux_themes/gruvbox-dark.conf" "$HOME/.config/tmux/theme.conf"

            fi
        else
            cp "$starship_configs/starship.toml-gruvbox-light" "$HOME/.config/starship.toml"
            cp "$tmux_themes/gruvbox-light.conf" "$HOME/.config/tmux/theme.conf"
        fi
    }
    elderich() {
        if [[ "$mode" = "true" ]]; then
            if [[ "${themes_arr[2]}" = "$theme" ]]; then
                cp "$starship_configs/starship.toml-elderich-dark" "$HOME/.config/starship.toml"
                cp "$tmux_themes/elderich-dark.conf" "$HOME/.config/tmux/theme.conf"
            fi
        else
            cp "$starship_configs/starship.toml-elderich-light" "$HOME/.config/starship.toml"
            cp "$tmux_themes/elderich-light.conf" "$HOME/.config/tmux/theme.conf"
        fi
    }
    everfrost() {
        if [[ "$mode" = "true" ]]; then
            if [[ "${themes_arr[3]}" = "$theme" ]]; then
                cp "$starship_configs/starship.toml-everfrost-dark" "$HOME/.config/starship.toml"
                cp "$tmux_themes/everforest-dark.conf" "$HOME/.config/tmux/theme.conf"
            fi
        else
            cp "$starship_configs/starship.toml-everfrost-light" "$HOME/.config/starship.toml"
            cp "$tmux_themes/everforest-light.conf" "$HOME/.config/tmux/theme.conf"
        fi
    }
    gruvboxalto() {
        if [[ "$mode" = "true" ]]; then
            if [[ "${themes_arr[4]}" = "$theme" ]]; then
                cp "$starship_configs/starship.toml-gruvboxalto-dark" "$HOME/.config/starship.toml"
                cp "$tmux_themes/gruvboxalto-dark.conf" "$HOME/.config/tmux/theme.conf"
            fi
        else
            cp "$starship_configs/starship.toml-gruvboxalto-light" "$HOME/.config/starship.toml"
            cp "$tmux_themes/gruvboxalto-light.conf" "$HOME/.config/tmux/theme.conf"
        fi
    }
    kanagwa() {
        if [[ "$mode" = "true" ]]; then
            if [[ "${themes_arr[5]}" = "$theme" ]]; then
                cp "$starship_configs/starship.toml-kanagwa-dark" "$HOME/.config/starship.toml"
                cp "$tmux_themes/kanagwa-dark.conf" "$HOME/.config/tmux/theme.conf"
            fi
        else
            cp "$starship_configs/starship.toml-kanagwa-light" "$HOME/.config/starship.toml"
            cp "$tmux_themes/kanagwa-light.conf" "$HOME/.config/tmux/theme.conf"
        fi
    }
    miasma() {
        if [[ "$mode" = "true" ]]; then
            if [[ "${themes_arr[6]}" = "$theme" ]]; then
                cp "$starship_configs/starship.toml-miasma-dark" "$HOME/.config/starship.toml"
                cp "$tmux_themes/miasma-dark.conf" "$HOME/.config/tmux/theme.conf"
            fi
        else
            cp "$starship_configs/starship.toml-miasma-light" "$HOME/.config/starship.toml"
            cp "$tmux_themes/miasma-light.conf" "$HOME/.config/tmux/theme.conf"
        fi
    }
    monochrome() {
        if [[ "$mode" = "true" ]]; then
            if [[ "${themes_arr[7]}" = "$theme" ]]; then
                cp "$starship_configs/starship.toml-monochrome-dark" "$HOME/.config/starship.toml"
                cp "$tmux_themes/monochrome-dark.conf" "$HOME/.config/tmux/theme.conf"
            fi
        else
            cp "$starship_configs/starship.toml-monochrome-light" "$HOME/.config/starship.toml"
            cp "$tmux_themes/monochrome-light.conf" "$HOME/.config/tmux/theme.conf"
        fi
    }
    noctalia() {
        if [[ "$mode" = "true" ]]; then
            if [[ "${themes_arr[8]}" = "$theme" ]]; then
                cp "$starship_configs/starship.toml-noctalia-dark" "$HOME/.config/starship.toml"
                cp "$tmux_themes/noctalia-dark.conf" "$HOME/.config/tmux/theme.conf"
            fi
        else
            cp "$starship_configs/starship.toml-noctalia-light" "$HOME/.config/starship.toml"
            cp "$tmux_themes/noctalia-light.conf" "$HOME/.config/tmux/theme.conf"
        fi
    }
    nord() {
        if [[ "$mode" = "true" ]]; then
            if [[ "${themes_arr[9]}" = "$theme" ]]; then
                cp "$starship_configs/starship.toml-nord-dark" "$HOME/.config/starship.toml"
                cp "$tmux_themes/nord-dark.conf" "$HOME/.config/tmux/theme.conf"

            fi
        else
            cp "$starship_configs/starship.toml-nord-light" "$HOME/.config/starship.toml"
            cp "$tmux_themes/nord-light.conf" "$HOME/.config/tmux/theme.conf"
        fi
    }
    rosepine() {
        if [[ "$mode" = "true" ]]; then
            if [[ "${themes_arr[10]}" = "$theme" ]]; then
                cp "$starship_configs/starship.toml-rosepine-dark" "$HOME/.config/starship.toml"
                cp "$tmux_themes/rosepine-dark.conf" "$HOME/.config/tmux/theme.conf"
            fi
        else
            cp "$starship_configs/starship.toml-rosepine-light" "$HOME/.config/starship.toml"
            cp "$tmux_themes/rosepine-light.conf" "$HOME/.config/tmux/theme.conf"
        fi
    }
    tokyounightmoon() {
        if [[ "$mode" = "true" ]]; then
            if [[ "${themes_arr[11]}" = "$theme" ]]; then
                cp "$starship_configs/starship.toml-tokyounightmoon-dark" "$HOME/.config/starship.toml"
                cp "$tmux_themes/tokyounightmoon-dark.conf" "$HOME/.config/tmux/theme.conf"
            fi
        else
            cp "$starship_configs/starship.toml-tokyounightmoon-light" "$HOME/.config/starship.toml"
            cp "$tmux_themes/tokyounightmoon-light.conf" "$HOME/.config/tmux/theme.conf"
        fi
    }
    case "$theme" in
    "${themes_arr[0]}")
        ayu
        ;;
    "${themes_arr[1]}")
        gruvbox
        ;;
    "${themes_arr[2]}")
        elderich
        ;;
    "${themes_arr[3]}")
        everfrost
        ;;
    "${themes_arr[4]}")
        gruvboxalto
        ;;
    "${themes_arr[5]}")
        kanagwa
        ;;
    "${themes_arr[6]}")
        miasma
        ;;
    "${themes_arr[7]}")
        monochrome
        ;;
    "${themes_arr[8]}")
        noctalia
        ;;
    "${themes_arr[9]}")
        nord
        ;;
    "${themes_arr[10]}")
        rosepine
        ;;
    "${themes_arr[11]}")
        tokyounightmoon
        ;;
    esac
    tmux source-file ~/.config/tmux/theme.conf >/dev/null 2>&1 || true
fi
