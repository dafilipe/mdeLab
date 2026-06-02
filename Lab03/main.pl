% main.pl

:- consult('golog2_2026.pl').
:- consult('wh.pl').
:- consult('menu.pl').

main :-
    model_wh,
    start_menu.