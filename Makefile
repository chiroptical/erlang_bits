build:
	rebar3 compile

format:
	alejandra --quiet .
	rebar3 fmt --write

check:
	alejandra --check .
	rebar3 fmt --check
	rebar3 dialyzer
	rebar3 gradualizer

typecheck:
	rebar3 gradualizer
	rebar3 dialyzer

test:
	rebar3 eunit

shell:
	rebar3 shell

.PHONY: build format check typecheck test shell
