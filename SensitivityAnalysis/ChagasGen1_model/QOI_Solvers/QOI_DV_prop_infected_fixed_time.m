function [I] = QOI_DV_prop_infected_fixed_time(soln,tinf)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
I=soln.y(8,tinf*365)/(soln.y(8,tinf*365)+soln.y(7,tinf*365));
end

