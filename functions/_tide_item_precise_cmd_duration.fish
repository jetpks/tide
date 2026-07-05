function _tide_item_precise_cmd_duration
    test $CMD_DURATION -gt $tide_precise_cmd_duration_threshold || return

    set units days hours minutes seconds milliseconds
    set unit_lengths 86400000 3600000 60000 1000 1
    set remainder $CMD_DURATION
    set result "unknown duration"

    for i in (seq (count $unit_lengths))
        set $units[$i] (math -s 0 $remainder / $unit_lengths[$i])
        set remainder (math -s 0 $remainder % $unit_lengths[$i])
    end
    set fractional_seconds (math -s (test $seconds -gt 9 && echo 1 || echo 2) $seconds.$milliseconds / 1)

    if test $days -gt 0
        set result "$days"d"$hours"h"$minutes"m
    else if test $hours -gt 0
        set result "$hours"h"$minutes"m
    else if test $minutes -gt 9
        set result "$minutes"m"$seconds"s
    else if test $minutes -gt 0
        set result "$minutes"m"$fractional_seconds"s
    else if test $seconds -gt 0
        set result "$fractional_seconds"s
    else
        set result "$milliseconds"ms
    end

    _tide_print_item precise_cmd_duration (_tide_icon $tide_cmd_duration_icon) $result
end
