function [Err] = QOI_R0Error(params,POIs,select,baseParams)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
R0=QOI_R0(params,'numeric');
select.model='full';
select.QOI={'R_0'};
[QOIs,~] = BBB_Chagas_Gen2_model(POIs,select,baseParams);
Err=R0-QOIs;
end

