%% Local and Extended Sensitivity Analysis for Big_Black_Box_SIR_model
% Analyzing the sensitivity of SIR output quantities
%%
% Add local library directories and set plotting defaults
%set_workspace ;
set_workspace; clear global; close all;

%% Setup SIR sensitivity analysis problem
% The model_eval takes a POI array and returns the QOI array.
model_eval = @Big_Black_Box_Chagas_model;
params=baseline_params();
theta=params.theta;
p=params.p;
lambda=params.lambda;
mu=params.mu;
%Index guide for POI.Ref
%P=[theta.SV_SH, theta.DV_SH, theta.SH_SV, theta.DH_SV, ...
%    theta.SV_DH, theta.DV_DH, theta.SH_DV, theta.DH_DV,...
%    lambda.SH_DH lambda.DH_SH mu.SH mu.SV, ...
%    mu.DH mu.DV];

% baseline beta and gamma and ranges for input POIs
%Test all Parameters
% POIs.names = {'\theta^{SV}_{SH}','\theta^{DV}_{SH}','\theta^{SH}_{SV}','\theta^{DH}_{SV}',...
%               '\theta^{SV}_{DH}','\theta^{DV}_{DH}','\theta^{SH}_{DV}','\theta^{DH}_{DV}',...
%               '\lambda^{SH}_{DH}','\lambda^{SV}_{DV}','mu_{SH}','mu_{SV}', 'mu_{DH}','mu_{DV}'}; 
% POIs.params = [theta.SV_SH, theta.DV_SH, theta.SH_SV, theta.DH_SV, ...
%     theta.SV_DH, theta.DV_DH, theta.SH_DV, theta.DH_DV,...
%     lambda.SH_DH lambda.DH_SH mu.SH mu.SV, ...
%     mu.DH mu.DV]; % baseline POI values
% POIs.ref    = [1:14]; % Records which params are  POI's
% POIs.ranges = [ 1,   10;
%                 .1,  2 ;
%                 .1,  2 ;
%                 1,   10];
% Test All Biting Rates
POIs.names = {'\theta^{SV}_{SH}','\theta^{DV}_{SH}','\theta^{SH}_{SV}','\theta^{DH}_{SV}',...
    '\theta^{SV}_{DH}','\theta^{DV}_{DH}','\theta^{SH}_{DV}','\theta^{DH}_{DV}'}; 
POIs.params = [theta.SV_SH, theta.DV_SH, theta.SH_SV, theta.DH_SV,...
    theta.SV_DH, theta.DV_DH, theta.SH_DV, theta.DH_DV]; % baseline POI values
POIs.ref    = [1:8]; % Records which params are  POI's
POIs.ranges = [theta.SV_SH*.75,   theta.SV_SH*1.25;
               theta.DV_SH*.75,   theta.DV_SH*1.25;
               theta.SH_SV*.75,   theta.SH_SV*1.25;
               theta.DH_SV*.75,   theta.DH_SV*1.25;
               theta.SV_DH*.75,   theta.SV_DH*1.25;
               theta.DV_DH*.75,   theta.DV_DH*1.25;
               theta.SH_DV*.75,   theta.SH_DV*1.25;
               theta.DH_DV*.75,   theta.DH_DV*1.25];
POIs.params=POIs.params';
% POIs.names = {'\lambda^{SH}_{DH}','\lambda^{SV}_{DV}','mu_{SH}','mu_{SV}', 'mu_{DH}','mu_{DV}'}; 
% POIs.params = [lambda.SH_DH lambda.SV_DV mu.SH mu.SV mu.DH mu.DV]; % baseline POI values
% POIs.ref    = [9:14]; % Records which params are  POI's
% POIs.ranges = [lambda.SH_DH/2,  lambda.SH_DH*1.5;
%                lambda.SV_DV/2,  lambda.SV_DV*1.5;
%                mu.SH/2,   mu.SH*1.5;
%                mu.SV/2,   mu.SV*1.5;
%                mu.DH/2,   mu.DH*1.5;
%                mu.DV/2,   mu.DV*1.5];

% labels for output QOIs
QOI_Names = {'Final Infected DV','R0'};
 
%% Local Sensitivity Analysis of the Model
% compute the Jacobian sensitivity matrix for the QOIs with respect to the POIs 
jacobian = getJacobian(POIs,model_eval,'raw',true);
t=jacobian(:,1);
f=jacobian(:,2);
Theta_1 = jacobian(:,3);
Theta_2 = jacobian(:,4);
unscaled_sensitivity_indicies = table(t,f,Theta_1,Theta_2,'RowNames',QOI_Names)

%%
% If we mult by q/p at the baseline for relative sensitivity analysis
jacobianScaled = getJacobian(POIs,model_eval);
Theta_1 = jacobianScaled(:,1);
Theta_2 = jacobianScaled(:,2);
relative_sensitivity_indicies = table(Theta_1,Theta_2,'RowNames',QOI_Names)

% Will save .tex files to current dir unless given an 'outputDir'
filename='sens_matrix.tex';
LaTeX_matrix(jacobianScaled,QOI_Names,POIs.names,'filename',filename)
display(['Sensitivity Matrix written to LaTeX file ',filename])

% return % comment this line out for the extended sensitivity analysis

%% Extended Sensitivity Anaysis 
% This calculates data from a model around a base set of params with ranges for each parameter.
%
% getData outputs two structs, POI_Data and QOI_Data, with similar fields:
% * .base: base params and quant evaled at the base params
% * .range: each param evaled along linear spaced nPoints of given range
 nfel=10;% number of function evaluations per line search (optional, default=10)
[POI_Data,QOI_Data] = getData(POIs, model_eval, nfel);

%%
% These are the POIs at the baseline
QOI_baseline = QOI_Data.base;

%% Response Plots
%%%
% responsePlots expects the structs output by getData.
% it generates a figure per quantity, plotting each parameter ranging around baseline

% If you do not assign the output to a variable like 'plots', you do not have to call figure on each entry.
% this is done for display purposes when publishing this example
plots = responsePlots(POI_Data, QOI_Data, ...
    'paramNames',string(POIs.names), ...
    'quantNames',string(QOI_Names));

% plot the data
set(0,'DefaultAxesFontSize',12,'defaultlinelinewidth',2); 
set(gca,'FontSize',15);% set ploting font size

nplots=length(QOI_Names);
for iplot=1:nplots
figure(plots(iplot))
end
