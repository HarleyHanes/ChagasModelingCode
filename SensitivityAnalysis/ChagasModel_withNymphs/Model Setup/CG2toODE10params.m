function [params] = CG2toODE10params(CG2)
%CG2toODE10params Derives Parameters for 10 ODE model from a given set of
%14 ODE Params
%   Detailed explanation goes here
%fprintf('Loading Parameters for 10 ODE Model\n')
c=CG2.PopProportions.c;
d=CG2.PopProportions.d;
        N.Humans=CG2.N.Humans;
        N.SV=CG2.N.SV;
        N.DV=CG2.N.DV;
    %Synanthropic Hosts
        N.SS=0;
        N.DS=0;
    %Rodents
        N.SR=CG2.N.SS+CG2.N.SR;
        N.DR=CG2.N.DS+CG2.N.DR;
    %Domestic Mammals
        N.DD=CG2.N.DD;
%Recruitment Rates-Sums of initial compartments recruitment rates
        sigma.SS=0;
        sigma.DS=0;
        sigma.SV=CG2.sigma.SV;
        sigma.DV=CG2.sigma.DV;
        sigma.DD=CG2.sigma.DD;
        sigma.SR=CG2.sigma.SS+CG2.sigma.SR;
        sigma.DR=CG2.sigma.DS+CG2.sigma.DR;
%Death Rates -%weighted averages of each death rate according to density
    %Vectors
        gamma.SV=CG2.gamma.SV;
        gamma.DV=CG2.gamma.DV;
    %Synanthropic Hosts
        gamma.SS=0;
        gamma.DS=0;
    %Rodents
        gamma.SR=c.SS_ST*CG2.gamma.SS+c.SR_ST*CG2.gamma.SR;
        gamma.DR=gamma.SR;
    %Domestic Mammals
        gamma.DD=CG2.gamma.DD;
%Host-->Vector transmission rates
     %Sylvatic Vectors
        alpha.SR_SV=(CG2.alpha.SS_SV*d.SS+CG2.alpha.SR_SV*d.SR)...
            /(d.SS*c.SS_ST+d.SR*c.SR_ST);
        alpha.SS_SV=0;
     %Peridomestic Vectors
        alpha.DR_DV=(CG2.alpha.DS_DV*d.DS+CG2.alpha.DR_DV*d.DR)...
            /(d.DS*c.DS_DT+d.DR*c.DR_DT);
        alpha.DS_DV=0;
        alpha.DD_DV=CG2.alpha.DD_DV;
%Vector-->Host transmission rates
    %Sylvatic Hosts
        alpha.SV_SR=(CG2.alpha.SV_SS*(1-d.SS)*c.SS_ST+CG2.alpha.SV_SR*(1-d.SR)*c.SR_ST)...
            /((1-d.SS)*c.SS_ST+(1-d.SR)*c.SR_ST);
        alpha.SV_SS=0; %This was bugged in the first draft
    %Peridomestic Hosts
        alpha.DV_DR=(CG2.alpha.DV_DS*c.DS_DT*(1-d.DS)+CG2.alpha.DV_DR*c.DR_DT*(1-d.DR))...
            /(c.DS_DT*(1-d.DS)+c.DR_DT*(1-d.DR));
        alpha.DV_DS=0;
        alpha.DV_DD=CG2.alpha.DV_DD;
%Movement rates
        lambda.S=0;
        lambda.R=c.SS_ST*CG2.lambda.S+c.SR_ST*CG2.lambda.R;
        lambda.V=CG2.lambda.V;
%Vertical Transmission
        r.R=CG2.sigma.SR/sigma.SR*(CG2.r.R*d.SR)/(d.SS*c.SS_ST+d.SR*c.SR_ST);
%Inits
    init=CG2.init;
    init(5:6,1)=init(3:4,1)+init(5:6,1);
    init(3:4,1)=zeros(2,1);
    init(11:12,1)=init(9:10,1)+init(11:12,1);
    init(9:10,1)=zeros(2,1);
%fracinfect
    fracinfect.SR=0;
    fracinfect.DR=0;
    params.PopProportions=CG2.PopProportions;
    params.bio=CG2.bio;
    params.N=N;
    params.sigma=sigma;
    params.mu=CG2.mu;
    params.gamma=gamma;
    params.alpha=alpha;
    params.lambda=lambda;
    params.r=r;
    params.init=init;
    params.fracinfect=CG2.fracinfect;
    params.tspan=CG2.tspan;    
end

