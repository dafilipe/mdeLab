:- dynamic frame_/1.

frame_(thermo).
frame_(ac).

:- dynamic thermo/1.

thermo(frame_).

:- dynamic thermo/3.

thermo(slot_, temp, data_or_method).
thermo(value_, temp, 0).
thermo(slot_, li, data_or_method).
thermo(value_, li, 14).
thermo(slot_, lai, data_or_method).
thermo(value_, lai, 0).
thermo(slot_, ls, data_or_method).
thermo(value_, ls, 25).
thermo(slot_, las, data_or_method).
thermo(value_, las, 35).
thermo(slot_, clima, data_or_method).

:- dynamic ac/1.

ac(frame_).

:- dynamic ac/3.

ac(slot_, status, data_or_method).
ac(value_, status, inactive).
ac(slot_, temp, data_or_method).
ac(slot_, stop, data_or_method).
ac(value_, stop, stopf).
ac(slot_, warm, data_or_method).
ac(value_, warm, warmf).
ac(slot_, cool, data_or_method).
ac(value_, cool, coolf).

:- dynamic slot_/2.

slot_(thermo, temp).
slot_(thermo, li).
slot_(thermo, lai).
slot_(thermo, ls).
slot_(thermo, las).
slot_(thermo, clima).
slot_(ac, status).
slot_(ac, temp).
slot_(ac, stop).
slot_(ac, warm).
slot_(ac, cool).

:- dynamic demon_/2.

demon_(thermo, clima).
demon_(thermo, temp).
demon_(ac, temp).

:- dynamic clima/6.

clima(demon_, thermo, climad, if_read, after, alter_value).

:- dynamic temp/6.

temp(demon_, thermo, controld, if_write, before, side_effect).
temp(demon_, ac, readtd, if_read, after, alter_value).

