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

n_inc(a, sp, N) :- span(a), POS_INC = #count{B: influence(a, B, pos), sp(B, plus)}, NEG_DEC = #count{B: influence(a, B, neg), sp(B, minus)}, N = POS_INC + NEG_DEC.
n_inc(a, ep, N) :- span(a), POS_INC = #count{B: influence(a, B, pos), ep(B, plus)}, NEG_DEC = #count{B: influence(a, B, neg), ep(B, minus)}, N = POS_INC + NEG_DEC.

n_dec(a, sp, N) :- span(a), POS_DEC = #count{B: influence(a, B, pos), sp(B, minus)}, NEG_INC = #count{B: influence(a, B, neg), sp(B, plus)}, N = POS_DEC + NEG_INC.
n_dec(a, ep, N) :- span(a), POS_DEC = #count{B: influence(a, B, pos), ep(B, minus)}, NEG_INC = #count{B: influence(a, B, neg), ep(B, plus)}, N = POS_DEC + NEG_INC.

% n_inc > 0 && n_dec = 0 => +
sp(A, plus) :- n_inc(A, sp, X), X > 0, n_dec(A, sp, 0).
% n_inc = 0 && n_dec = 0 => 0
sp(A, norm) :- n_inc(A, sp, Y), Y = 0, n_dec(A, sp, Y), Y = 0.
% n_inc = 0 && n_dec > 0 => -
sp(A, minus) :- n_inc(A, sp, 0), n_dec(A, sp, X), X > 0.
% n_inc > 0 && n_dec > 0 => ?
1{sp(A, plus); sp(A, norm); sp(A, minus)}1 :- n_inc(A, sp, X), X > 0, n_dec(A, sp, Y), Y > 0.

% n_inc > 0 && n_dec = 0 => +
ep(A, plus) :- n_inc(A, ep, X), X > 0, n_dec(A, ep, 0).
% n_inc = 0 && n_dec = 0 => 0
ep(A, norm) :- n_inc(A, ep, Y), Y = 0, n_dec(A, ep, Y), Y = 0.
% n_inc = 0 && n_dec > 0 => -
ep(A, minus) :- n_inc(A, ep, 0), n_dec(A, ep, X), X > 0.
% n_inc > 0 && n_dec > 0 => ?
1{ep(A, plus); ep(A, norm); ep(A, minus)}1 :- n_inc(A, ep, X), X > 0, n_dec(A, ep, Y), Y > 0.