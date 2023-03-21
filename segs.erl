-module('segs').
-compile(export_all).

%main(_) -> Pid = spawn(fun nano_get_url/0).
main(_) -> 
  spawn_seg_split(io:fread("", "~ts")).
  
spawn_seg_split({ok, UriText}) ->
  spawn(segs, get_voicevox_kana, [UriText]),
  spawn_seg_split(io:fread("", "~ts"));

spawn_seg_split(_) -> done.

get_voicevox_kana(UriText) ->
  {ok, Socket} = gen_tcp:connect("127.0.0.1", 50021, [binary, {packet, 0}]),
  ok = gen_tcp:send(Socket, "POST /audio_query?speaker=3&text="++UriText++" HTTP/1.1\r\nHost: null\r\n\r\n"),
  receive_data(Socket, []).
  
receive_data(Socket, SoFar) ->
  receive
    {tcp,Socket,Bin} ->
      receive_data(Socket, [Bin|SoFar]);
    {tcp_closed,Socket} ->
      Res = list_to_binary(lists:reverse(SoFar)),
      get_kana(rev_bin(Res))
  end.

get_kana(<<_:2/binary,RevKana:64/binary,_/binary>>) ->
  KanaBin = before_q(binary:bin_to_list(RevKana), []),
  KanaList = unicode:characters_to_list(KanaBin),
  split_kana(KanaList, []).
  
before_q([$"|_], SoFar) ->
  binary:list_to_bin(SoFar);
before_q([H|T], SoFar) ->
  before_q(T, [H|SoFar]).


rev_bin(B) ->
  binary:list_to_bin(
    lists:reverse(
    binary:bin_to_list(B))).

split_kana([], Buf) ->
  pass_seg(Buf);

split_kana([$/|T], Buf) ->
  split_kana(T, []),
  pass_seg(Buf);
  
split_kana([12289|T], Buf) ->
  split_kana(T, []),
  pass_seg(Buf);

split_kana([H|T], Buf) ->
  split_kana(T, [H|Buf]).
  
pass_seg([]) -> skip;
pass_seg(RevSeg) -> 
  Seg = erlang:list_to_binary(lists:reverse(RevSeg)),
  io:format("~ts~n", [Seg]).


