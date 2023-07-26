-module(episode_1).

-export([
    option/3,
    is_some/1,
    is_nothing/1,
    from_just/1,
    from_maybe/2,
    option_to_list/1,
    list_to_option/1,
    cat_options/1,
    map_option/2
]).

-export_type([option/1]).

% Note: https://www.erlang.org/doc/reference_manual/expressions.html#maybe
% 'maybe' is an experimental keyword, we'll use 'option' not to clash

% Type Reference: https://www.erlang.org/doc/reference_manual/typespec.html

% Implemented all of https://hackage.haskell.org/package/base-4.18.0.0/docs/Data-Maybe.html

-type option(A) :: none | {some, A}.

-spec option(A, fun((A) -> B), option(A)) -> B.
option(_Default, F, {some, X}) -> F(X);
option(Default, _F, _) -> Default.

-spec is_some(option(_)) -> boolean().
is_some({some, _}) -> true;
is_some(_) -> false.

-spec is_nothing(option(_)) -> boolean().
is_nothing(none) -> true;
is_nothing(_) -> false.

-spec from_just(option(A)) -> option(A) | no_return().
from_just({some, X}) -> X;
from_just(_) -> throw({is_none, "Expected some, got none"}).

-spec from_maybe(A, option(A)) -> A.
from_maybe(_Default, {some, X}) -> X;
from_maybe(Default, _) -> Default.

-spec option_to_list(option(A)) -> list(A).
option_to_list({some, X}) -> [X];
option_to_list(_) -> [].

-spec list_to_option(list(A)) -> option(A).
list_to_option([X]) -> {some, X};
list_to_option(_) -> none.

-spec identity(A) -> A.
identity(X) -> X.

-spec cat_options(list(option(A))) -> list(A).
cat_options(Xs) -> map_option(fun identity/1, Xs).

-spec map_option(fun((A) -> option(B)), list(A)) -> list(B).
map_option(_Fun, []) ->
    [];
map_option(Fun, [X | Rest]) ->
    case Fun(X) of
        {some, Y} ->
            io:format("~p~n", [Y]),
            [Y | map_option(Fun, Rest)];
        none ->
            io:format("~p~n", [X]),
            map_option(Fun, Rest)
    end.
