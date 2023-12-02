:- set_prolog_flag(double_quotes, chars).


:- object(solution).

	:- info([
		author is 'Paulo Moura',
		date is 2023-12-02,
		comment is 'Calibration (#1)'
	]).

	:- public(solution/2).

	solution(File, Solution) :-
		open(File, read, Stream),
		reader::line_to_chars(Stream, Line),
		solution(Line, Stream, 0, Solution),
		close(Stream).

	solution(end_of_file, _, Solution, Solution).
	solution([Char| Chars], Stream, Solution0, Solution) :-
		once(phrase(calibration(Calibration), [Char| Chars])),
		Solution1 is Solution0 + Calibration,
		reader::line_to_chars(Stream, Line),
		solution(Line, Stream, Solution1, Solution).

	calibration(Calibration) -->
		first_digit(First),
		rest_digits(Digits),
		{
			last(Digits, First, Second),
			Calibration is First*10 + Second
		}.

	first_digit(Digit) -->
		digit(Digit).
	first_digit(Digit) -->
		[_], first_digit(Digit).

	rest_digits([Digit| Digits]) -->
		digit(Digit),
		rest_digits(Digits).
	rest_digits(Digits) -->
		[_],
		rest_digits(Digits).
	rest_digits([]) -->
		[].

	% as numbers
	digit(1) --> "1".
	digit(2) --> "2".
	digit(3) --> "3".
	digit(4) --> "4".
	digit(5) --> "5".
	digit(6) --> "6".
	digit(7) --> "7".
	digit(8) --> "8".
	digit(9) --> "9".
	% as letters (take into account possible overlaps)
	digit(1), [e] --> "one".
	digit(2), [o] --> "two".
	digit(3), [e] --> "three".
	digit(4) --> "four".
	digit(5), [e] --> "five".
	digit(6) --> "six".
	digit(7), [n] --> "seven".
	digit(8), [t] --> "eight".
	digit(9), [e] --> "nine".

	last([], Last, Last).
	last([Head| Tail], _, Last) :-
		last(Tail, Head, Last).

:- end_object.
