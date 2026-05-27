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


controld(F, _S, T) :-
    get_value(F, li, Li),
    get_value(F, lai, Lai),
    get_value(F, ls, Ls),
    get_value(F, las, Las),
    act(T, Li, Lai, Ls, Las).


% =========================
% AÇÕES DO CONTROLADOR
% =========================

act(T, _Li, _Lai, Ls, Las) :-
    T > Ls,
    call_method_0(ac, cool),
    malarm(T, _Li, _Lai, Ls, Las).

act(T, Li, Lai, Ls, Las) :-
    T < Li,
    call_method_0(ac, warm),
    malarm(T, Li, Lai, Ls, Las).

act(T, Li, _Lai, Ls, _Las) :-
    T >= Li,
    T =< Ls,
    call_method_0(ac, stop).


% =========================
% ALARMES
% =========================

malarm(T, _Li, _Lai, _Ls, Las) :-
    T > Las,
    getdate(D),
    genmsg(T, burning, D).

malarm(T, _Li, Lai, _Ls, _Las) :-
    T < Lai,
    getdate(D),
    genmsg(T, freezing, D).

malarm(_T, _Li, _Lai, _Ls, _Las).


% =========================
% DATA
% =========================

getdate(D) :-
    get_time(T),
    stamp_date_time(T, D, 'UTC').