SHELL := /usr/bin/env fish

.PHONY: all
all: fmt lint install test

.PHONY: fmt
fmt:
	@fish_indent --write **.fish

.PHONY: lint
lint:
	@for file in **.fish; fish --no-execute $$file; end

.PHONY: install
install: fisher
	@fisher install . >/dev/null

.PHONY: fisher
fisher:
	@type -q fisher || begin; curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher; end

.PHONY: testsetup
testsetup: fisher
	@type -q mock || fisher install IlanCosman/clownfish
	@test -e littlecheck.py || curl -sL https://raw.githubusercontent.com/ridiculousfish/littlecheck/HEAD/littlecheck/littlecheck.py -o littlecheck.py
	@test -e $$__fish_config_dir/conf.d/tide_test_setup.fish || cp tests/utils/tide_test_setup.fish $$__fish_config_dir/conf.d/tide_test_setup.fish
	@test -e $$__fish_config_dir/functions/_tide_decolor.fish || cp tests/utils/_tide_decolor.fish $$__fish_config_dir/functions/_tide_decolor.fish

.PHONY: test
test: testsetup install
	@_tide_remove_unusable_items
	@_tide_cache_variables; python3 littlecheck.py --progress tests/**.test.fish

.PHONY: dockertest
dockertest:
	@source tests/utils/docker.fish && docker_run make test

.PHONY: dockerdebug
dockerdebug:
	@source tests/utils/docker.fish && docker_run --debug

.PHONY: clean
clean:
	@not type -q docker || begin; source tests/utils/docker.fish && docker_clean; end
	@not test -e littlecheck.py || rm littlecheck.py
