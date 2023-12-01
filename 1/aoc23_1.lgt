:- object(aoc23_1).

:- info([
      author is 'Yurii Rashkovskii',
      date is 2023-12-1,
      comment is 'Calibration (#1)'
      ]).

:- use_module(library(pure_input), [phrase_from_file/2]).
:- meta_predicate(phrase_from_file(2, *)).

:- public(solve/2).

solve(File, Solution) :-
    phrase_from_file(parse(Solution), File).

parse(Solution) --> parse(Solution0, 0, [_, _]), !, { Solution is Solution0 }.

% First digit
parse(Solution, Acc, [First, _]) -->
    % First digit hasn't been pick yet
    { var(First) },
    % Match if it is a digit
    [Digit], { char_type(Digit, digit(First)) },
    % First one is the first and the last one until another one is found
    parse(Solution, Acc, [First, First]).
% Last digit
parse(Solution, Acc, [First, _]) -->
    % First digit has already been picked
    { nonvar(First) },
    % Match if it is a digit
    [Digit], { char_type(Digit, digit(Last)) },
    parse(Solution, Acc, [First, Last]).
% new line or end of stream
parse(Solution, Acc, Digits) -->
    % First and last have been picked
    { ground(Digits) },
    % New line
    [C], { char_type(C, end_of_line) },
    % Accumulate
    { increment(Acc, NewAcc, Digits) },
    parse(Solution, NewAcc, [_, _]).
% Skip other characters
parse(Solution, Acc, Digits) -->
    [_], 
    parse(Solution, Acc, Digits).
% End of stream with pending digits
parse(Solution, Acc, Digits) --> 
    % There are digits,
    { ground(Digits) },
    { increment(Acc, NewAcc, Digits) },
    parse(Solution, NewAcc, [_, _]).
% End of stream
parse(Solution, Solution, Digits) -->
    { \+ ground(Digits) },
    [].


increment(Acc, NewAcc, [First, Last]) :-
    NewAcc is Acc + First * 10 + Last.

:- end_object.