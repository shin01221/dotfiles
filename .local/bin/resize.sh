find "$1" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | while read -r img; do
    magick.sh --resize-height "$img" "$img" "$2"
done
