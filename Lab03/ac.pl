:- ['golog2_2026.pl'].


model_ac :-
    def_ac,
    def_thermo,
    def_alarm.

% =========================
% AIR CONDITIONING
% =========================

def_ac :-
    new_frame(ac),
    new_slot(ac, status, inactive),
    new_slot(ac, temp),
    new_slot(ac, stop, stopf),
    new_slot(ac, warm, warmf),
    new_slot(ac, cool, coolf),
    def_readtd.


% -------------------------
% Métodos do AC
% -------------------------

stopf(F) :-
    new_value(F, status, inactive), write('AC stopped'), nl.

warmf(F) :-
    new_value(F, status, warming), write('AC is heating'), nl.


coolf(F) :-
    new_value(F, status, cooling), write('AC is cooling'), nl.


% -------------------------
% Demon para ler temperatura
% -------------------------

def_readtd :-
    new_demon(ac, temp, readtd, if_read, after, alter_value).

readtd(_F, _S, _, T) :-
    get_value(thermo, temp, T).


% =========================
% THERMOSTAT
% =========================

def_thermo :-  
    new_frame(thermo),
    new_slot(thermo, temp, 0),
    new_slot(thermo, li, 14),
    new_slot(thermo, lai, 0),
    new_slot(thermo, ls, 25),
    new_slot(thermo, las, 35),
    new_slot(thermo, clima),
    def_climad,
    def_controld.


% =========================
% DEMON CLIMA
% =========================

def_climad :-
    new_demon(thermo, clima, climad, if_read, after, alter_value).


climad(F, _S, _OldValue, C) :-
    get_value(F, temp, T),
    get_value(F, li, Li),
    get_value(F, lai, Lai),
    get_value(F, ls, Ls),
    get_value(F, las, Las),
    classify(T, Lai, Li, Ls, Las, C).


% =========================
% CLASSIFICAÇÃO DO CLIMA
% =========================

classify(T, _Lai, Li, Ls, _Las, comfort) :-
    T >= Li,
    T < Ls.

classify(T, Lai, _Li, _Ls, _Las, freezing) :-
    T < Lai.

classify(T, _Lai, _Li, _Ls, Las, burning) :-
    T > Las.

classify(T, Lai, Li, _Ls, _Las, cold) :-
    T >= Lai,
    T < Li.

classify(T, _Lai, _Li, Ls, Las, hot) :-
    T >= Ls,
    T =< Las.


% =========================
% DEMON CONTROL
% =========================

def_controld :-
    new_demon(thermo, temp, controld, if_write, before, side_effect).


controld(F, _S, T, T) :-
    get_value(F,temp,Ta)
    get_value(F, li, Li),
    get_value(F, lai, Lai),
    get_value(F, ls, Ls),
    get_value(F, las, Las),
    act(T, Ta, Li, Lai, Ls, Las).


% =========================
% AÇÕES DO CONTROLADOR
% =========================

act(T, Ta, Li, Lai, Ls, Las) :-
    T > Ls,
    call_method_0(ac, cool),
    malarm(T, Ta, Li, Lai, Ls, Las).

act(T, Ta, Li, Lai, Ls, Las) :-
    T < Li,
    call_method_0(ac, warm),
    malarm(T, Ta, Li, Lai, Ls, Las).

act(_T, _Ta, _Li, _Lai, _Ls, _Las) :-
    call_method_0(ac, stop).


% =========================
% ALARMES
% =========================

malarm(T, Ta, _Li, _Lai, _Ls, Las) :-
    T > Las, Ta<Las,
    getdate(D),
    genmsg(T, burning, D).

malarm(T, Ta, _Li, Lai, _Ls, _Las) :-
    T < Lai, Ta > Lai,
    getdate(D),
    genmsg(T, freezing, D).

malarm(_T, ,_Ta, _Li, _Lai, _Ls, _Las).

genmsg(T, E, D) :-
    genname(N),
    new_frame(N),
    new_slot(N, is_a, alarm),
    new_value(N, event, E),
    new_value(N, temp, T),
    new_value(N, date, D).

genname(N) :-
    get_value(alarm, count, A),
    A1 is A + 1,
    new_value(alarm, count, A1),
    atom_concat(alarm, A1, N), 
    write('New alarm: '), write(N), nl.


% =========================
% DATA
% =========================

getdate(D) :-
    get_time(T),
    stamp_date_time(T, D, 'UTC').

% =========================
% DEFINICAO ALARME
% =========================

def_alarm :-
    new_frame(alarm),
    new_slot(alarm, event),
    new_slot(alarm, temp),
    new_slot(alarm, date),
    new_slot(alarm, count, 0),
    def_isa.

def_isa :-
    new_relation(is_a, transitive, all, nil).