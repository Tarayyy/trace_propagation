#include "delta.lp".

#show lp/2.
#show hp/2.
#show change/4.

% https://github.com/FudanSELab/train-ticket/blob/master/image/train-ticket-draws-TicketReserve.png

%span(SPAN), span(SERVICE), influence(SPAN, SERVICE, pos) :- span_and_service(SPAN, SERVICE).

span(dashboard).
    span(reserveTicket).
        span(getAccountInformation).
        span(checkTicketScalper).
        span(getContactsInformation).
        span(getTripDetailInformation).
        span(queryStationId).
        span(createTicketInformation).
        span(dispatchSeat).
        span(createTicketOrder).
        span(createAssuranceOrder).
        span(createFoodOrder).
        span(createConsignsOrder).
        span(sendEmailNotification).

influence(dashboard, reserveTicket, pos).
    influence(reserveTicket, getAccountInformation, pos).
    influence(reserveTicket, checkTicketScalper, pos).
    influence(reserveTicket, getContactsInformation, pos).
    influence(reserveTicket, getTripDetailInformation, pos).
    influence(reserveTicket, queryStationId, pos).
    influence(reserveTicket, createTicketInformation, pos).
    influence(reserveTicket, dispatchSeat, pos).
    influence(reserveTicket, createTicketOrder, pos).
    influence(reserveTicket, createAssuranceOrder, pos).
    influence(reserveTicket, createFoodOrder, pos).
    influence(reserveTicket, createConsignsOrder, pos).
    influence(reserveTicket, sendEmailNotification, pos).