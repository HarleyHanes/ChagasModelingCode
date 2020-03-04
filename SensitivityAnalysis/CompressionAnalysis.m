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

