-module(episode_3).
-behaviour(gen_server).

-export([
    start_link/0,
    init/1,
    handle_call/3,
    handle_cast/2
]).

%% https://www.erlang.org/doc/man/gen_server#start_link-4
start_link() ->
    % passed to init/1 to initialize state
    Init = [],
    % https://www.erlang.org/doc/man/gen_server#type-start_opt
    StartOpts = [],
    gen_server:start_link({local, ?MODULE}, ?MODULE, Init, StartOpts).

%% https://www.erlang.org/doc/man/gen_server#Module:init-1
init([]) ->
    {ok, {}}.

%% https://www.erlang.org/doc/man/gen_server#Module:handle_call-3
%% _From https://www.erlang.org/doc/man/gen_server#type-from
handle_call(Msg, _From, State) ->
    logger:notice("Got ~p~n", [Msg]),
    Reply = {},
    {reply, Reply, State}.

%% https://www.erlang.org/doc/man/gen_server#Module:handle_cast-2
handle_cast(Msg, State) ->
    logger:notice("Got ~p~n", [Msg]),
    {noreply, State}.
