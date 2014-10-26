-module(euler12).

-export([fact/0]).
-export([num_factors/1]).
-export([num_factors/3]).

fact() ->
    fact(1, 0).

fact(X, Sum) ->
    case num_factors(X + Sum) of
        Y when Y > 500 ->
            X;
        Y ->
            io:format("X = ~p, sum = ~p, num factors: ~p~n", [X, Sum + X, Y]),
            fact(X + 1, X + Sum)
    end.

%seq_sum(X) ->
    %lists:foldl(fun(Y, Sum) -> Y + Sum end, 0, lists:seq(1, X)).

num_factors(X) ->
    num_factors(X, 2, [1, X]).

num_factors(X, Factor, Factors) when Factor =< trunc(X / 2) ->
    Factors2 = case X rem Factor of
                   0 when Factor == trunc(X / Factor) ->
                       [Factor | Factors];
                   0 ->
                       [Factor, trunc(X / Factor) | Factors];
                   _ ->
                       Factors
               end,
    num_factors(X, next_factor(Factor + 1, Factors2), Factors2);
num_factors(_, _, Factors) ->
    io:format("Factors: ~p~n", [Factors]),
    length(Factors).

next_factor(X, Xs) ->
    case lists:member(X, Xs) of
        true ->
            next_factor(X + 1, Xs);
        false ->
            X
    end.

factors(X) ->
    factors(2, [], [X, 1]).

factors(Y, [LastSmall | _] = Small, [Rem | _] = Large) when Rem rem Y == 0
    NewRem = trunc(Rem rem Y),
    Compound = compound_factors(Small, Y),
    factors(Rem, 2, Base, [Y | Small], [NewRem | Large] ++ Compound);
factors(X, Y, Base, Small, Large) ->
  factors(X, Y + 1, Base, Small, Large).

compound_factors([], New) ->
    [New];
compound_factors([Prev | _], New) when Prev == New ->
    [];
compound_factors([First | Rest], New) ->
    lists:foldl(fun compound/2, [First * New], Rest).

compound(Small, [C | _] = Compound) ->
    [Small * C | Compound].

36
1 * 36
   2 * 18
      2 * 9
         3 * 3
       6
    4
 12

1 * 58
   2 * 29

1 * 64
   2 * 32
      2 * 16
         2 * 8
           2 * 4
             2 * 2

1 * 70
   2 * 35
     7 * 5

1 * 48
   2 * 24
     2 * 12
       2 * 6
         2 * 3
