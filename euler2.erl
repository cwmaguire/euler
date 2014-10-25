-module(euler2).

-export([fib/0]).
-export([fib/2]).

-define(FOUR_MILLION, 4000000).

fib() ->
  fib({1, 2}, _Sum = 0).

fib({X1, X2}, Sum) when X2 =< ?FOUR_MILLION ->
    NewSum = case X2 rem 2 of
                0 -> Sum + X2;
                _ -> Sum
             end,
  fib({X2, X1 + X2}, NewSum);

fib(_, Sum) ->
  Sum.
