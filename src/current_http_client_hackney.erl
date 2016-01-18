-module(current_http_client_hackney).

-behaviour(current_http_client).

-export([post/4, parse_url/1, get_host_of_url/1]).

-include_lib("hackney/include/hackney_lib.hrl").

post(URL, Headers, Body, Opts) ->
    HackneyOpts = proplists:get_value(hackney_options, Opts, []),
    case hackney:request(post, URL, Headers, Body, HackneyOpts) of
        {ok, ResponseCode, ResponseHeaders, Client} ->
            {ok, ResponseBody} = hackney:body(Client),
            {ok, {{ResponseCode, "unknown"}, ResponseHeaders, ResponseBody}};
        E = {error, _} ->
            E;
        Other ->
            {error, {"didn't understand the response", Other}}
    end.

parse_url(Url) ->
    hackney_url:parse_url(Url).

get_host_of_url(#hackney_url{host = Host}) ->
    Host.
