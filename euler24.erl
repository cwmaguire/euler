-module(euler24).

% A permutation is an ordered arrangement of objects. For example, 3124 is one
% possible permutation of the digits 1, 2, 3 and 4. If all of the permutations
% are listed numerically or alphabetically, we call it lexicographic order.
% The lexicographic permutations of 0, 1 and 2 are:

% 012   021   102   120   201   210

% What is the millionth lexicographic permutation of the
% digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

-export([nth_perm/0]).
-export([nth_perm/3]).
-export([fact/1]).

nth_perm() ->
    nth_perm(1000000, lists:seq(0,9), []).

nth_perm(_, [], Perms) ->
    lists:reverse(Perms);
nth_perm(X, Elems, Perms) ->
    NumSubPerms = fact(length(Elems) - 1),
    Quotient = trunc(X / NumSubPerms),
    {Index, Rem} = case X rem NumSubPerms of
              0 ->
                  {Quotient, NumSubPerms};
              R ->
                  {Quotient + 1, R}
          end,
    Perm = lists:nth(Index, Elems),
    nth_perm(Rem, lists:delete(Perm, Elems), [Perm | Perms]).

fact(0) ->
    1;
fact(N) ->
    lists:foldl(fun(X, Prod) -> X * Prod end, 1, lists:seq(2, N)).
