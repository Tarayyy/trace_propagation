%span(A).
%lp(A, X) :- span(A).
%hp(A, X) :- span(A).

% A <-+- B : B causes A's change
%influence(A, B, neg) :- span(A), span(B).
%influence(A, B, pos) :- span(A), span(B).

%   | +  0  -
%   +---------
% + | +  +  ?
% 0 | +  0  -
% - | ?  -  -

result(A, X, Y) :- span(A), lp(A, X), hp(A, Y).

% Actual --------------------------------------------------------------------------------------------------------------------------------------------

n_inc(A, lp, N) :- span(A), POS_INC = #count{B: influence(A, B, pos), lp(B, increasing)}, NEG_DEC = #count{B: influence(A, B, neg), lp(B, decreasing)}, N = POS_INC + NEG_DEC.
n_inc(A, hp, N) :- span(A), POS_INC = #count{B: influence(A, B, pos), hp(B, increasing)}, NEG_DEC = #count{B: influence(A, B, neg), hp(B, decreasing)}, N = POS_INC + NEG_DEC.

n_dec(A, lp, N) :- span(A), POS_DEC = #count{B: influence(A, B, pos), lp(B, decreasing)}, NEG_INC = #count{B: influence(A, B, neg), lp(B, increasing)}, N = POS_DEC + NEG_INC.
n_dec(A, hp, N) :- span(A), POS_DEC = #count{B: influence(A, B, pos), hp(B, decreasing)}, NEG_INC = #count{B: influence(A, B, neg), hp(B, increasing)}, N = POS_DEC + NEG_INC.

% n_inc > 0 && n_dec = 0 => +
lp(A, increasing) :- n_inc(A, lp, X), X > 0, n_dec(A, lp, 0).
% n_inc = 0 && n_dec = 0 => 0
lp(A, steady) :- n_inc(A, lp, Y), Y = 0, n_dec(A, lp, Y), Y = 0, not lp(A, increasing), not lp(A, decreasing).
% n_inc = 0 && n_dec > 0 => -
lp(A, decreasing) :- n_inc(A, lp, 0), n_dec(A, lp, X), X > 0.
% n_inc > 0 && n_dec > 0 => ?
1{lp(A, increasing); lp(A, steady); lp(A, decreasing)}1 :- n_inc(A, lp, X), X > 0, n_dec(A, lp, Y), Y > 0.

% n_inc > 0 && n_dec = 0 => +
hp(A, increasing) :- n_inc(A, hp, X), X > 0, n_dec(A, hp, 0).
% n_inc = 0 && n_dec = 0 => 0
hp(A, steady) :- n_inc(A, hp, Y), Y = 0, n_dec(A, hp, Y), Y = 0, not hp(A, increasing), not hp(A, decreasing).
% n_inc = 0 && n_dec > 0 => -
hp(A, decreasing) :- n_inc(A, hp, 0), n_dec(A, hp, X), X > 0.
% n_inc > 0 && n_dec > 0 => ?
1{hp(A, increasing); hp(A, steady); hp(A, decreasing)}1 :- n_inc(A, hp, X), X > 0, n_dec(A, hp, Y), Y > 0.


% Reference -----------------------------------------------------------------------------------------------------------------------------------------

%* 
n_inc_ref(a, lp, N) :- span(a), POS_INC = #count{B: influence(a, B, pos), sp_ref(B, increasing)}, NEG_DEC = #count{B: influence(a, B, neg), sp_ref(B, decreasing)}, N = POS_INC + NEG_DEC.
n_inc_ref(a, hp, N) :- span(a), POS_INC = #count{B: influence(a, B, pos), ep_ref(B, increasing)}, NEG_DEC = #count{B: influence(a, B, neg), ep_ref(B, decreasing)}, N = POS_INC + NEG_DEC.

n_dec_ref(a, lp, N) :- span(a), POS_DEC = #count{B: influence(a, B, pos), sp_ref(B, decreasing)}, NEG_INC = #count{B: influence(a, B, neg), sp_ref(B, increasing)}, N = POS_DEC + NEG_INC.
n_dec_ref(a, hp, N) :- span(a), POS_DEC = #count{B: influence(a, B, pos), ep_ref(B, decreasing)}, NEG_INC = #count{B: influence(a, B, neg), ep_ref(B, increasing)}, N = POS_DEC + NEG_INC.

% n_inc_ref > 0 && n_dec_ref = 0 => +
sp_ref(A, increasing) :- n_inc_ref(A, lp, X), X > 0, n_dec_ref(A, lp, 0).
% n_inc_ref = 0 && n_dec_ref = 0 => 0
sp_ref(A, steady) :- n_inc_ref(A, lp, Y), Y = 0, n_dec_ref(A, lp, Y), Y = 0.
% n_inc_ref = 0 && n_dec_ref > 0 => -
sp_ref(A, decreasing) :- n_inc_ref(A, lp, 0), n_dec_ref(A, lp, X), X > 0.
% n_inc_ref > 0 && n_dec_ref > 0 => ?
1{sp_ref(A, increasing); sp_ref(A, steady); sp_ref(A, decreasing)}1 :- n_inc_ref(A, lp, X), X > 0, n_dec_ref(A, lp, Y), Y > 0.

% n_inc_ref > 0 && n_dec_ref = 0 => +
ep_ref(A, increasing) :- n_inc_ref(A, hp, X), X > 0, n_dec_ref(A, hp, 0).
% n_inc_ref = 0 && n_dec_ref = 0 => 0
ep_ref(A, steady) :- n_inc_ref(A, hp, Y), Y = 0, n_dec_ref(A, hp, Y), Y = 0.
% n_inc_ref = 0 && n_dec_ref > 0 => -
ep_ref(A, decreasing) :- n_inc_ref(A, hp, 0), n_dec_ref(A, hp, X), X > 0.
% n_inc_ref > 0 && n_dec_ref > 0 => ?
1{ep_ref(A, increasing); ep_ref(A, steady); ep_ref(A, decreasing)}1 :- n_inc_ref(A, hp, X), X > 0, n_dec_ref(A, hp, Y), Y > 0.
*%

% Change detection ----------------------------------------------------------------------------------------------------------------------------------

change(A, lp, ACT) :- lp(A, ACT), ACT != steady.
change(A, hp, ACT) :- hp(A, ACT), ACT != steady.

%change(A, lp, ACT, REF) :- lp(A, ACT), sp_ref(A, REF), ACT != REF.
%change(A, hp, ACT, REF) :- hp(A, ACT), ep_ref(A, REF), ACT != REF.

% Fault Modes ---------------------------------------------------------------------------------------------------------------------------------------

%TODO