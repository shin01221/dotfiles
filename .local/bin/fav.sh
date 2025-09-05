path="$(cat $HOME/.local/state/quickshell/user/generated/wallpaper/path.txt)"
target_base=/Media/Pictures/fav

KEYWORDS="cum|penis|sex|handjob|anal|nipples|pussy|tribadism|masturbation|anus|topless|cunnilingus|naked|nude|swisuit|thong|underboob|underwear|panties|bikini|breast_grab|bra|see_through"

filename=$(basename "$path")
lowername=$(echo "$filename" | tr '[:upper:]' '[:lower:]')

if [[ "$lowername" =~ $KEYWORDS ]]; then
	# If filename has keyword → move inside homework
	mv "$path" "$target_base/hot"
else
	# Otherwise → move inside general
	mv "$path" "$target_base/goood"
fi
