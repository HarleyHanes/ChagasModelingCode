function main_Q0I_UQ_analysis(varagin)
clear; clear global;
% main program to preform sensitivity analysis on the output quantities of 
% interest (QOIs) as a function of input parameters of interest (POIs)
if nargin>=1
    str.QOI_model_name=varagin{1};
    if nargin>=2
        settings=varagin{2};
    end
else
    str.QOI_model_name='Chagas-Gen1-AssessLambda';
end


% the user must a code to generate the QOIs from the POIs 
str.QOI_model_eval = @my_model;% QOI=my_model(POI)
% If there constraints on the POIs the user must provide
str.POI_constraints= @constraints; % POI = constraints(POI_input)

% change the default str.* values in the user code
% str=QOI_change_default_params(str)

% set up the solver environment ----------
% set the path for the current directory and subdirectories 
%restoredefaultpath ;prefix = mfilename('fullpath');
%dirs = regexp(prefix,'[\\/]');addpath(genpath(prefix(1:dirs(end))))

set_workspace; clear global ; clf; format shortE; close all;% close previous sessions

set(0,'DefaultAxesFontSize',18,'defaultlinelinewidth',2);set(gca,'FontSize',18);close(gcf);% increase font size
rng(101);% set the random number generator seed for reproducibility

str= QOI_define_default_params(str);% set the default parameter values
str= QOI_change_default_params(str);% user code to change the default parameter values

% disp(str) % display the variables for solving the problem - needs a better print format

% 1. analyze the problem setup
%  str.QOI_pre_analysis(str);
% 
% % 2. local sensitivity analysis
 [USI,RSI]=str.QOI_LSA(str); % unscaled and relative sensitivity indices
% 
% % 3. extended sensitivity analysis
% [POI_ESA,QOI_ESA]=str.QOI_ESA(str)
% 
% %4. global sensitivity analysis
% [POI_GSA,QOI_GSA]=str.QOI_GSA(str);

%global sensitivity sobol indices
% [sobol_indices]=Sobol_GSA(str);
% sobol_indices

% 5. final analysis the problem solution
%  str.QOI_post_analysis(str);

end

function str= QOI_change_default_params(str)
%% QOI_change_default_params change default parameters
global POInames QOInames;
switch str.QOI_model_name
    case 'Chagas-Gen1-lambda'
        str.POI_names =  {'\lambda_H','\lambda_V'};
                      str.nPOI=length(str.POI_names);
        POInames = str.POI_names;
        str.QOI_names =  {'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=5', 'R_0'};
        str.nQOI=length(str.QOI_names);
        QOInames=str.QOI_names;
        str.QOI_model_eval = @BBB_Chagas_Gen1_model;
        str.POI_baseline=[.05 .05]';
        if length(str.POI_baseline)~=str.nPOI
            fprintf('ERROR!!! Different number of parameters named than entered\n')
        end
        str.POI_min=str.POI_baseline-.8*str.POI_baseline;
        str.POI_max=str.POI_baseline+.8*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
        str.POI_pdf='beta';% uniform triangle beta
        str.number_ESA_samples = 30;
    case 'Chagas-Gen1-PopParm'
        str.POI_names =  {'\lambda_H','\lambda_V','\mu_{SH}','\mu_{SV}','\mu_{DH}','\mu_{DV}'};
                      str.nPOI=length(str.POI_names);
        POInames = str.POI_names;
        str.QOI_names = {'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=5', 'R_0'};
        str.nQOI=length(str.QOI_names);
        QOInames=str.QOI_names;
        str.QOI_model_eval = @BBB_Chagas_Gen1_model;        
        params=baseline_params();

        lambda=params.lambda;
        mu=params.mu;
        str.POI_baseline=[lambda.H lambda.V mu.SH mu.SV mu.DH mu.DV ]';
        %str.POI_baseline=[.05 .05 .83/365 .271/365 .83/365 .271/365 ]';
        if length(str.POI_baseline)~=str.nPOI
            fprintf('ERROR!!! Different number of parameters named than entered\n')
        end
        str.POI_min=str.POI_baseline-.8*str.POI_baseline;
        str.POI_max=str.POI_baseline+.8*str.POI_baseline;
        str.POI_min(1:2)=0;
        str.POI_max(1:2)=2*str.POI_baseline(1:2);
        str.POI_mode=str.POI_baseline;
        str.POI_pdf='beta';% uniform triangle beta
        str.number_ESA_samples = 30;
    case 'Chagas-Gen1-Thetas'
        str.POI_names =  {'\theta^{SV}_{SH}','\theta^{DV}_{SH}','\theta^{SH}_{SV}','\theta^{DH}_{SV}',...
                          '\theta^{SV}_{DH}','\theta^{DV}_{DH}','\theta^{SH}_{DV}','\theta^{DH}_{DV}'};
            %NAMES MUST MATCH THOSE IN get_p_struct
        str.nPOI=length(str.POI_names);
        POInames = str.POI_names;
        str.QOI_names =  {'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=5', 'R_0'};
        str.nQOI=length(str.QOI_names);
        QOInames=str.QOI_names;
        str.QOI_model_eval = @BBB_Chagas_Gen1_model;
        params=baseline_params();
        theta=params.theta;
        str.POI_baseline=[theta.SV_SH theta.DV_SH theta.SH_SV theta.DH_SV...
                          theta.SV_DH theta.DV_DH theta.SH_DV theta.DH_DV]';
        %str.POI_baseline=[.01 .002 .01 .002 .002 .01 .002 .01]';
        if length(str.POI_baseline)~=str.nPOI
            fprintf('ERROR!!! Different number of parameters named than entered\n')
        end
        str.POI_min=str.POI_baseline-.5*str.POI_baseline;
        str.POI_max=str.POI_baseline+.5*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
        str.POI_pdf='beta';% uniform triangle beta
        str.number_ESA_samples = 30;
    case 'Chagas-Gen1-Full'
        str.POI_names =  {'\theta^{SV}_{SH}','\theta^{DV}_{SH}','\theta^{SH}_{SV}','\theta^{DH}_{SV}',...
                          '\theta^{SV}_{DH}','\theta^{DV}_{DH}','\theta^{SH}_{DV}','\theta^{DH}_{DV}',...
                          '\lambda_H','\lambda_V','\mu_{SH}','\mu_{SV}','\mu_{DH}','\mu_{DV}'};
            %NAMES MUST MATCH THOSE IN get_p_struct
        str.nPOI=length(str.POI_names);
        POInames = str.POI_names;
        str.QOI_names =  {'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=5', 'R_0'};
        str.nQOI=length(str.QOI_names);
        QOInames=str.QOI_names;
        str.QOI_model_eval = @BBB_Chagas_Gen1_model;
        params=baseline_params();
        theta=params.theta;
        lambda=params.lambda;
        mu=params.mu;
        str.POI_baseline=[theta.SV_SH theta.DV_SH theta.SH_SV theta.DH_SV...
                          theta.SV_DH theta.DV_DH theta.SH_DV theta.DH_DV ...
                          lambda.H lambda.V mu.SH mu.SV mu.DH mu.DV ]';
        %str.POI_baseline=[.01 .002 .01 .002 .002 .01 .002 .01]';
        if length(str.POI_baseline)~=str.nPOI
            fprintf('ERROR!!! Different number of parameters named than entered\n')
        end
        str.POI_min=str.POI_baseline-.75*str.POI_baseline;
        str.POI_max=str.POI_baseline+.75*str.POI_baseline;
        str.POI_min(9:10)=0;
        str.POI_max(9:10)=2*str.POI_baseline(9:10);
        str.POI_mode=str.POI_baseline;
        str.POI_pdf='beta';% uniform triangle beta
        str.number_ESA_samples = 30;
    case 'Chagas-Gen1-ConstrainedTrans'
        str.POI_names =  {'\theta^{SV}_{SH}','\theta^{SH}_{SV}',...
                          '\theta^{DV}_{DH}','\theta^{DH}_{DV}',...
                          '\lambda_H','\lambda_V','\mu_{SH}',...
                          '\mu_{SV}','\mu_{DH}','\mu_{DV}'};
            %NAMES MUST MATCH THOSE IN get_p_struct
        str.nPOI=length(str.POI_names);
        POInames = str.POI_names;
        str.QOI_names =  {'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=5', 'R_0'};
        str.nQOI=length(str.QOI_names);
        QOInames=str.QOI_names;
        str.QOI_model_eval = @BBB_Chagas_Gen1_model;
        params=baseline_params();
        theta=params.theta;
        lambda=params.lambda;
        mu=params.mu;
        str.POI_baseline=[theta.SV_SH  theta.SH_SV theta.DV_DH  theta.DH_DV ...
                          lambda.H lambda.V mu.SH mu.SV mu.DH mu.DV ]';
        %str.POI_baseline=[.01 .002 .01 .002 .002 .01 .002 .01]';
        if length(str.POI_baseline)~=str.nPOI
            fprintf('ERROR!!! Different number of parameters named than entered\n')
        end
        str.POI_min=str.POI_baseline-.75*str.POI_baseline;
        str.POI_max=str.POI_baseline+.75*str.POI_baseline;
        str.POI_min(5:6)=0;
        str.POI_max(5:6)=str.POI_baseline(5:6);
        str.POI_mode=str.POI_baseline;
        str.POI_pdf='beta';% uniform triangle beta
        str.number_ESA_samples = 40;
    case 'Chagas-Gen1-AssessLambda'
        str.POI_names =  {'\lambda_H','\lambda_V'};
            %NAMES MUST MATCH THOSE IN get_p_struct
        str.nPOI=length(str.POI_names);
        str.select.POI=str.POI_names;
        str.QOI_names =  {'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=5', 'R_0'};
        str.nQOI=length(str.QOI_names);
        str.select.QOI=str.QOI_names;
        str.QOI_model_eval = @BBB_Chagas_Gen1_model;
        params=baseline_params();
        lambda=params.lambda;
        str.POI_baseline=[lambda.H lambda.V]';
        %str.POI_baseline=[.01 .002 .01 .002 .002 .01 .002 .01]';
        if length(str.POI_baseline)~=str.nPOI
            fprintf('ERROR!!! Different number of parameters named than entered\n')
        end
        str.POI_min=zeros(1,2);
        str.POI_max=2*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
        str.POI_pdf='beta';% uniform triangle beta
        str.number_ESA_samples = 40;
    otherwise
        error([' str.QOI_model =',str.QOI_model,' is not available'])
end

end


