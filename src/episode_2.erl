-module(episode_2).
-export([logging_test/0]).

% https://www.erlang.org/doc/man/logger.html#type-level
% emergency | alert | critical | error | warning | notice | info | debug

% https://www.erlang.org/doc/man/kernel_app#configuration
% Level = emergency | alert | critical | error | warning | notice | info | debug | all | none
% Default = notice

% Adjust in config/sys.config, need to uncomment rebar.config

logging_test() ->
    logger:debug("debug"),
    logger:info("info"),
    logger:notice("notice"),
    logger:warning("warning"),
    logger:error("error"),
    logger:critical("critical"),
    logger:alert("alert"),
    logger:emergency("emergency"),
    ok.
