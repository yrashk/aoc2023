:- object(aoc23_1_test, extends(lgtunit)).

example(positive, sample, 142).
example(positive, sample1, 142).
example(positive, input, 54530).
example(positive, part2_sample, 281).

example(negative, sample, 14).

solver(Solver) :-
    current_object(Solver), implements_protocol(Solver, aoc23_1_solver).

test(positive) :-
  forall((solver(S), example(positive, File, Answer)), ::assertion(S::solve(File, Answer))).

test(negative) :-
  forall((solver(S), example(negative, File, Answer)), ::assertion(\+ S::solve(File, Answer))).

:- end_object.
