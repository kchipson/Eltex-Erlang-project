%%%-------------------------------------------------------------------
%% @doc restapi public API
%% @end
%%%-------------------------------------------------------------------

-module(restapi_app).

-behaviour(application).

-export([start/2, stop/1]).




start(_StartType, _StartArgs) ->
    {ok, _} = application:ensure_all_started(cowboy),

    restapi_sup:start_link().

stop(_State) ->
    ok = cowboy:stop_listener(rest_api_listener).

%% internal functions
