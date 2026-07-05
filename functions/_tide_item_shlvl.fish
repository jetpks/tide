function _tide_item_shlvl
    # Non-interactive shells do not increment SHLVL, so we don't need to subtract 1
    test $SHLVL -gt $tide_shlvl_threshold && _tide_print_item shlvl (_tide_icon $tide_shlvl_icon) $SHLVL
end
