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
% if isfield(ParamSettings,'paramset')==0
%     warning('settings needs element "paramset" identifying parameters to use')
%     keyboard
% end
fprintf("Loading '%s' parameters\n",ParamSettings.paramset)

%% Simulation Settings
%These are Parameters that are variable based on the conditions we wish to
%assess.
%Define areas in in hectares and densities in per hecatre
Area.S=2;%20;  %600x600
Area.D=1.6;%16; % 400x400
tmax=20; %In years
tstep=2;

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
    %% Population Densities
            D.Households=.81614;
            D.Humans=2.556;
            N.Humans=D.Humans*Area.D;
        %Vectors
            D.V=319;
        %Synanthropes
            D.Raccoon=.356;     %Kribs-Zaleta2010Estimating
            D.Armadillo=1.45;     %Kribs-Zaleta2010Estimating
            D.S=D.Raccoon+D.Armadillo;
        %Rodents
            D.Squirrel=4.65;
            D.R=D.Squirrel;
    %Peridomestic
        %Domestic Mammals
            D.Dog=.629*D.Households;
            D.Cow=.0629*D.Households;
            D.D=D.Dog+D.Cow;
    %% Lifespans
        %Vectors
            Lifespan.V=-456.6/log(16/213);%456.6;%1346.86;
        %Synanthropes
            Lifespan.Raccoon=912.5;
            Lifespan.Armadillo=1087.795;
        %Rodents
            Lifespan.Squirrel=300;
        %Domestic Mammals
            Lifespan.Dog=4197.5;
            Lifespan.InfectedDog=1474.7973;
            Lifespan.Cow=2190;
    %% Contact Rates 
        %Vector Feeding 
            b.Vector=.187;          %Hays1965Longevity
            %Proportion of feeding
                %Periomestic
                    rho.Humans=.3313;
                    rho.Raccoon=.1791;
                    rho.Armadillo=.1861;
                    rho.Squirrel=.0461;
                    rho.Dog=.1964;
                    rho.Cow=.0149;
                %Sylvatic
                    %Will be scaled from peridomestic values 
        %Host Feeding- Upper end estimates
            b.Armadillo=1/4;
            b.Raccoon=1/4;
            b.Squirrel=1/4;
            b.Dog=1/4;
            b.Cow=0;
    %% Transmission Probabilities
        %Host --> Vector (From parisitemia levels)
            p.Raccoon_V=.788;
            p.Armadillo_V=.767;
            p.Squirrel_V=.7097;
            p.Dog_V=.823;
            p.Cow_V=p.Dog_V;
        %Vector --> Host (Stecorian)
            p.V_Opossum=.06;
            p.V_Raccoon=p.V_Opossum;
            p.V_Armadillo=p.V_Opossum;
            p.V_Squirrel=p.V_Opossum;
            p.V_Dog=p.V_Opossum;
            p.V_Cow=p.V_Opossum;
        %Vector --> Host (Oral)
            q.V_Opossum=.108;
            q.V_Raccoon=q.V_Opossum;
            q.V_Armadillo=q.V_Opossum;
            q.V_Squirrel=q.V_Opossum;
            q.V_Dog=q.V_Opossum;
            q.V_Cow=q.V_Opossum;
    %Host vertical transmission
            r.R=.091;
    %Movement Rates
        %Vectors
            lambda.V=1/7;
        %Synanthropic Mammals
            lambda.S=1/7;
        %Rodents
            lambda.R=1/7;
%% Model Parameter Calculation
    %% Population Sizes
        N.SV=D.V*Area.S;
        N.DV=D.V*Area.D;
        N.SS=(D.Armadillo+D.Raccoon)*Area.S;
        N.DS=(D.Armadillo+D.Raccoon)*Area.D;
        N.SR=D.Squirrel*Area.S;
        N.DR=D.Squirrel*Area.D;
        N.DD=(D.Cow+D.Dog)*Area.D*D.Households;
    %% Lifespan
        gamma.SV=1/Lifespan.V;
        gamma.DV=gamma.SV;
        gamma.SS=(D.Raccoon*1/Lifespan.Raccoon+D.Armadillo*1/Lifespan.Armadillo)/(D.Raccoon+D.Armadillo);
        gamma.DS=gamma.SS;
        gamma.SR=1/Lifespan.Squirrel;
        gamma.DR=gamma.SR;
        gamma.DD=(D.Dog*1/Lifespan.Dog+D.Cow*1/Lifespan.Cow)/(D.Cow+D.Dog);
        mu.DD=(D.Dog*1/Lifespan.InfectedDog+D.Cow*1/Lifespan.Cow)/(D.Cow+D.Dog);
    %% Recruitment
        sigma.SV=N.SV*gamma.SV;
        sigma.DV=N.DV*gamma.DV;
        sigma.SS=N.SS*gamma.SS;
        sigma.DS=N.DS*gamma.DS;
        sigma.SR=N.SR*gamma.SR;
        sigma.DR=N.DR*gamma.DR;
        sigma.DD=N.DD*gamma.DD;
    %% Host -> Vector Contacts
        alpha.DS_DV=b.Vector*(rho.Armadillo*p.Armadillo_V+rho.Raccoon*p.Raccoon_V); 
        alpha.DR_DV=b.Vector*(rho.Squirrel*p.Squirrel_V);
        alpha.DD_DV=b.Vector*(rho.Dog*p.Dog_V+rho.Cow*p.Cow_V);
        rho.AmplificationFactor=(rho.Armadillo+rho.Raccoon+rho.Squirrel+rho.Dog+rho.Cow)/(rho.Raccoon+rho.Armadillo+rho.Squirrel);
        alpha.SS_SV=alpha.DS_DV*rho.AmplificationFactor;
        alpha.SR_SV=alpha.DR_DV*rho.AmplificationFactor;
        
    %Vector -> Host Contacts
        %Stecorian Rates- Same as Host->Vector but rescaled by population
        %proportions according to species
        alphaStecorian.DV_DS=b.Vector*(D.V/D.S)*(rho.Armadillo*p.V_Armadillo+rho.Raccoon*p.V_Raccoon); 
        alphaStecorian.DV_DR=b.Vector*(D.V/D.R)*rho.Squirrel*p.V_Squirrel;
        alphaStecorian.DV_DD=b.Vector*(D.V/D.D)*(rho.Dog*p.V_Dog+rho.Cow*p.V_Cow);
        alphaStecorian.SV_SS=alphaStecorian.DV_DS*rho.AmplificationFactor;
        alphaStecorian.SV_SR=alphaStecorian.DV_DR*rho.AmplificationFactor;
        switch ParamSettings.paramset
            case 'Test StecorianpHost'
                alphaStecorian.DV_DS=alphaStecorian.DV_DS*ParamSettings.pScale;
                alphaStecorian.DV_DR=alphaStecorian.DV_DR*ParamSettings.pScale;
                alphaStecorian.DV_DD=alphaStecorian.DV_DD*ParamSettings.pScale;
                alphaStecorian.SV_SS=alphaStecorian.SV_SS*ParamSettings.pScale;
                alphaStecorian.SV_SR=alphaStecorian.SV_SR*ParamSettings.pScale;
        end
    	%Oral Rates
        alpha.DV_DS=alphaStecorian.DV_DS+(D.Armadillo*b.Armadillo*q.V_Armadillo+D.Raccoon*b.Raccoon*q.V_Raccoon)/(D.S);
        alpha.DV_DR=alphaStecorian.DV_DR+b.Squirrel*q.V_Squirrel;
        alpha.DV_DD=alphaStecorian.DV_DD+(D.Dog*b.Dog*q.V_Dog+D.Cow*b.Cow*q.V_Cow)/(D.D);
        alpha.SV_SS=alphaStecorian.SV_SS+(D.Armadillo*b.Armadillo*q.V_Armadillo+D.Raccoon*b.Raccoon*q.V_Raccoon)/(D.S);
        alpha.SV_SR=alphaStecorian.SV_SR+b.Squirrel*q.V_Squirrel;
        switch ParamSettings.paramset
            case 'scaled'
                Scale=[0.452570670767227   0.001261826225713   0.008922234245436...
                    0.001453469348131   0.011266869442432   0.000120370079587];
                %Hosts
                alpha.SV_SS=alpha.SV_SS*Scale(2);%.000788;
                alpha.SV_SR=alpha.SV_SR*Scale(3);%.0057;
                alpha.DV_DS=alpha.DV_DS*Scale(4);%.000788;
                alpha.DV_DR=alpha.DV_DR*Scale(5);%.0057;
                alpha.DV_DD=alpha.DV_DD*Scale(6);%000161;
                %Vectors  
                alpha.SS_SV=alpha.SS_SV*Scale(1);%.000788;
                alpha.SR_SV=alpha.SR_SV*Scale(1);%.0057;
                alpha.DS_DV=alpha.DS_DV*Scale(1);%.000788;
                alpha.DR_DV=alpha.DR_DV*Scale(1);%.0057;
                alpha.DD_DV=alpha.DD_DV*Scale(1);%000161;
            case 'Test pHost'
                alpha.DV_DS=alpha.DV_DS*ParamSettings.pScale;
                alpha.DV_DR=alpha.DV_DR*ParamSettings.pScale;
                alpha.DV_DD=alpha.DV_DD*ParamSettings.pScale;
                alpha.SV_SS=alpha.SV_SS*ParamSettings.pScale;
                alpha.SV_SR=alpha.SV_SR*ParamSettings.pScale;
        end
%% Simulation Parameters 
    %Time
        tspan=0:tstep:tmax*365;
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
            
% Scaling Assumptions- Commented out because I haven't checked if they're
% still good with the host change
     EquilNDD=0.8527*N.DD; % THis proportion is at the base spatial level but I think its conserved
     c.SS_ST=N.SS/(N.SS+N.SR);
     c.SR_ST=N.SR/(N.SS+N.SR);
     c.DS_DT=N.DS/(N.DS+N.DR);
     c.DR_DT=N.DR/(N.DS+N.DR);
     c.DD_DH=EquilNDD/(N.DS+N.DR+EquilNDD);
     c.DT_DH=(N.DS+N.DR)/(N.DS+N.DR+EquilNDD);
     d.SS=.5001756;
     d.DS=.49969649;
     d.SR=.15001910;
     d.DR=.149971758;
     d.DD=.160043318;
     d.DT=c.DS_DT*d.DS+c.DR_DT*d.DR;
    switch ParamSettings.paramset
        case 'Identicle Compartments'
                %Set equal biting rates
                b.SS=b.SR;
                b.DS=b.DR; b.DD=b.DR;

                %Set equal p's and q's
                p.S_V=p.R_V; p.D_V=p.R_V;
                p.V_S=p.V_R; p.V_D=p.V_R;
                q.V_S=q.V_R; q.V_D=q.V_R;

                %Set equal rho's
                rho.SS=rho.SR;
                rho.DS=rho.DR; rho.DD=rho.DR;
                gamma.SS=gamma.SR;
                gamma.DS=gamma.DR; gamma.DD=gamma.DD;
                
                %Set equal gamma's
                gamma.SS=gamma.SR;
                gamma.DS=gamma.DR; gamma.DD=gamma.DR;
                
                %Note that the formula's for alpha contain a conversion in
                %population units from vectors to host which is dependent
                %upon each's relative size. This way of doing it ignores
                %that which may be inaccurate.
                %Set equal alpha's
                alpha.SS_SV=alpha.SR_SV; alpha.SV_SS=alpha.SV_SR;
                alpha.DS_DV=alpha.DR_DV; alpha.DV_DS=alpha.DV_DR;
                alpha.DD_DV=alpha.DR_DV; alpha.DV_DD=alpha.DV_DR;
                
                %Set equal beta's
                beta.SV_SS=beta.SV_SR;
                beta.DV_DS=beta.DV_DR; beta.DV_DD=beta.DV_DR;
                
                %Set eqaul lambda's
                lambda.S=lambda.R;
        
                %Set equal r's
                 r.R=0;
%         d.SS=.168400361814803;
%         d.DS=.168920082403009;
%         d.SR=.169433222736276;
%         d.DR=.169796111192311;
%         d.DD=.171800889326599;
    end
% Compile Variables
    params.bio.b=b;
    params.bio.p=p;
    params.bio.q=q;
    params.bio.rho=rho;
    params.bio.D=D;
    params.bio.Area=Area;
    params.N=N;
    params.gamma=gamma;
    params.mu=mu;
    params.sigma=sigma;
    params.alpha=alpha;
    params.lambda=lambda;
    params.r=r;
    params.init=init;
    params.fracinfect=fracinfect;
    params.tspan=tspan; 
    params.PopProportions.c=c;
    params.PopProportions.d=d;
end