function [params] = Gen2_params(varargin)
%baseline_params Creates structure of Model Parameters for Chagas Gen 2
%   Authors: Harley Hanes (harleyhanes97@gmail.com), Jessica Conrad
%   Inputs: varagin- expects no inputs (in which case uses base parameter
%                    settings) or a structure of settings selecting which
%                    parameter set to use and additional information for
%                    the given parameter set.
%   Outputs: params- Structure of model parameters, solver, initial
%                    conditions, and time constraints
%Set up variable input
%Param settings non functional
if nargin>=1
    ParamSettings=varargin{1};
else
    ParamSettings.paramset='base';
end
%Check existence of paramset element
if isfield(ParamSettings,'paramset')==0
    warning('settings needs element "paramset" identifying parameters to use')
    keyboard
end
fprintf("Loading '%s' parameters\n",ParamSettings.paramset)

%% Simulation Settings
%These are Parameters that are variable based on the conditions we wish to
%assess.
%Define areas in in hectares and densities in per hecatre
SylvaticArea=5;
PeridomesticArea=2;
DensityOfHouseholds=5;
tmax=10; %In years

%Initial Conditions
fracinfect.SV=.01;
fracinfect.DV=.01;
fracinfect.SS=.01;
fracinfect.DS=.01;
fracinfect.SR=.01;
fracinfect.DR=.01;
fracinfect.DD=.01;


%% Biological Parameters
%These are the parameters found in other papers or assumed based on
%literature research. We will use these to define our actual model
%parameters.
%Population Densities
    %Sylvatic
        %Vectors
            VDensityS=346.88;
        %Synanthropes
            SRaccoonDensityS=.21;     %Kribs-Zaleta2010Estimating
            SOpossumDensityS=.11;     %Kribs-Zaleta2010Estimating
        %Rodents
            RBlackDensityS=7.86;
            RBrownDensityS=113;
            RMarshDensityS=3.1;
            RCottonDensityS=22.36;
            RHouseDensityS=RBrownDensityS;
        %Wild
    %Peridomestic
        %Vectors
            VDensityD=VDensityS;   %Assumed to be same as VectorDensityS
        %Synanthropes
            SRaccoonDensityD=SRaccoonDensityS;     
            SOpossumDensityD=SOpossumDensityS;     
        %Rodents
            RBlackDensityD=RBlackDensityS;
            RBrownDensityD=58;
            RMarshDensityD=RMarshDensityS;
            RCottonDensityD=RCottonDensityS;
            RHouseDensityD=RHouseDensityS;
        %Domestic Mammals
            DDogDensityD=.629*DensityOfHouseholds;
            DCatDensityD=.814*DensityOfHouseholds;
%Lifespans
    %Vectors
        VLifespan=1346.86;
    %Synanthropes
        SRaccoonLifespan=912.5;
        SOpossumLifespan=439.76;
    %Rodents
        %RBlackLifespan=NaN;
        RBrownLifespan=121.839;
        %RMarshLifespan=NaN;
        %RCottonLifespan=NaN;
        %RHouseLifespan=NaN;
    %Domestic Mammals
        DDogLifespan=200;
        DCatLifespan=200;
%Vector Feeding
    %Feeding Rates
        b.SV=.187;          %Hays1965Longevity
        b.DV=b.SV;          %Assumed to be same as b_SV
    %Proportion of feeding
        %Periomestic
            rho.DS=.3843;
            rho.DR=.0494;
            rho.DD=.2209;
            rho.H=.3313;
        %Sylvatic
            rho.SS=rho.DS+(rho.DS/(rho.DS+rho.DR))*(rho.DD+rho.H);  %Assume vector feedings on domestic mammals and humans are distributed proportionally among rodents and synanthropes
            rho.SR=rho.DR+(rho.DR/(rho.DS+rho.DR))*(rho.DD+rho.H);
%Host-->Vector transmission
    p.Dog_V=.92; 
    p.H_V=p.Dog_V; %Assume dog value holds for all hosts
%Vector-->Host transmission (stechorian)
    p.V_Opossum=.06;   %Currently the only one that could be found
    p.V_S=p.V_Opossum;
    p.V_R=p.V_Opossum;
    p.V_Dog=.001;
    p.V_D=p.V_Dog;
%Vector-->Host transmission (oral)
    b.Opossum=4.108;    %Assume this is the maximal rate for all hosts
    b.H=b.Opossum;
    b.SS=b.H;
    b.DS=b.H;
    b.SR=b.H;
    b.DR=b.H;
    b.DD=b.H;
    q.V_Opossum= .075;  
    q.V_H=q.V_Opossum;
%Host vertical transmission
    r.R=.091;
%Movement rates

    
%% Model Parameters-- These generally should not be changed
%Population Sizes
    %Vectors 
        N.SV=VDensityS*SylvaticArea;
        N.DV=VDensityD*PeridomesticArea;
    %Synanthropic Hosts
        N.SS=(SRaccoonDensityS+SOpossumDensityS)*SylvaticArea;
        N.DS=(SRaccoonDensityD+SOpossumDensityD)*PeridomesticArea;
    %Rodents
        N.SR=(RBlackDensityS+RBrownDensityS+RMarshDensityS+RCottonDensityS+RHouseDensityS)*SylvaticArea;
        N.DR=(RBlackDensityD+RBrownDensityD+RMarshDensityD+RCottonDensityD+RHouseDensityD)*PeridomesticArea;
    %Domestic Mammals
        N.DD=(DDogDensityD+DCatDensityD)*PeridomesticArea;
%Death Rates -%weighted averages of each death rate according to density
    %Vectors
        gamma.SV=1/VLifespan;
        gamma.DV=gamma.SV;
    %Synanthropic Hosts
        gamma.SS=(SRaccoonDensityS*(1/SRaccoonLifespan)+SOpossumDensityS*(1/SOpossumLifespan))*SylvaticArea/N.SS;
        gamma.DS=gamma.SS;
    %Rodents
        gamma.SR=1/RBrownLifespan*(1-r.R);
        gamma.DR=gamma.SR;
    %Domestic Mammals
        gamma.DD=(DDogDensityD*(1/DDogLifespan)+DCatDensityD*(1/DCatLifespan))*PeridomesticArea/N.DD;
%Host-->Vector transmission rates
     %Sylvatic Vectors
        alpha.SS_SV=p.H_V*b.SV*rho.SS;
        alpha.SR_SV=p.H_V*b.SV*rho.SR;
     %Peridomestic Vectors
        alpha.DS_DV=p.H_V*b.DV*rho.DS;
        alpha.DR_DV=p.H_V*b.DV*rho.DR;
        alpha.DD_DV=p.H_V*b.DV*rho.DD;
%Vector-->Host transmission rates (stechorian)
    %Sylvatic Hosts
        alpha.SV_SS=p.V_S*b.SV*rho.SS*N.SV/N.SS;
        alpha.SV_SR=p.V_R*b.SV*rho.SR*N.SV/N.SR;
    %Peridomestic Hosts
        alpha.DV_DS=p.V_S*b.DV*rho.DS*N.DV/N.DS;
        alpha.DV_DR=p.V_R*b.DV*rho.DR*N.DV/N.DR;
        alpha.DV_DD=p.V_D*b.DV*rho.DD*N.DD/N.DR;
%Vector-->Host transmission rates (oral)
    %Sylvatic Hosts
        beta.SV_SS=q.V_H*b.SS;%q_V_H*b_SH;
        beta.SV_SR=q.V_H*b.SR;%q_V_H*b_SH;
    %Peridomestic Hosts
        beta.DV_DS=q.V_H*b.DS;%q_V_H*b_SH;
        beta.DV_DR=q.V_H*b.DR;%q_V_H*b_SH;
        beta.DV_DD=q.V_H*b.DD;%q_V_H*b_SH;
%Movement Rates
    %Vectors
        lambda.V=.06775;
    %Synanthropic Mammals
        lambda.S=.24;
    %Rodents
        lambda.R=.1;
        

%% Simulation Parameters 
    %Time
        tspan=0:tmax*365;
% Initial Conditions
    init=NaN(14,1);
    %Sylvatic
        %Vectors
            init(1,1)=N.SV*(1-fracinfect.SV); %Susceptible
            init(2,1)=N.SV*fracinfect.SV; %Infected
        %Synanthropes
            init(3,1)=N.SS*(1-fracinfect.SS); %Susceptible
            init(4,1)=N.SS*fracinfect.SS; %Infected
        %Rodents
            init(5,1)=N.SR*(1-fracinfect.SR); %Susceptible
            init(6,1)=N.SR*fracinfect.SR; %Infected
    %Peridomestic
        %Vectors
            init(7,1)=N.DV*(1-fracinfect.DV); %Susceptible
            init(8,1)=N.DV*fracinfect.DV; %Infected
        %Synanthropes
            init(9,1)=N.DS*(1-fracinfect.DS); %Susceptible
            init(10,1)=N.DS*fracinfect.DS; %Infected
        %Rodents
            init(11,1)=N.DR*(1-fracinfect.DR); %Susceptible
            init(12,1)=N.DR*fracinfect.DR; %Infected
        %Domestic Mammals
            init(13,1)=N.DD*(1-fracinfect.DD); %Susceptible
            init(14,1)=N.DD*fracinfect.DD; %Infected
% Compile Variables
    params.bio.b=b;
    params.bio.p=p;
    params.bio.q=q;
    params.bio.rho=rho;
    params.N=N;
    params.gamma=gamma;
    params.alpha=alpha;
    params.beta=beta;
    params.lambda=lambda;
    params.r=r;
    params.init=init;
    params.fracinfect=fracinfect;
    params.tspan=tspan;            
end