-module(euler20).

%n! means n × (n − 1) × ... × 3 × 2 × 1

%For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
%and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

%Find the sum of the digits in the number 100!

-export([easy/1]).
-export([fact_easy/1]).
-export([hard/1]).
-export([fact/1]).
-export([mult/2]).
-export([sum_rem/2]).

-define(PLACE_LIMIT, 100000).

easy(N) ->
    lists:sum([list_to_integer([X]) || X <- integer_to_list(fact_easy(N))]).

fact_easy(N) ->
    lists:foldl(fun(X, Acc) -> X * Acc end, 1, lists:seq(1, N)).

hard(N) ->
    Places = fact(N),
    StringPlaces = [integer_to_list(X) || X <- Places],
    StringNumber = lists:flatten(StringPlaces),
    lists:sum([list_to_integer([X]) || X <- StringNumber]).

fact(X) ->
    fact(X - 1, [X]).

fact(0, Places) ->
    lists:reverse(Places);
fact(X, Places) ->
    {_, Places2, Rem} = lists:foldl(fun mult/2, {X, [], 0}, Places),
    Places3 = case Rem of
                  0 ->
                      Places2;
                  N ->
                      [N | Places2]
              end,
    fact(X - 1, lists:reverse(Places3)).

mult(Place, {X, Places, Add}) ->
    {Place2, Rem} = sum_rem(Place * X + Add, ?PLACE_LIMIT),
    {X, [Place2 | Places], Rem}.

sum_rem(Sum, Limit) when Sum > Limit ->
    {Sum rem Limit, trunc((Sum - (Sum rem Limit)) / Limit)};
sum_rem(Sum, _) ->
    {Sum, 0}.
