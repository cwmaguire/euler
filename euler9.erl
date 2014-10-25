-module(euler9).

-export([pyth_prod/0]).

pyth_prod() ->
    Seq = lists:seq(1, 1000),
    hd([X * Y * Z || X <- Seq,
                     Y <- Seq,
                     Z <- Seq,
                     X + Y + Z == 1000,
                     is_pyth_triplet(X, Y, Z)]).

is_pyth_triplet(X, Y, Z) ->
    math:pow(X, 2) + math:pow(Y, 2) == math:pow(Z, 2).
