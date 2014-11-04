-module(euler15).

-export([paths/0]).
-export([paths/2]).

paths() ->
    ets:new(paths, [public, named_table]),
    Sum = paths(20, 20),
    ets:delete(paths),
    Sum.

paths(X, Y) when X > Y ->
    paths(Y, X);
paths(1, Y) ->
    Sum = Y + 1,
    Sum;
paths(X, X) ->
    Sum = 2 * paths(X - 1, X),
    Sum;
paths(X, Y) ->
    case stored_result(X, Y) of
        [{{_, _}, Sum} | _ ] ->
            Sum;
        _ ->
            Sum = paths(X - 1, Y) + paths(X, Y - 1),
            ets:insert(paths, {{X, Y}, Sum}),
            Sum
    end.

stored_result(X, Y) ->
    ets:lookup(paths, {X, Y}).
