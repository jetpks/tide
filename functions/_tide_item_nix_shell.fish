function _tide_item_nix_shell
    set -q IN_NIX_SHELL && _tide_print_item nix_shell (_tide_icon $tide_nix_shell_icon) $IN_NIX_SHELL
end
