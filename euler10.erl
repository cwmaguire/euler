-module(euler10).

-export([sum_primes/1]).

primes_under(X, Prime, Sum) when Prime < X ->
    %io:format("Prime is ~p, Sum is ~p~n", [Prime, Sum]),
    primes_under(X, primes:next_prime(Prime), Prime + Sum);

primes_under(_, _, Sum) ->
    Sum.

sum_primes(Limit) ->
    primes_under(Limit, 2, 0).
