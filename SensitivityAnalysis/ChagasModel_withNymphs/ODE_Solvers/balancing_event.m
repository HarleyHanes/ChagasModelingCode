function [value,isterminal,direction] = balancing_event(t, Y, init)
%Chagas_BALANCING_EVENT event halting at when reaching initial infected
% infected at desired level
%Not entirely sure what's going on here but it seems to be working
if abs(sum(Y(2:2:length(Y))) - sum(init(2:2:length(init)))) < 0.01
    value = 0;
else
    value = sum(Y(2:2:length(Y))) - sum(init(2:2:length(Y))); % dI/dt = 0
end
isterminal = 1; % stops graph when event is triggered
direction = 1; 
end