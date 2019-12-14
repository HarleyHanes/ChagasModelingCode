function [outputArg1,outputArg2] = FitGen1(POIs)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
select.POI={};%Cell of all parameters that our model fits
select.QOI={"Proportion I_{DV} at t=1",'Proportion I_{DV} at equilibirium'}
[QOI,soln]=BBB_Chagas_Gen1(POIs,select,params)
end

