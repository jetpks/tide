function _tide_item_toolbox
    test -e /run/.toolboxenv &&
        _tide_print_item toolbox (_tide_icon $tide_toolbox_icon) (string match -rg 'name="(.*)"' </run/.containerenv)
end
