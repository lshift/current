%% @doc HTTP client wrapper
-module(current_http_client).

%%
%% TYPES
%%
-type header()         :: {binary() | string(), any()}.
-type headers()        :: [header()].
-type body()           :: iolist() | binary().
-type options()        :: list({atom(), any()}).
-type response_ok()    :: {ok, {{integer(), string()}, headers(), body()}}.
-type response_error() :: {error, any()}.


%%
%% API
%%
-callback post(binary(), headers(), body(), options()) ->
                  response_ok() | response_error().

-callback parse_url(binary()) -> term().

-callback get_host_of_url(term()) -> binary().
