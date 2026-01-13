function docker_build
    argparse v/verbose -- $argv
    or return 1

    test -n "$_flag_verbose"
    or set quiet --quiet

    set repo (string escape --no-quoted (git rev-parse --show-toplevel))
    docker build $quiet --label=tide=test --tag=tide-test:latest --file="$repo/tests/utils/Dockerfile" "$repo"
end

function docker_run
    argparse b/bind d/debug k/keep r/rebuild -- $argv
    or return 1

    set -a flags --label=tide=test --tty

    test -n "$_flag_bind"
    and set -a flags --volume=(git rev-parse --show-toplevel):/home/tide/src/tide

    if test -n "$_flag_debug"
        set -a flags --interactive
        set -a build_flags --verbose
    else
        set cmd -c "$argv"
    end

    test -n "$_flag_keep"
    or set -a flags --rm

    test -n "$_flag_rebuild" || test -z "$_flag_bind" || not docker_has_image
    and docker_build $build_flags

    docker run $flags tide-test:latest $cmd
end

function docker_clean
    docker container prune --force --filter=label=tide=test
    docker_has_image && docker image rm tide-test:latest
    docker image prune --force --filter=label=tide=test
end

function docker_has_image
    docker image list --quiet tide-test:latest | grep --quiet '[a-z0-9]'
end
