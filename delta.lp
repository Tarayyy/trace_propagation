%span(A).
%sp(A, X) :- span(A).
%ep(A, X) :- span(A).

% A <-+- B : B causes A's change
%influence(A, B, neg) :- span(A), span(B).
%influence(A, B, pos) :- span(A), span(B).

%   | +  0  -
%   +---------
% + | +  +  ?
% 0 | +  0  -
% - | ?  -  -

% Actual --------------------------------------------------------------------------------------------------------------------------------------------

n_inc(A, sp, N) :- span(A), POS_INC = #count{B: influence(A, B, pos), sp(B, increasing)}, NEG_DEC = #count{B: influence(A, B, neg), sp(B, decreasing)}, N = POS_INC + NEG_DEC.
n_inc(A, ep, N) :- span(A), POS_INC = #count{B: influence(A, B, pos), ep(B, increasing)}, NEG_DEC = #count{B: influence(A, B, neg), ep(B, decreasing)}, N = POS_INC + NEG_DEC.

n_dec(A, sp, N) :- span(A), POS_DEC = #count{B: influence(A, B, pos), sp(B, decreasing)}, NEG_INC = #count{B: influence(A, B, neg), sp(B, increasing)}, N = POS_DEC + NEG_INC.
n_dec(A, ep, N) :- span(A), POS_DEC = #count{B: influence(A, B, pos), ep(B, decreasing)}, NEG_INC = #count{B: influence(A, B, neg), ep(B, increasing)}, N = POS_DEC + NEG_INC.

% n_inc > 0 && n_dec = 0 => +
sp(A, increasing) :- n_inc(A, sp, X), X > 0, n_dec(A, sp, 0).
% n_inc = 0 && n_dec = 0 => 0
sp(A, steady) :- n_inc(A, sp, Y), Y = 0, n_dec(A, sp, Y), Y = 0.
% n_inc = 0 && n_dec > 0 => -
sp(A, decreasing) :- n_inc(A, sp, 0), n_dec(A, sp, X), X > 0.
% n_inc > 0 && n_dec > 0 => ?
1{sp(A, increasing); sp(A, steady); sp(A, decreasing)}1 :- n_inc(A, sp, X), X > 0, n_dec(A, sp, Y), Y > 0.

% n_inc > 0 && n_dec = 0 => +
ep(A, increasing) :- n_inc(A, ep, X), X > 0, n_dec(A, ep, 0).
% n_inc = 0 && n_dec = 0 => 0
ep(A, steady) :- n_inc(A, ep, Y), Y = 0, n_dec(A, ep, Y), Y = 0.
% n_inc = 0 && n_dec > 0 => -
ep(A, decreasing) :- n_inc(A, ep, 0), n_dec(A, ep, X), X > 0.
% n_inc > 0 && n_dec > 0 => ?
1{ep(A, increasing); ep(A, steady); ep(A, decreasing)}1 :- n_inc(A, ep, X), X > 0, n_dec(A, ep, Y), Y > 0.

% Reference -----------------------------------------------------------------------------------------------------------------------------------------

n_inc_ref(a, sp, N) :- span(a), POS_INC = #count{B: influence(a, B, pos), sp_ref(B, increasing)}, NEG_DEC = #count{B: influence(a, B, neg), sp_ref(B, decreasing)}, N = POS_INC + NEG_DEC.
n_inc_ref(a, ep, N) :- span(a), POS_INC = #count{B: influence(a, B, pos), ep_ref(B, increasing)}, NEG_DEC = #count{B: influence(a, B, neg), ep_ref(B, decreasing)}, N = POS_INC + NEG_DEC.

n_dec_ref(a, sp, N) :- span(a), POS_DEC = #count{B: influence(a, B, pos), sp_ref(B, decreasing)}, NEG_INC = #count{B: influence(a, B, neg), sp_ref(B, increasing)}, N = POS_DEC + NEG_INC.
n_dec_ref(a, ep, N) :- span(a), POS_DEC = #count{B: influence(a, B, pos), ep_ref(B, decreasing)}, NEG_INC = #count{B: influence(a, B, neg), ep_ref(B, increasing)}, N = POS_DEC + NEG_INC.

% n_inc_ref > 0 && n_dec_ref = 0 => +
sp_ref(A, increasing) :- n_inc_ref(A, sp, X), X > 0, n_dec_ref(A, sp, 0).
% n_inc_ref = 0 && n_dec_ref = 0 => 0
sp_ref(A, steady) :- n_inc_ref(A, sp, Y), Y = 0, n_dec_ref(A, sp, Y), Y = 0.
% n_inc_ref = 0 && n_dec_ref > 0 => -
sp_ref(A, decreasing) :- n_inc_ref(A, sp, 0), n_dec_ref(A, sp, X), X > 0.
% n_inc_ref > 0 && n_dec_ref > 0 => ?
1{sp_ref(A, increasing); sp_ref(A, steady); sp_ref(A, decreasing)}1 :- n_inc_ref(A, sp, X), X > 0, n_dec_ref(A, sp, Y), Y > 0.

% n_inc_ref > 0 && n_dec_ref = 0 => +
ep_ref(A, increasing) :- n_inc_ref(A, ep, X), X > 0, n_dec_ref(A, ep, 0).
% n_inc_ref = 0 && n_dec_ref = 0 => 0
ep_ref(A, steady) :- n_inc_ref(A, ep, Y), Y = 0, n_dec_ref(A, ep, Y), Y = 0.
% n_inc_ref = 0 && n_dec_ref > 0 => -
ep_ref(A, decreasing) :- n_inc_ref(A, ep, 0), n_dec_ref(A, ep, X), X > 0.
% n_inc_ref > 0 && n_dec_ref > 0 => ?
1{ep_ref(A, increasing); ep_ref(A, steady); ep_ref(A, decreasing)}1 :- n_inc_ref(A, ep, X), X > 0, n_dec_ref(A, ep, Y), Y > 0.

% Change detection ----------------------------------------------------------------------------------------------------------------------------------

change(A, sp, ACT, REF) :- sp(A, ACT), sp_ref(A, REF), ACT != REF.
change(A, ep, ACT, REF) :- ep(A, ACT), ep_ref(A, REF), ACT != REF.

% Fault Modes ---------------------------------------------------------------------------------------------------------------------------------------

%TODO