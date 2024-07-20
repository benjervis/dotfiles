function fish_prompt
    if test "$(uname)" = Darwin
        set bg_color green
    else
        set bg_color brmagenta
    end

    set prompt_items

    set prompt_items $prompt_items (string join '' -- \
        (set_color --background $bg_color) \
        (set_color black) \
        " " \
        (prompt_pwd --full-length-dirs 2) \
        " " \
        (set_color normal))

    set git_prompt_result (fish_git_prompt)

    if test -n "$git_prompt_result"
        set prompt_items $prompt_items (string join '' -- \
        (set_color --background yellow) \
        (set_color black) \
        $git_prompt_result \
        ' ' \
        (set_color normal))
    end

    if is_parcel_lunk
        set prompt_items $prompt_items (string join '' -- \
          (set_color --background brblue) \
          (set_color --bold) \
          (set_color white) \
          " PARCEL LINK " \
          (set_color normal)
        )
    end

    string join -n ' ' $prompt_items
    echo '> '
end

function fish_right_prompt
    echo ""
end
