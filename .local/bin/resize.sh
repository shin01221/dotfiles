find "$HOME/Downloads/upscayl_png_upscayl-standard-4x_3x/pat/" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | while read -r img; do
    height=$(identify -format "%h" "$img")
    new_height=$((height - 80))
    magick.sh --resize-height "$img" "$img" "$new_height"
done
