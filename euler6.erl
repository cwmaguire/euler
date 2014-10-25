-module(euler6).

-export([diff_sum_squares/1]).

diff_sum_squares(Limit) ->
    Nums = lists:seq(1, Limit),
    SumFun = fun(X, Y) -> X + Y end,
    SumSquares = lists:foldl(SumFun, 0, [math:pow(X,2) || X <- Nums]),
    SquaredSum = math:pow(lists:foldl(SumFun, 0, Nums), 2),
    SquaredSum - SumSquares.
