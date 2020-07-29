function [params] = CG2toCG1params(CG2params)
%CG2toCG1params Translates a set of 14 ODE params to 8 ODE params
%   Calls CG2toODE10params to get base set.
CG2=CG2params;
ODE10=CG2toODE10params(CG2params);
%fprintf('Loading Parameters for 8 ODE Model\n')
%Load Pop Proportions
     c=CG2.PopProportions.c;
     d=CG2.PopProportions.d;
     N.Humans=ODE10.N.Humans;
 %Population Size
     N.SR=ODE10.N.SR; %SR becomes SH
     N.SV=ODE10.N.SV;
     N.SS=0;          %synanthropes gone now

     N.DR=ODE10.N.DR+ODE10.N.DD; %DS+DD becomes DH
     N.DV=CG2.N.DV;            
     N.DS=0;                    %synanthropes gone now
     N.DD=0;                    %Dogs gone now
 %Recruitment Rates
    sigma.SS=0; sigma.DS=0; sigma.DD=0;
    sigma.SR=ODE10.sigma.SR;
    sigma.DR=ODE10.sigma.DR+ODE10.sigma.DD;
    sigma.SV=ODE10.sigma.SV;
    sigma.DV=ODE10.sigma.DV;
 %Death Rates
    gamma.SS=0;gamma.DS=0; gamma.DD=0; mu.DD=0;
    gamma.SR=ODE10.gamma.SR;
    gamma.SV=ODE10.gamma.SV;
    gamma.DR=ODE10.gamma.DR*c.DT_DH+ODE10.gamma.DD*c.DD_DH;
    gamma.DV=ODE10.gamma.DV;
    mu.DR=(ODE10.gamma.DR*c.DT_DH*d.DT+ODE10.gamma.DD*c.DD_DH*d.DD)/(c.DD_DH*d.DD+c.DT_DH*d.DT);
 %Host-->Vector transmission rates
    alpha.SS_SV=0; alpha.DS_DV=0;
    alpha.DD_DV=0;
    alpha.SR_SV=ODE10.alpha.SR_SV;
    alpha.DR_DV=(ODE10.alpha.DR_DV*d.DT+ODE10.alpha.DD_DV*d.DD)/(c.DD_DH*d.DT+c.DT_DH*d.DT);
 %Vector-->Host transmission rates
    alpha.SV_SS=0;alpha.DV_DS=0;
    alpha.DV_DD=0;
    alpha.SV_SR=ODE10.alpha.SV_SR;
    alpha.DV_DR=(ODE10.alpha.DV_DR*c.DT_DH*(1-d.DT)+ODE10.alpha.DV_DD*c.DD_DH*(1-d.DD))/(c.DT_DH*(1-d.DT)+c.DD_DH*(1-d.DD));
 %Movement rates
 %Vertical Transmission
    r.SR=ODE10.r.R;
    r.DR=(CG2.sigma.DR)/(sigma.DR)*(CG2.r.R*d.DR)/(d.DT*c.DT_DH+d.DD*c.DD_DH);
 %Initial COnditions
    init=ODE10.init;
    init(11:12,1)=init(13:14,1)+init(11:12,1);
    init(13:14,1)=zeros(2,1);
    
%Load Into Params Structure
CG2.fracinfect.DD=0;
params.bio=ODE10.bio;
params.PopProportions=CG2.PopProportions;
params.sigma=sigma;
params.alpha=alpha;
params.mu=mu;
params.N=N;
params.gamma=gamma;
params.lambda=CG2.lambda;
params.r=r;
params.init=init;
params.fracinfect=CG2.fracinfect;
params.tspan=CG2.tspan;
end

