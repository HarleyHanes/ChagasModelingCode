function [params] = CG2toCG1params(CG2params)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Full=CG2params;
%ODE10=CG2toODE10params(CG2params);
 %c=ODE10.PopProportions.c;
 %d=ODE10.PopProportions.d;
 
 %Population Size
 N.SS=Full.N.SS; %SS becomes SH
 N.SV=Full.N.SV;
 N.SR=0;          %Rodents gone now
 
 N.DS=Full.N.DS+Full.N.DD; %DS+DD becomes DH
 N.DV=Full.N.DV;            
 N.DR=0;                    %Rodents gone now
 N.DD=0;                    %Dogs gone now
 
 n1=Full.N.DS;
 n2=Full.N.DD;
 g1=Full.gamma.DS;
 g2=Full.gamma.DD;
 g3=Full.gamma.DV;
 k1=(Full.alpha.DV_DS+Full.beta.DV_DS)*Full.N.DV;
 k2=(Full.alpha.DV_DD+Full.beta.DV_DD)*Full.N.DV;
 b1=Full.alpha.DS_DV*Full.N.DS;
 b2=Full.alpha.DD_DV*Full.N.DD;
 nuV=b1+b2+g3;
 nu1=k1+g1;
 nu2=k2+g2;
 gamma=Full.gamma;
 alpha=Full.alpha;
 beta=Full.beta;
 
 abba=((k1+k2)*(g2*(b1+g3)*k1-b2*k1^2 +g1*(b2+g3)*k2+(b1+2*b2+g3)*k1*k2))/(g3*k1*k2);
 
PredictedFullEquil=1/(2*k1*k2*nuV)*(-b1*k2*nu1-b2*k1*nu2+k2*nu1*nuV + ...
   k1*nu2*nuV+sqrt(4*k1*k2*nu1*nu2*(b1+b2-nuV)*nuV+(b1*k2*nu1+b2*k1*g2-(k2*nu1+k1*nu2)*nuV)^2));
 
PredictedApproxEquil=nu1/k1*(1-b1/nuV)+nu2/k2*(1-b2/nuV);
gamma.DS=((k1*n1+k2*n2)*((b1 + g3)*k1*(g2*(b1+g3)-b2*k1)*n1+(b1^2*k1+...
        g3*(b2+g3)*(g1+k1)+b1*(b2+g3)*(g1+2*k1))*k2*n1+(b2+g3)*k1*(g2*(b1+g3)-...
         b2*k1)*n2+(g1*(b2+g3)^2+b1*b2*k1+(b2+g3)*(2*b2+g3)*k1)*k2*n2))/(g3*(b1+b2+... 
     g3)*k1*k2*(n1+n2)^2);
alpha.DV_DS=(k1*n1+k2*n2)/(n1+n2);
beta.DV_DS=0;
alpha.DS_DV=(b1*n1+b2*n2)/(n1 + n2);

PredictedCompressedEquil=(gamma.DV*(gamma.DS+alpha.DV_DS))/((alpha.DS_DV +... 
   gamma.DS)*alpha.DV_DS);
fracinfect.SV=0;
fracinfect.SR=0;
fracinfect.SS=0;
fracinfect.DS=.01;
fracinfect.DR=0;
fracinfect.DD=0;
fracinfect.DV=0;
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
            
params.alpha=alpha;
params.beta=beta;
%params.bio=ODE10.bio;  %Passing the bio params straight through could create problems
params.N=N;
params.gamma=gamma;
params.lambda=Full.lambda;
params.b=Full.b;
params.r=Full.r;
params.init=init;
params.fracinfect=fracinfect;
params.tspan=Full.tspan;
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

