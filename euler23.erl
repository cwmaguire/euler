-module(euler23).

% A perfect number is a number for which the sum of its proper divisors is exactly
% equal to the number. For example, the sum of the proper divisors of 28 would
% be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

% A number n is called deficient if the sum of its proper divisors is less
% than n and it is called abundant if this sum exceeds n.

% As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
% number that can be written as the sum of two abundant numbers is 24. By
% mathematical analysis, it can be shown that all integers greater than 28123
% can be written as the sum of two abundant numbers. However, this upper limit
% cannot be reduced any further by analysis even though it is known that the
% greatest number that cannot be expressed as the sum of two abundant numbers
% is less than this limit.

% Find the sum of all the positive integers which cannot be written as the
% sum of two abundant numbers.

% - find all abundant numbers under 28123
% - test 1..28123 if they are sums of one or more pairs of abundant numbers
%   (the smallest abundant is 12, so we can stop at 28123 - 12)

-export([sum_abundant_sums/0]).
-export([sum_abundant_sums/1]).
-export([is_abundant/1]).
-export([is_sum_of_abundants/2]).
-export([is_sum_of_abundants/3]).

sum_abundant_sums() ->
    sum_abundant_sums(28124).

sum_abundant_sums(N) ->
    Numbers = lists:seq(1, N),
    Abundants = [Num || Num <- Numbers, is_abundant(Num)],
    AbundantSums = [A + B || A <- Abundants, B <- Abundants, A + B =< N],
    UniqueAbundantSums = lists:usort(fun(A, B) -> A =< B end, AbundantSums),
    NonAbundantSums = gb_sets:to_list(gb_sets:subtract(gb_sets:from_list(Numbers),
                                                       gb_sets:from_list(UniqueAbundantSums))),
    lists:sum(NonAbundantSums).

is_abundant(N) ->
    N < lists:sum([F || F <- factors:factors(N), F /= N]).

is_sum_of_abundants(N, {Abundants, Sum}) ->
    case is_sum_of_abundants(N, Abundants, Abundants) of
        true ->
            {Abundants, Sum + N};
        false ->
            {Abundants, Sum}
    end.

is_sum_of_abundants(_, _, []) ->
    false;
is_sum_of_abundants(N, Abundants, [Abundant | AbundantsToCheck]) ->
    case lists:member(N - Abundant, Abundants) of
        true ->
            true;
        false ->
            is_sum_of_abundants(N, Abundants, AbundantsToCheck)
    end.
