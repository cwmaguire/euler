-module(euler4).

-export([largest_palindrome/0]).
-export([is_palindrome/1]).

is_palindrome(X) when is_integer(X) ->
  is_palindrome(integer_to_list(X));

is_palindrome([First | [_ | _] = Rest]) ->
  [Last | Middle] = lists:reverse(Rest),
  case First == Last of
      true ->
        is_palindrome(Middle);
      false ->
        false
  end;

is_palindrome([_]) ->
  true;

is_palindrome([]) ->
 true.

largest_palindrome() ->
    Numbers = lists:seq(999, 100, -1),
    Products = [X * Y || X <- Numbers, Y <- Numbers, is_palindrome(X * Y)],
    hd(lists:reverse(lists:sort(Products))).
