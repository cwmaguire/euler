-module(euler16).

-export([easy/1]).
-export([hard/1]).
-export([pow/2]).
-export([pow/3]).
-export([mult/2]).

-define(PLACE_LIMIT, 100000).

easy(N) ->
    lists:sum([list_to_integer([X]) || X <- integer_to_list(trunc(math:pow(2, N)))]).

hard(N) ->
    Places = pow(2, N),
    StringPlaces = [integer_to_list(X) || X <- Places],
    StringNumber = lists:flatten(StringPlaces),
    lists:sum([list_to_integer([X]) || X <- StringNumber]).

pow(X, Y) ->
    pow(X, Y - 1, [X]).

pow(_X, 0, Places) ->
    lists:reverse(Places);
pow(X, Y, Places) ->
    {_, Places2, Rem} = lists:foldl(fun mult/2, {X, [], 0}, Places),
    Places3 = case Rem of
                  0 ->
                      Places2;
                  N ->
                      [N | Places2]
              end,
    pow(X, Y - 1, lists:reverse(Places3)).

mult(Place, {X, Places, Add}) ->
    {Place2, Rem} = sum_rem(Place * X + Add, ?PLACE_LIMIT),
    {X, [Place2 | Places], Rem}.

sum_rem(Sum, Limit) when Sum > Limit ->
    {Sum rem Limit, trunc((Sum - (Sum rem Limit)) / Limit)};
sum_rem(Sum, _) ->
    {Sum, 0}.
