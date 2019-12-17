function [params] = CG2toCG1params(CG2params,PopProportions)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
CG2beta=CG2params.beta;
CG2alpha=CG2params.alpha;
CG2gamma=CG2params.gamma;
CG2N=CG2params.N;
CG2b=CG2params.b;
CG2lambda=CG2params.lambda;

c=PopProportions.c;
d=PopProportions.d;
10ODEparams=CG2to10ODEparams(CG2params,PopProportions);

%Population Size
N.SH=CG2N.SS+CG2N.SR;
N.SV=CG2N.SV;

N.DH=CG2N.DS+CG2N.DR+CG2N.DD;
N.DV=CG2N.DV;

%Vector infection
alpha.SH_SV=10ODE.ST_SV;
alpha.DH_DV=10ODE.SV_ST;

%Host Infection
alpha.SV_SH=;
alpha.DV_DH=;

%Death Rates

b.SV=;
b.DV=;

gamma.SV=CG2gamma.SV;
gamma.SH=10ODE.gamma.ST;

gamma.DV=CG2gamma.DV;
gamma.DH=(CG2gamma.DD*c.DD_DH*d.DD+10ODE.gamma.DT*(1-c.DD-DH)*(c.DS_DT*d.DS+(1-c.DS_DT)*d.DR))...
    /(c.DD_DH*d.DD+(1-c.DD_DH)*(c.DS_DT*d.DS+(1-c.DS_DT)*d.DR));

lambda.SV_DV=;
lambda.DV_SV=;

lambda.SH_DH=;
lambda.DH_SH=;



%Reload params
params.alpha=alpha;
params.N=N;
params.gamma=gamma;
params.lambda=lamdba;
params.init=init;

end

