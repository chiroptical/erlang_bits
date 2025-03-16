build:
	rebar3 compile

format:
	nixfmt **.nix
	rebar3 fmt --write

check:
	alejandra --check .
	rebar3 fmt --check
	rebar3 dialyzer
	rebar3 gradualizer

dialyzer:
	rebar3 dialyzer

gradualizer:
	rebar3 gradualizer

typecheck: dialyzer gradualizer

test:
	rebar3 eunit

shell:
	rebar3 shell

clean:
	rebar3 clean

.PHONY: build format check dialyzer gradualizer typecheck test shell clean
