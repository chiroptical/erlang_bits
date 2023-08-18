-module(episode_4).
-behaviour(gen_server).

% https://github.com/kivra/restclient
% Enable restc in erlang_bits.app.src
% https://github.com/fedspendingtransparency/usaspending-api/blob/master/usaspending_api/api_contracts/contracts/v2/search/spending_by_category/county.md

-export([
    start_link/0,
    init/1,
    handle_call/3,
    handle_cast/2
]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

-record(state, {api_url = "https://api.usaspending.gov/api/v2/search/spending_by_category/county"}).

init([]) ->
    {ok, #state{}}.

handle_call(ping, _From, State) ->
    {reply, pong, State};
handle_call({county, County}, _From, State = #state{api_url = ApiUrl}) ->
    Body = #{
        filters => #{
            % might be better to use unicode:characters_to_binary/1 function here?
            recipient_search_text => [list_to_binary(County)],
            time_period => [
                #{
                    start_date => <<"2022-01-01">>,
                    end_date => <<"2022-12-31">>
                }
            ]
        }
    },
    {ok, 200, _Headers, Response} = restc:request(
        % request method
        post,
        % content type
        json,
        % request URL, restc:construct_url can be useful for query parameters
        ApiUrl,
        % expected status codes
        [200],
        % headers as proplist
        [],
        % Automatically converted to JSON for us
        Body,
        % options
        []
    ),
    logger:notice(#{response => Response}),

    Results = proplists:get_value(<<"results">>, Response),
    logger:notice(#{results => Results}),

    Amounts = lists:foldr(fun collect_amounts/2, maps:new(), Results),
    logger:notice(#{amounts => Amounts}),

    AmountsAsBinary = maps:map(fun(_K, V) -> decimal:to_binary(V) end, Amounts),
    logger:notice(#{as_binary => AmountsAsBinary}),

    {reply, Amounts, State};
handle_call(Msg, _From, State) ->
    logger:notice("Got unknown message ~p~n", [Msg]),
    {reply, ok, State}.

handle_cast(Msg, State) ->
    logger:notice("Got unknown message ~p~n", [Msg]),
    {noreply, State}.

collect_amounts(Proplist, Map) ->
    Name = proplists:get_value(<<"name">>, Proplist),
    Amount = proplists:get_value(<<"amount">>, Proplist),
    Opts = #{precision => 2, rounding => round_floor},
    AmountDecimal = decimal:to_decimal(Amount, Opts),
    maps:update_with(Name, fun(V) -> decimal:add(V, AmountDecimal) end, AmountDecimal, Map).
