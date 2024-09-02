function use_color
    string join "" (set_color $argv[1]) $argv[2] (set_color normal)
end

function set_yellow
    use_color yellow $argv[1]
end

function set_green
    use_color green $argv[1]
end

function set_blue
    use_color blue $argv[1]
end
