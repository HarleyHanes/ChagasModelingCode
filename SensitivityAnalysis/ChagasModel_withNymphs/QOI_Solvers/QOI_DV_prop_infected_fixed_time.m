function [I] = QOI_DV_prop_infected_fixed_time(soln,tinf)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
I=soln.y(tinf*365,8)/(soln.y(tinf*365,8)+soln.y(tinf*365,7));
end

