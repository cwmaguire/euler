-module(euler7).

-export([nth_prime/1]).

is_prime(1) ->
    false;
is_prime(2) ->
    true;
is_prime(X) when X rem 2 == 0 ->
    false;
is_prime(X) ->
    is_prime(X, 3).

is_prime(X, Y) when 2 * Y > X ->
    true;
is_prime(X, Y) when X rem Y == 0 ->
    false;
is_prime(X, Y) ->
    is_prime(X, Y + 2).

next_prime(X) ->
    case is_prime(X + 1) of
        true -> X + 1;
        false -> next_prime(X + 1)
    end.

nth_prime(X) ->
    nth_prime(X, 0).

nth_prime(0, NthPrime) ->
    NthPrime;
nth_prime(X, Prime) ->
    nth_prime(X - 1, next_prime(Prime)).
