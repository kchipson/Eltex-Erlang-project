-module(restapi_server).
-behaviour(gen_server).

-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-record (state, {}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


dispatch_rules() ->
    cowboy_router:compile([
        %% {HostMatch, list({PathMatch, Handler, InitialState})} 
        {'_', [
            {"/hello", hello_handler, []},
            {"/api/users", handler_users, []},
            {"/api/users/register", handler_users, []},
            {"/api/users/login", handler_users, []},
            {"/api/users/logout", handler_users, []}
        ]}
    ]).

init([]) ->
    
    Dispatch = dispatch_rules(),
    {ok, Port} = application:get_env(restapi, port),

    %% Name, TransOpts , ProtoOpts 
    {ok, _} = cowboy:start_clear(rest_api_listener,
        [{port, Port}],
        #{env => #{dispatch => Dispatch}}
    ),
    {ok, #state{}}.

handle_call(_Request, _From, State) ->
    {noreply, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.