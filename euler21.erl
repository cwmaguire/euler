-module(euler21).

% Let d(n) be defined as the sum of proper divisors of n
% (numbers less than n which divide evenly into n).
% If d(a) = b and d(b) = a, where a ≠ b, then a and b
% are an amicable pair and each of a and b are called
% amicable numbers.
%
% For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110;
% therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
%
% Evaluate the sum of all the amicable numbers under 10000.

-export([sum_amicables/0]).
-export([sum_amicables/1]).
-export([amicables/2]).
-export([amicable/1]).
-export([is_amicable/3]).
-export([factor_sum/1]).

sum_amicables() ->
    sum_amicables(1000).

sum_amicables(N) ->
    {Amicables, _} = lists:foldl(fun amicables/2, {[], []}, lists:seq(2, N)),
    lists:sum(Amicables).

amicables(N, {Amicables, NotAmicables}) ->
    case not(lists:member(N, NotAmicables) orelse
             lists:member(N, Amicables)) andalso amicable(N) of
        {true, Opposite} ->
            {[N, Opposite | Amicables], NotAmicables};
        {false, Opposite} ->
            {Amicables, [N, Opposite | NotAmicables]};
        false ->
            {Amicables, NotAmicables}
    end.

amicable(N) ->
    Opposite = factor_sum(N),
    OppositeSum = factor_sum(Opposite),
    {is_amicable(N, Opposite, OppositeSum), Opposite}.

is_amicable(N, N, _) ->
    false;
is_amicable(N, _, OppositeSum) when N == OppositeSum ->
    true;
is_amicable(_, _, _) ->
    false.

factor_sum(N) ->
    lists:sum([F || F <- factors:factors(N), F /= N]).
