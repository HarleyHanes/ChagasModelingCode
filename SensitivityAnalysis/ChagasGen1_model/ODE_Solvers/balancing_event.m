function [value,isterminal,direction] = balancing_event(t, Y, init)
%CHIK_BALANCING_EVENT event halting at when reaching initial infected
% infected at desired level
if abs(sum(Y(2:2:8)) - sum(init(2:2:8))) < 0.01
    value = 0;
else
    value = sum(Y(2:2:8)) - sum(init(2:2:8)); % dI/dt = 0
end
isterminal = 1; % stops graph when event is triggered
direction = 1; 
end