function imgtool
    set -l mode $argv[1]
    set -l input $argv[2]
    set -l output $argv[3]
    set -l val $argv[4]
    set -l position $argv[5]

    if test -z "$mode" -o -z "$input" -o -z "$output" -o -z "$val"
        echo "Usage:"
        echo "  imgtool --resize-height <in> <out> HEIGHT [top|bottom|center]"
        echo "  imgtool --resize-width  <in> <out> WIDTH  [left|right|center]"
        echo "  imgtool --downscale     <in> <out> PERCENT"
        return 1
    end

    if test "$mode" = --resize-width
        if not set -q position
            set position center
        end
    end

    switch $mode
        case --resize-height
            switch "$position"
                case top
                    magick "$input" -gravity North -crop "x$val+0+0" +repage "$output"
                case center
                    magick "$input" -gravity Center -crop "x$val+0+0" +repage "$output"
                case bottom '*'
                    magick "$input" -gravity South -crop "x$val+0+0" +repage "$output"
            end

        case --resize-width
            switch "$position"
                case left
                    magick "$input" -gravity West -crop "$val"x+0+0 +repage "$output"
                case right
                    magick "$input" -gravity East -crop "$val"x+0+0 +repage "$output"
                case center '*'
                    magick "$input" -gravity Center -crop "$val"x+0+0 +repage "$output"
            end

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
