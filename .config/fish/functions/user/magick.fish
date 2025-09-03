function imgtool
    # Usage:
    #   imgtool --resize-height in.png out.png HEIGHT
    #   imgtool --resize-width  in.png out.png WIDTH
    #   imgtool --downscale           in.png out.png PERCENT

    set -l mode $argv[1]
    set -l input $argv[2]
    set -l output $argv[3]
    set -l val $argv[4]

    if test -z "$mode" -o -z "$input" -o -z "$output" -o -z "$val"
        echo "Usage: imgtool (--resize-height | --resize-width | --downscale) <input> <output> <value>" >&2
        return 1
    end

    switch $mode
        case --resize-height
            # Crop to given height, keep width
            magick "$input" -gravity North -crop "x$val+0+0" +repage "$output"

        case --resize-width
            # Crop to given width, keep height
            magick "$input" -gravity West -crop "$val"x+0+0 +repage "$output"

        case --downscale
            if string match -rq '%$' -- "$val"
                set val (string replace -r '%$' '' -- "$val")
            end
            magick "$input" -resize "$val%" "$output"

        case '*'
            echo "Error: mode must be --resize-height, --resize-width, or --downscale" >&2
            return 1
    end
end
