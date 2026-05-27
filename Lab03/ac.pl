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
    new_value(F, status, inactive).

warmf(F) :-
    new_value(F, status, warming).

coolf(F) :-
    new_value(F, status, cooling).


% -------------------------
% Demon para ler temperatura
% -------------------------

def_readtd :-
    new_demon(ac, temp, readtd, if_read, after, alter_value).

readtd(F, S, _, T) :-
    get_value(thermo, temp, T).