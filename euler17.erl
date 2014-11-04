-module(euler17).

%If the numbers 1 to 5 are written out in words: one, two, three, four, five, then
%there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

%If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words,
%how many letters would be used?

%NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two)
%contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use
%of "and" when writing out numbers is in compliance with British usage.

-export([num_letters/1]).
-export([letters/1]).

num_letters(N) ->
    length(lists:flatten([letters(X) || X <- lists:seq(1, N)])).

letters(0) -> "";
letters(1) -> "one";
letters(2) -> "two";
letters(3) -> "three";
letters(4) -> "four";
letters(5) -> "five";
letters(6) -> "six";
letters(7) -> "seven";
letters(8) -> "eight";
letters(9) -> "nine";
letters(10) -> "ten";
letters(11) -> "eleven";
letters(12) -> "twelve";
letters(13) -> "thirteen";
letters(14) -> "fourteen";
letters(15) -> "fifteen";
letters(16) -> "sixteen";
letters(17) -> "seventeen";
letters(18) -> "eighteen";
letters(19) -> "nineteen";
letters(20) -> "twenty";
letters(30) -> "thirty";
letters(40) -> "forty";
letters(50) -> "fifty";
letters(60) -> "sixty";
letters(70) -> "seventy";
letters(80) -> "eighty";
letters(90) -> "ninety";
letters(Number) when Number < 100, Number > 19 ->
    Ones = Number rem 10,
    Tens = Number - Ones,
    letters(Tens) ++ letters(Ones);
letters(Number) when Number >= 100, Number < 1000 ->
    Rem = Number rem 100,
    Hundreds = trunc((Number - Rem) / 100),
    case Rem of
        0 -> letters(Hundreds) ++ "hundred";
        _ -> letters(Hundreds) ++ "hundredand" ++ letters(Rem)
    end;
letters(1000) ->
    "onethousand".
