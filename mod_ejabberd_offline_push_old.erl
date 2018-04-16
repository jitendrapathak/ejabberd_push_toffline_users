%% name of module must match file name
-module(mod_ejabberd_offline_push_old).
-author("dev@codepond.org").


-export([start/2, stop/1, create_message/3]).

-include("ejabberd.hrl").
-include("/opt/xmpp/include/xmpp.hrl").


start(_Host, _Opt) ->
  inets:start(),
  ejabberd_hooks:add(offline_message_hook, _Host, ?MODULE, create_message, 1).

stop(_Host) ->
  ejabberd_hooks:delete(offline_message_hook, _Host, ?MODULE, create_message, 1).

create_message(_From, _To, Packet)
  when (Packet#message.type == chat) and (Packet#message.body /= []) ->
  [{text, _, Body}] = Packet#message.body,
  [{text, _, Body}] = Packet#message.body,
  post_offline_message(_From, _To, Body, "SubType", Packet#message.id);
create_message(_From, _To, _Packet) ->
  ok.

post_offline_message(From, To, Body, SubType, MessageId) ->
  ToUser = To#jid.luser,
  FromUser = From#jid.luser,
  DataBody = "{\"toJID\":\"" ++ binary_to_list(ToUser) ++ "\",\"fromJID\":\"" ++ binary_to_list(FromUser) ++ "\",\"body\":\"" ++ binary_to_list(Body) ++ "\"}",
  Method = post,
  URL = "http://localhost:7070/api/v3/pushnotification/chat?debug=true",
  Header = [],
  Type = "application/json",
  HTTPOptions = [],
  Options = [],
  %%  inets:start(),
  %%  ssl:start(),
  R = httpc:request(Method, {URL, Header, Type, DataBody}, HTTPOptions, Options),
  io:fwrite(R).
