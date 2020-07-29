function [Data] = GenerateData(numSamples)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
POIs=0;%;[.0001,.00001]; 
select.QOI={'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=1'};%,'Derived Params'};
select.POI={"null"};%{"\gamma_{SV}", "\gamma_{DV}"};
ParamSettings.paramset='random';
for i=1:numSamples
    params=Gen2_params(ParamSettings);
    Data.QOIs(i,:)=BBB_Chagas_Gen2_model(POIs,select,params);
    %Data.DerivedParams{i}=QOI_Derived_Params(params);
    Data.params{i}=params;
end
figure
hist(Data.QOIs(:,1))
figure
hist(Data.QOIs(:,2))
    
end

