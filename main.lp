#include "delta.lp".

#show lp/2.
#show hp/2.
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
lp(b, increasing).
hp(b, increasing).