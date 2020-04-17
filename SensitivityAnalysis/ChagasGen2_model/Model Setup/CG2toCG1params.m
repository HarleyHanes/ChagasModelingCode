function [params] = CG2toCG1params(CG2params)
%CG2toCG1params Translates a set of 14 ODE params to 8 ODE params
%   Calls CG2toODE10params to get base set.
CG2=CG2params;
ODE10=CG2toODE10params(CG2params);
%Load Pop Proportions
     c=CG2.PopProportions.c;
     d=CG2.PopProportions.d;
 
 %Population Size
     N.SR=ODE10.N.SR; %SR becomes SH
     N.SV=ODE10.N.SV;
     N.SS=0;          %synanthropes gone now

     N.DR=ODE10.N.DR+ODE10.N.DD; %DS+DD becomes DH
     N.DV=CG2.N.DV;            
     N.DS=0;                    %synanthropes gone now
     N.DD=0;                    %Dogs gone now
 %Recruitment Rates
    sigma.SR=ODE10.sigma.SR;
    sigma.DR=ODE10.sigma.DR+ODE10.sigma.DD;
    sigma.SV=ODE10.sigma.SV;
    sigma.DV=ODE10.sigma.DV;
 %Death Rates
    gamma.SR=ODE10.gamma.SR;
    gamma.SV=ODE10.gamma.SV;
    gamma.DR=ODE10.gamma.DR*c.DT_DH+ODE10.gamma.DD*c.DD_DH;
    gamma.DV=ODE10.gamma.DV;
 %Host-->Vector transmission rates
    alpha.SR_SV=ODE10.alpha.SR_SV;
    alpha.DR_DV=(alpha.DR_DV*d.DT+alpha.DD_DV*d.DD)/(c.DD_DH*d.DH+c.DT_DH*d.DT);
 %Vector-->Host transmission rates
    alpha.SV_SR=ODE10.alpha.SV_SR;
    alpha.DV_DR=(alpha.DV_DR*c.DT_DH*(1-d.DT)+alpha.DV_DD*c.DD_DH*(1-d.DD))/(c.DT_DH*(1-d.DT)+c.DD_DH*(1-d.DD));
 %Movement rates
 %Vertical Transmission
    r.SR=ODE10.r.R;
    r.DR=(CG2.sigma.DR)/(sigma.DR)*(CG2.r.R*d.DR)/(d.DT*c.DT_DH+d.DD*c.DD_DH);
 %Initial COnditions
    init=ODE10.init;
    init(11:12,1)=init(13:14,1)+init(11:12,1);
    
    
%Load Into Params Structure
params.PopProportions=CG2.PopProportions;
params.sigma=sigma;
params.alpha=alpha;
params.N=N;
params.gamma=gamma;
params.lambda=CG2.lambda;
params.r=r;
params.init=init;
params.fracinfect=CG2.fracinfect;
params.tspan=CG2.tspan;
keyboard
%% Everything Below is actual code which we are temporarily ignoring to test algebraic compression
% c=ODE10.PopProportions.c;
% d=ODE10.PopProportions.d;
% 
% %Population Size
% N.SS=ODE10.N.SS;
% N.SV=ODE10.N.SV;
% N.SR=0;
% 
% N.DS=ODE10.N.DS+ODE10.N.DD;
% N.DV=ODE10.N.DV;
% N.DR=0;
% N.DD=0;
% 
% %Vector infection
% alpha.SS_SV=ODE10.alpha.SS_SV;
% alpha.DS_DV=(ODE10.alpha.DS_DV*(c.DS_DT*d.DS+c.DS_DT*d.DR)+ODE10.alpha.DD_DV*d.DD)...
%     /(c.DD_DH*d.DS+(1-c.DD_DH)*(c.DS_DT*d.DS+c.DS_DT*d.DR));
% 
% alpha.SR_SV=0;
% alpha.DR_DV=0;
% alpha.DD_DV=0;
% 
% %Host Infection
% alpha.SV_SS=ODE10.alpha.SV_SS;
% alpha.DV_DS=((ODE10.alpha.DV_DD+ODE10.beta.DV_DD)*c.DD_DH*(1-d.DD)+ODE10.alpha.DV_DS*(1-c.DD_DH)*(1-(c.DS_DT*d.DS+(1-c.DS_DT)*d.DR)))...
%     /(c.DD_DH*(1-d.DD)+(1-c.DD_DH)*(1-(c.DS_DT*d.DS+(1-c.DS_DT)*d.DR)));
% 
% alpha.SV_SR=0;
% alpha.DV_DR=0;
% alpha.DV_DD=0;
% 
% 
% beta.SV_SS=0;
% beta.DV_DS=0;
% beta.SV_SR=0;
% beta.DV_DR=0;
% beta.DV_DD=0;
% %Death Rates
% 
% %vectors
%     b.SS=ODE10.b.SS;
%     b.DS=ODE10.b.DS*(1-c.DD_DH)+ODE10.b.DD*c.DD_DH;
% 
%     b.SR=0;
%     b.DR=0;
%     b.DD=0;
% 
%     gamma.SV=ODE10.gamma.SV;
%     gamma.DV=ODE10.gamma.DV;
% %Hosts
% gamma.SS=ODE10.gamma.SS;
% gamma.DS=(ODE10.gamma.DD*c.DD_DH*d.DD+ODE10.gamma.DS*(1-c.DD_DH)*(c.DS_DT*d.DS+(1-c.DS_DT)*d.DR))...
%     /(c.DD_DH*d.DD+(1-c.DD_DH)*(c.DS_DT*d.DS+(1-c.DS_DT)*d.DR));
% 
% gamma.SR=0;
% gamma.DR=0;
% gamma.DD=0;
% 
% %movement rates
% lambda.V=ODE10.lambda.V;
% lambda.S=ODE10.lambda.S;
% lambda.R=ODE10.lambda.R;
% 
% %Depricated params
% r.R=0;
% 
% %inits
% init=ODE10.init;
% 
% init(9:10,1)=init(9:10,1)+init(13:14,1);
% init(13:14,1)=zeros(2,1);
% 
% fracinfect=ODE10.fracinfect;
% fracinfect.DD=0;
% 
% 
% 
% %Reload params
% params.PopProportions=ODE10.PopProportions;
% params.alpha=alpha;
% params.beta=beta;
% params.bio=ODE10.bio;  %Passing the bio params straight through could create problems
% params.N=N;
% params.gamma=gamma;
% params.lambda=lambda;
% params.b=b;
% params.r=r;
% params.init=init;
% params.fracinfect=fracinfect;
% params.tspan=ODE10.tspan;

end

