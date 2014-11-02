-module(euler12).

-export([fact/0]).
-export([factors/1]).
-export([prime_factors/1]).
-export([prime_factors/3]).
-export([combos/1]).
-export([combine/2]).
-export([multiply/1]).

fact() ->
    fact(1, 0).

fact(X, Sum) ->
    case length(factors(X + Sum)) of
        Y when Y > 500 ->
            io:format("~p has ~p factors~n", [X + Sum, Y]),
            X;
        Y when Y > 200 ->
            io:format("~p has ~p factors~n", [X + Sum, Y]),
            fact(X + 1, X + Sum);
        _ ->
            fact(X + 1, X + Sum)
    end.

factors(X) ->
    DupeFactors = [multiply(Factors) || Factors <- combos(prime_factors(X))],
    lists:usort(fun(Y, Z) -> Y =< Z end, [1, X | DupeFactors]).

combos(Xs) ->
    lists:foldl(fun combine/2, _Combos = [], Xs).

combine(Factor, Combos) ->
    [[Factor | Combo] || Combo <- Combos] ++ [[Factor] | Combos].

multiply(Xs) ->
    lists:foldl(fun(Y, Z) -> Y * Z end, 1, Xs).

prime_factors(X) ->
    prime_factors(X, 2, []).
prime_factors(X, N, Primes) when X rem N == 0 ->
    prime_factors(trunc(X / N), 2, [N | Primes]);
prime_factors(X, N, Primes) ->
    case N < math:sqrt(X) + 1 of
        true ->
            prime_factors(X, N + 1, Primes);
        false ->
            [X | Primes]
    end.
