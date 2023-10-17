#include "delta.lp".

#show sp/2.
#show ep/2.
#show change/4.

% https://github.com/FudanSELab/train-ticket/blob/master/image/train-ticket-draws-TicketReserve.png

span(a).
span(b).
span(c).

influence(a,b,pos).
influence(a,c,pos).
sp(b, increasing).