#include "delta.lp".

#show sp/2.
#show ep/2.
#show change/4.

% (a) <--(+)--(c)
%  <\
%    \
%     (+)
%      \
%       (b)

span(a).
span(b).
span(c).

influence(a,b,pos).
influence(a,c,pos).
sp(b, increasing).