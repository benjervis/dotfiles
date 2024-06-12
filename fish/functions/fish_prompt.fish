function fish_prompt
    string join '' -- \
        (set_color --background green) \
        (set_color black) \
        " " \
        (prompt_pwd --full-length-dirs 2) \
        " " \
        (set_color normal) \
        " " \
        (set_color --background yellow) \
        (set_color black) \
        (fish_git_prompt) \
        ' ' \
        (set_color normal)
    echo '> '
end

function fish_right_prompt
    echo ""
end
