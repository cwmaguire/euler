-module(euler19).

% You are given the following information, but you may prefer to do some research for yourself.

% 1 Jan 1900 was a Monday.

% Thirty days has September,
% April, June and November.
% All the rest have thirty-one,
% Saving February alone,
% Which has twenty-eight, rain or shine.
% And on leap years, twenty-nine.

% A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
% How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

-export([sundays/0]).
-export([sundays/2]).
-export([month_days/2]).

sundays() ->
    Day1 = 366 rem 7,
    MonthYearPairs = [{M, Y} || Y <- lists:seq(1901, 2000), M <- lists:seq(1,12)],
    MonthDays = [month_days(M, Y) || {M, Y} <- MonthYearPairs],
    {_, Sundays} = lists:foldl(fun sundays/2, {Day1, 0}, MonthDays),
    Sundays.

sundays(MonthDays, {Days, Sundays}) when Days rem 7 == 0 ->
    {MonthDays, Sundays + 1};
sundays(MonthDays, {Days, Sundays}) ->
    {Days + MonthDays, Sundays}.

month_days(2, Y) when Y rem 4 == 0, Y rem 100 /= 0 ->
    29;
month_days(2, _) ->
    28;
month_days(M, _) ->
    case lists:member(M, [4, 6, 9, 11]) of
        true ->
            30;
        _ ->
            31
    end.
