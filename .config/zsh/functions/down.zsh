down() {
  local quality="$1"      # Get the first argument
  shift                   # Remove the first argument
  yt-dlp -S "res:${quality}" -- "$@"
}
