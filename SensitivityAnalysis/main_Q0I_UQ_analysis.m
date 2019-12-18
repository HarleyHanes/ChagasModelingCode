function [POI,QOI]=main_Q0I_UQ_analysis(varargin)
% main program to preform sensitivity analysis on the output quantities of 
% interest (QOIs) as a function of input parameters of interest (POIs)
if nargin>=1
        ModelName=varargin{1};      %Model to run is first input
    if nargin>=2
        str.ParamSettings.paramset=varargin{2};       %parameter settings are second input
    end
else
    ModelName={'CG1' 'Vis Project'};
    str.ParamSettings.paramset='base';
end

% the user must a code to generate the QOIs from the POIs 
str.QOI_model_eval = @my_model;% QOI=my_model(POI)
% If there constraints on the POIs the user must provide
str.POI_constraints= @constraints; % POI = constraints(POI_input)

% change the default str.* values in the user code
% str=QOI_change_default_params(str)

% set up the solver environment ----------
% set the path for the current directory and subdirectories 
% restoredefaultpath ;prefix = mfilename('fullpath');
% dirs = regexp(prefix,'[\\/]');addpath(genpath(prefix(1:dirs(end))))

clear global ; clf; format shortE;% close previous sessions

set(0,'DefaultAxesFontSize',18,'defaultlinelinewidth',2);set(gca,'FontSize',18);close(gcf);% increase font size
rng(10);% set the random number generator seed for reproducibility


str = QOI_define_default_params(str);
if strcmpi(ModelName{1},'CG1')
        set_workspace('CG1')
        str.QOI_model_name=ModelName{2};   %Model to run if no inputs
        str=CG1_change_default_params(str);% set the default parameter values
elseif strcmpi(ModelName{1},'CG2')||strcmpi(ModelName{1},'10ODE')||strcmpi(ModelName{1},'8ODE')
        set_workspace('CG2')
        str.QOI_model_name=ModelName{2};   %Model to run if no inputs
        str=CG2_change_default_params(str);% set the default parameter values
        if strcmpi(ModelName{1},'10ODE')
            str.select.model='10ODE';
        elseif strcmpi(ModelName{1},'8ODE')
            str.select.model='8ODE';
        end
else
        error('Unrecognized Model Name')
end

%str= QOI_change_default_params(str);% user code to change the default parameter values

% disp(str) % display the variables for solving the problem - needs a better print format

% 1. analyze the problem setup
%  str.QOI_pre_analysis(str);
% 
% % 2. local sensitivity analysis
% [POI_LSA,QOI_LSA]=str.QOI_LSA(str); POI.LSA=POI_LSA; QOI.LSA=QOI_LSA;
% 
% % 3. extended sensitivity analysis
 [POI_ESA,QOI_ESA]=str.QOI_ESA(str); POI.ESA=POI_ESA; QOI.ESA=QOI_ESA;
% 
% %4. global sensitivity analysis
% [POI_GSA,QOI_GSA]=str.QOI_GSA(str); POI.GSA=POI_GSA; QOI.GSA=QOI_GSA;

%global sensitivity sobol indices
% [sobol_indices]=Sobol_GSA(str);
% sobol_indices

% 5. final analysis the problem solution
%  str.QOI_post_analysis(str);

end



