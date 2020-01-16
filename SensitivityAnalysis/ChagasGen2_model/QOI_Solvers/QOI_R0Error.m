function [Err] = QOI_R0Error(params,trueR0)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
R0=QOI_R0(params,'numeric');
Err=R0-trueR0;
end

