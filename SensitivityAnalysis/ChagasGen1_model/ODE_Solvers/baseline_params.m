function [params] = baseline_params(varagin)
%baseline_params Creates structure of Model Parameters for Chagas Gen 1
%   Authors: Harley Hanes (harleyhanes97@gmail.com), Jessica Conrad
%   Inputs: varagin- expects no inputs (in which case uses base parameter
%                    settings) or a structure of settings selecting which
%                    parameter set to use and additional information for
%                    the given parameter set.
%   Outputs: params- Structure of model parameters, solver, initial
%                    conditions, and time constraints
%Set up variable input
if nargin>=1
    settings=varagin{1};
else
    settings.paramset='base';
end
%Check existence of paramset element
if isfield(settings,'paramset')==0
    warning('settings needs element paramset identifying parameters to use')
    keyboard
end
%% Parameters (all time components need to be in days)
switch settings.paramset
    case 'base'
        %Pop proportion
        %Doesn't leave function but determines popsizes and movement rates
        ratio.SH_DH=1;          %Assumed;
        ratio.SV_DV=1;          %Assumed;
        ratio.V_H=1289/101;     %Kribs-Zaleta2010EstimatingStates
        popsize.SH=101;
        popsize.SV=popsize.SH*ratio.V_H;
        popsize.DH=popsize.SH/ratio.SH_DH;
        popsize.DV=popsize.SV/ratio.SV_DV;
        % Theta Terms
        %Currently coded so v->t and t->v are same if in between same compartment
            %but 1/5 if between dif compartment
        %Base Rates
        theta.SH_SV=.102*(4/5);
        theta.DH_SV=.102*(1/5);

        theta.DH_DV=theta.SH_SV;
        theta.SH_DV=theta.DH_SV;
            %Adjusted according to blood meal analysis
             %--Where does this come from??????
        ratio.competant_SV=.6892;
        ratio.competant_DV=.4054;

        %Adjusted according to blood meal analysis
        %--Where does this come from??????
        % P Terms
        VReduction=1/2.8;  %Need to standardize these
        HReduction=1/18;
        p.SV_SH=.132*HReduction;
        p.SH_SV=.116*VReduction;
        % Migration Terms
        % proportion between migration rates muSV be inverse proportion
            %of pop sizes
        lambda.H=.1;%.24;
        lambda.V=.06775;%.1302;
        % Birth/Death Rates
        mu.SH=.83/365;
        mu.SV=.271/365;
        %% Test Conditions
        % Population
        fracinfect.SH=.01;
        fracinfect.SV=.01;
        fracinfect.DH=.01;
        fracinfect.DV=.01;
        % Solvers
        solver=@ode23tb;
        %Max time of simulation
        years=50;
    case InvestigateLambda
        %Check existence of required params
            if isfield(settings,'PropDomestDefficient')==0
                warning(['settings is missing PropDomestDefficient element required'...
                ' for InvestigateLambda.'])
                keyboard
            end
            if isfield(settings,'PropSpatialTrans')==0
                warning(['settings is missing PropSpatialTrans element required'...
                ' for InvestigateLambda.'])
                keyboard
            end
        %Pop Terms
            %Doesn't leave function but determines popsizes and movement rates
            ratio.SH_DH=1;          %Assumed;
            ratio.SV_DV=1;          %Assumed;
            ratio.V_H=1289/101;     %Kribs-Zaleta2010EstimatingStates
            popsize.SH=101;
            popsize.SV=popsize.SH*ratio.V_H;
            popsize.DH=popsize.SH/ratio.SH_DH;
            popsize.DV=popsize.SV/ratio.SV_DV;
        % Transmission Terms
            %Currently coded so v->t and t->v are same if in between same compartment
                %but 1/5 if between dif compartment
            %Base Rates
            theta.SH_SV=.102*(1-settings.PropSpatialTrans);
            theta.DH_SV=.102*settings.PropSpatialTrans;

            theta.DH_DV=theta.SH_SV*settings.DomestDefficient;
            theta.SH_DV=theta.DH_SV;
                %Adjusted according to blood meal analysis
                 %--Where does this come from??????
            ratio.competant_SV=.6892;
            ratio.competant_DV=.4054;

            %Adjusted according to blood meal analysis
            %--Where does this come from??????
            % P Terms
            VReduction=1/2.8;  %Need to standardize these
            HReduction=1/18;
            p.SV_SH=.132*HReduction;
            p.SH_SV=.116*VReduction;
        % Migration Terms
            % proportion between migration rates muSV be inverse proportion
                %of pop sizes
            lambda.H=.1;%.24;
            lambda.V=.06775;%.1302;
        % Birth/Death Rates
            mu.SH=.83/365;
            mu.SV=.271/365;
        % Test Conditions
            % Population
            fracinfect.SH=.01;
            fracinfect.SV=.01;
            fracinfect.DH=.01;
            fracinfect.DV=.01;
            % Solvers
            solver=@ode23tb;
            %Max time of simulation
            years=50;
    otherwise
        warning('Invalid assignment to settings.paramset')
        keyboard
end
%% Scaling 
    % Thetas
        theta.SV_SH=theta.SH_SV*ratio.V_H;%popsize.SV/popsize.SH;
        theta.DV_SH=theta.SH_DV*ratio.V_H;%popsize.DV/popsize.SH;
        theta.DV_DH=theta.DH_DV*ratio.V_H;%popsize.DH/popsize.DV;
        theta.SV_DH=theta.DH_SV*ratio.V_H;%popsize.DH/popsize.DV;
        
        
        theta.SV_SH=theta.SV_SH*ratio.competant_SV;
        theta.DV_SH=theta.DV_SH*ratio.competant_DV;
        theta.SH_SV=theta.SH_SV*ratio.competant_SV;
        theta.DH_SV=theta.DH_SV*ratio.competant_SV;
        theta.SV_DH=theta.SV_DH*ratio.competant_SV;
        theta.DV_DH=theta.DV_DH*ratio.competant_DV;
        theta.SH_DV=theta.SH_DV*ratio.competant_DV;
        theta.DH_DV=theta.DH_DV*ratio.competant_DV;
    %Birth/ Death
        mu.DH=mu.SH;
        mu.DV=mu.SV;
        gamma.SH=mu.SH;
        gamma.DH=mu.DH;
        gamma.SV=mu.SV;
        gamma.DV=mu.DV;
    %P
        p.DV_SH=p.SV_SH;
        p.DH_SV=p.SH_SV;
        p.DV_DH=p.SV_SH;
        p.SV_DH=p.DV_DH;
        p.DH_DV=p.SH_SV;
        p.SH_DV=p.DH_DV;
    %Time
        tspan=0:years*365;
    %Solvers
        solver=@ode23tb;
% Initial Conditions
    init(1,1)=popsize.SH*(1-fracinfect.SH); %Susceptible SH
    init(2,1)=popsize.SH*(fracinfect.SH);   %Infected SH
    init(3,1)=popsize.SV*(1-fracinfect.SV); %Susceptible SV
    init(4,1)=popsize.SV*(fracinfect.SV);   %Infected SV
    init(5,1)=popsize.DH*(1-fracinfect.DH); %Susceptible DH
    init(6,1)=popsize.DH*(fracinfect.DH);   %Infected DH
    init(7,1)=popsize.DV*(1-fracinfect.DV); %Susceptible DV
    init(8,1)=popsize.DV*(fracinfect.DV);   %Infected DV
% Compile Variables
    params.theta=theta;
    params.p=p;
    params.lambda=lambda;
    params.mu=mu;
    params.gamma=gamma;
    params.init=init;
    params.popsize=popsize;
    params.fracinfect=fracinfect;
    params.ratio=ratio;
    params.tspan=tspan;
end

