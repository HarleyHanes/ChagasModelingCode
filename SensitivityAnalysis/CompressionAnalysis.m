%Compression Analysis
%Utilizes the main SA Analysis code to compare outputs of 3 different model
%constructions. Selects the model by adding a .model element of the select

%Base Model
% [POIBase,QOIBase]=main_Q0I_UQ_analysis({'CG2','Vec Infection'},'scaled');
% figure
 %keyboard
%10ODE

%% Test scaled model
clear;
%[POI10,QOI10]=main_Q0I_UQ_analysis({'10ODE','Assumptions Error: All Assumptions'},'scaled');
figure
%8ODE
% [POI8,QOI8]=main_Q0I_UQ_analysis({'8ODE','Assumptions Error: All Assumptions'},'scaled');
% figure
%% Test scaled model with identicle compartments
clear;
 [POI10,QOI10]=main_Q0I_UQ_analysis({'10ODE','Assumptions Error: All Assumptions'},...
 'Identicle Compartments (Scaled)');
figure
%8ODE
[POI8,QOI8]=main_Q0I_UQ_analysis({'8ODE','Assumptions Error: All Assumptions'},...
'Identicle Compartments (Scaled)');
% str.POI_names={'c^{SS}_{ST}','c^{DS}_{DT}','c^{DD}_{DH}','d_{SS}','d_{SR}',...
%             'd_{DS}','d_{DR}','d_{DD}'}
% str.QOI_names={'Proportion I_{DV} at equilibirium', 'R_0'}
% 
% for i=1:length(str.POI_names)

%% Test Mathematica Derived Compression
clear;close all;
%Set Test Settings
POIs=0;%;[.0001,.00001]; 
select.QOI={'Proportion I_{DV} at equilibirium'};
select.POI={"null"};%{"\gamma_{SV}", "\gamma_{DV}"};
%Get Full Model Params
ParamSettings.paramset='Mathematica Compression';
paramsFull=Gen2_params(ParamSettings);
% Run Full Chagas Model
[QOIsFull,solnFull]=BBB_Chagas_Gen2_model(POIs,select,paramsFull);

% Get Compressed Parameters
paramsCompressed=CG2toCG1params(paramsFull);
%Run Compressed Model
[QOIsCompressed,solnCompressed]=BBB_Chagas_Gen2_model(POIs,select,paramsCompressed);
% Plot the two side by side
%Plot Full Vectors
plot(soln.x(1:10:end)/365,solnFull.py(1:10:end,8))
hold on
plot(soln.x(1:10:end)/365,solnCompressed.py(1:10:end,8))
