#include "delta.lp".

%#show lp/2.
%#show hp/2.
#show change/4.
#show result/3.
#show fault/2.

% https://github.com/FudanSELab/train-ticket/blob/master/image/train-ticket-draws-TicketReserve-Query%20Ticket%20Infomation.png

span(dashboard).
    span(getContactsInformation).
    span(getAssuranceInformation).
    span(getFoodList).
        span(getTrainFoodList).
        span(getStations).
        span(getFoodStores).

influence(dashboard,getContactsInformation,pos).
influence(dashboard,getAssuranceInformation,pos).
influence(dashboard,getFoodList,pos).
    influence(getFoodList,getTrainFoodList,pos).
    influence(getFoodList,getStations,pos).
    influence(getFoodList,getFoodStores,pos).


% service

span(foodMapSERVICE). %not actual span, just part of the graph and propagation
influence(getTrainFoodList,foodMapSERVICE,pos).
influence(getFoodStores,foodMapSERVICE,pos).

% fault

%fault(foodMapSERVICE, outage).
lp(foodMapSERVICE, decreasing) :- fault(foodMapSERVICE, outage).
hp(foodMapSERVICE, decreasing) :- fault(foodMapSERVICE, outage).

%fault(foodMapSERVICE, highload).
lp(foodMapSERVICE, increasing) :- fault(foodMapSERVICE, highload).
hp(foodMapSERVICE, increasing) :- fault(foodMapSERVICE, highload).
%Example
%   fault(foodMapSERVICE,highload)
% 	result(getContactsInformation,steady,steady) 
% 	result(getAssuranceInformation,steady,steady)  

% 		result(getStations,steady,steady)
% 			result(foodMapSERVICE,increasing,increasing)
% 		result(getFoodStores,increasing,increasing) 
% 		result(getTrainFoodList,increasing,increasing)
% 	result(getFoodList,increasing,increasing)

% result(dashboard,increasing,increasing)


%fault(foodMapSERVICE, ratelimit).
lp(foodMapSERVICE, decreasing) :- fault(foodMapSERVICE, ratelimit).
ep(foodMapSERVICE, increasing) :- fault(foodMapSERVICE, ratelimit).

%lp(getAssuranceInformation, increasing).
%Example
%Answer: 1
%fault(foodMapSERVICE,ratelimit) result(foodMapSERVICE,decreasing,increasing) result(getFoodStores,decreasing,increasing) result(getTrainFoodList,decreasing,increasing) result(getFoodList,decreasing,increasing) result(getContactsInformation,steady,steady) result(getAssuranceInformation,increasing,steady) result(getStations,steady,steady) result(dashboard,steady,increasing)
%Answer: 2
%fault(foodMapSERVICE,ratelimit) result(foodMapSERVICE,decreasing,increasing) result(getFoodStores,decreasing,increasing) result(getTrainFoodList,decreasing,increasing) result(getFoodList,decreasing,increasing) result(getContactsInformation,steady,steady) result(getAssuranceInformation,increasing,steady) result(getStations,steady,steady) result(dashboard,decreasing,increasing)
%Answer: 3
%fault(foodMapSERVICE,ratelimit) result(foodMapSERVICE,decreasing,increasing) result(getFoodStores,decreasing,increasing) result(getTrainFoodList,decreasing,increasing) result(getFoodList,decreasing,increasing) result(getContactsInformation,steady,steady) result(getAssuranceInformation,increasing,steady) result(getStations,steady,steady) result(dashboard,increasing,increasing)