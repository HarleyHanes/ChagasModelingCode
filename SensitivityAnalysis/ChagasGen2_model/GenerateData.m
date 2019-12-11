function [Data] = GenerateData(numSamples)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
POIs=0;%;[.0001,.00001]; 
select.QOI={'Proportion I_{DV} at equilibirium','R_0'};%,'Derived Params'};
select.POI={"null"};%{"\gamma_{SV}", "\gamma_{DV}"};
for i=1:numSamples
    params=Gen2_params('random');
    Data.QOIs(i,:)=BBB_Chagas_Gen2_model(POIs,select,params);
    Data.DerivedParams{i}=QOI_Derived_Params(params);
    Data.params{i}=params;
end
figure
hist(Data.QOIs(:,1))
figure
hist(Data.QOIs(:,2))
    
end

