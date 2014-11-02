-module(euler13).

% Work out the first ten digits of the sum of the
% following one-hundred 50-digit numbers.

-export([nth_digit_sum/1]).
-export([nth_digit_sum/2]).

-include("euler13.hrl").

nth_digit_sum(Digits) ->
    nth_digit_sum(Digits, ?NUMS).

nth_digit_sum(Digits, Numbers) ->
    lists:sublist(integer_to_list(lists:sum(Numbers)), 1, Digits).
