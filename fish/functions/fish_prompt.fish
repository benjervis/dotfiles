function fish_prompt
    set formatted_pwd (string join '' -- \
        (set_color --background green) \
        (set_color black) \
        " " \
        (prompt_pwd --full-length-dirs 2) \
        " " \
        (set_color normal))

    set git_prompt_result (fish_git_prompt)

    if test -n "$git_prompt_result"
        set formatted_git (string join '' -- \
        (set_color --background yellow) \
        (set_color black) \
        $git_prompt_result \
        ' ' \
        (set_color normal))
    else
        set formatted_git ""
    end

    string join -n ' ' $formatted_pwd $formatted_git
    echo '> '
end

function fish_right_prompt
    echo ""
end
