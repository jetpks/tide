function _tide_item_distrobox
    test -e /etc/profile.d/distrobox_profile.sh && test -e /run/.containerenv &&
        _tide_print_item distrobox (_tide_icon $tide_distrobox_icon) (string match -rg 'name="(.*)"' </run/.containerenv)
end
