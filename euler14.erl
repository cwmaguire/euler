-module(euler14).

% Work out the first ten digits of the sum of the
% following one-hundred 50-digit numbers.

-export([longest_chain/0]).
-export([chain/1]).

longest_chain() ->
    ChainLengths = [{X, length(chain([X]))} || X <- lists:seq(999999, 1, -1)],
    {Int, _} = hd(lists:sort(fun({_, X}, {_, Y}) -> X > Y end, ChainLengths)),
    Int.

chain([1 | _] = Chain) ->
    Chain;
chain([X | _] = Chain) when X rem 2 == 0 ->
    chain([trunc(X / 2) | Chain]);
chain([X | _] = Chain) ->
    chain([3 * X + 1 | Chain]).
