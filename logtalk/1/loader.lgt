:- use_module(dcgs).
:- initialization(
   (
       logtalk_load([solver, aoc23_1]),
       logtalk_load(reader(loader)),
       set_prolog_flag(double_quotes, chars),
       logtalk_load(aoc23_1_pmoura)
   )).
