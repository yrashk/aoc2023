:- object(aoc23_1_test, extends(lgtunit)).

example(positive, sample, 142).
example(positive, sample1, 142).
example(positive, input, 54530).
example(positive, part2_sample, 281).

example(negative, sample, 14).

test(positive) :-
  forall(example(positive, File, Answer), ::assertion(aoc23_1::solve(File, Answer))).

test(negative) :-
  forall(example(negative, File, Answer), ::assertion(\+ aoc23_1::solve(File, Answer))).


:- end_object.
