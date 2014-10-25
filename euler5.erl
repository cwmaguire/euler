-module(euler5).

-export([lowest_multiple/0]).

lowest_multiple() ->
    lowest_multiple(20).

lowest_multiple(X) when X rem 20 == 0 andalso
                        X rem 19 == 0 andalso
                        X rem 18 == 0 andalso
                        X rem 17 == 0 andalso
                        X rem 16 == 0 andalso
                        X rem 15 == 0 andalso
                        X rem 14 == 0 andalso
                        X rem 13 == 0 andalso
                        X rem 12 == 0 andalso
                        X rem 11 == 0 ->
    X;
lowest_multiple(X) ->
    case X rem 100000 of
        0 ->
            io:format("X = ~p~n", [X]);
        _ ->
            ok
    end,
    lowest_multiple(X + 1).
