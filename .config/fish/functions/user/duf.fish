function _df
    if test (count $argv) -ge 1 -a -e $argv[-1]
        duf $argv[-1]
    else
        duf
    end
end

if type -q duf
    alias df="_df"
end
