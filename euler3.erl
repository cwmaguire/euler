%Largest prime factor
%Problem 3
%The prime factors of 13195 are 5, 7, 13 and 29.

%What is the largest prime factor of the number 600851475143 ?

-module(euler3).

-export([largest_prime_factor/1]).
-export([largest_prime_factor/4]).
-export([next_prime/1]).
-export([next_prime/2]).
-export([is_prime/1]).
-export([is_prime/2]).
% 600...3 is odd, so 2 can't be a prime factor.
% This leaves us with 3 x (600..3) / 3 or X > 3 * Y < (600..3) / X
%
% If I keep doing this, figuring out the first prime factor that works,
% then I can take the quotient and start over.

% In order for X to have a larger prime factor than it's factor y, X / Y
% must be greater than Y. i.e. 8 / 2 = 4; 4 > 2, so we know that we _might_
% have a larger prime factor than 2 in 4.

% If I continually peel off the smallest prime factor, then the last factor
% will necessarily be the largest.

% A prime factor can never be more than 1/2 of a number. Otherwise there's
% nothing to multiply it by. The worst case is a prime squared (i.e. a prime
% square root); e.g. 113^2 because ... once since we're looking for
% factors in ascending order we must _always_ have a larger or equal
% factor "on the other side". e.g. if we tried 8 as a factor of 49 then
% we know it would have to be 8 x <something less than 8>, since 8^2 is 64.
% So if the other factor is < 8 then we should have already found it.
% Therefore, if the factor we're working on, squared, is greater than the target
% number then we've already found the largest prime factor.

% If the square of the largest factor is larger than the number then we're done
% Get a prime number.
% If it divides into our number evenly then
%   start over with the quotient, tracking the largest prime factor
% else
%   Start over with the next prime number

is_prime(X) when X rem 2 == 0 ->
    false;
is_prime(X) ->
    is_prime(X, 3).

is_prime(X, Y) when 2 * Y > X ->
    true;
is_prime(X, Y) when X rem Y == 0 ->
    false;
is_prime(X, Y) ->
    is_prime(X, Y + 2).

next_prime(X) ->
    case is_prime(X + 1) of
        true -> X + 1;
        false -> next_prime(X + 1)
    end.

next_prime(X, Primes) ->
    case [P || P <- Primes, P > X] of
        [Next | _] -> {Next, Primes};
        [] ->
            NextPrime = next_prime(X),
            {NextPrime, Primes ++ [NextPrime]}
    end.

largest_prime_factor(X) ->
    largest_prime_factor(X, 0, 0, [2]).

largest_prime_factor(Rem, LargestFactor, Factor, Primes) when Factor * 2 > Rem ->
    io:format("Done: ~p, ~p, ~p, ~p~n",
              [Rem, LargestFactor, Factor, length(Primes)]),
    LargestFactor;
largest_prime_factor(Rem, LargestFactor, Factor, Primes) when Rem rem Factor == 0 ->
    io:format("Found factor: ~p, ~p, ~p, ~p~n",
              [Rem, LargestFactor, Factor, length(Primes)]),
    Rem2 = trunc(Rem / Factor),
    Factor2 = case is_prime(Rem2) andalso Rem2 > Factor of
                  true -> Rem2;
                  false -> Factor
              end,
    case Factor2 > LargestFactor of
        true -> largest_prime_factor(Rem2, Factor2, 2, Primes);
        false -> largest_prime_factor(Rem2, LargestFactor, 2, Primes)
    end;
largest_prime_factor(Rem, LargestFactor, Factor, Primes) ->
    io:format("Factor not found: ~p, ~p, ~p, ~p~n",
              [Rem, LargestFactor, Factor, length(Primes)]),
    {NextPrime, NewPrimes} = next_prime(Factor, Primes),
    largest_prime_factor(Rem, LargestFactor, NextPrime, NewPrimes).

