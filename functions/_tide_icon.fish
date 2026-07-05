# Render an item's icon for its prompt slot: the icon followed by a single
# padding space, or nothing at all when the icon is unset or empty. Keeps an
# empty icon (e.g. `set -U tide_git_icon ''`) from leaving a lone leading space
# ahead of the item's content.
function _tide_icon -a icon
    test -n "$icon" && echo -ns $icon' '
end
