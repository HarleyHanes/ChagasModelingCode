function [dydt] = Chagas_Gen2_ODEs(t,y,params)
%Chagas_Gen2_ODEs Buils ODE function for Gen1 Chagas Model
%   t: current time (unused currently)
%   y: vector of y values for current time
%   params: struct of paramter values
%   Calls on: get_alpha(y,theta,p)


%Abridging parameter names
N=params.N;
gamma=params.gamma;
sigma=params.sigma;
mu=params.mu;
alpha=params.alpha;
lambda=params.lambda;
r=params.r;

% Compression Updated
if N.SR==0 && N.DR==0
    if y(5)~=0||y(6)~=0||y(11)~=0||y(12)~=0
        error('N.SR or N.DR set at 0 but infected or susceptible comparments are not')
    end
    N.SR=10^(-18);
    N.DR=10^(-18);
end
if N.SS==0 && N.DS==0
    if y(3)~=0||y(4)~=0||y(9)~=0||y(10)~=0
        error('N.SS or N.DS set at 0 but infected or susceptible comparments are not')
    end
    N.SS=10^(-18);
    N.DS=10^(-18);
end
if N.DD==0
    if y(13)~=0||y(14)~=0
        error('N.SS or N.DS set at 0 but infected or susceptible comparments are not')
    end
    N.DD=10^(-18);
end
if ~isfield(r.SR)||~isfield(r.DR)
    r.SR=r.R;
    r.DR=r.R;
end

%Redefine b's in case beta is in sensitivity analysis


%We compute lambda's in ODE so that we perserve their balance during
%sensitivity analysis because we can't change one without changing the
%other
lambda.DV_SV=lambda.V;
lambda.SV_DV=lambda.V*(N.DV/N.SV);   %Check this is correct

lambda.DS_SS=lambda.S;
lambda.SS_DS=lambda.S*(N.DS/N.SS);   %Check this is correct

lambda.DR_SR=lambda.R;
lambda.SR_DR=lambda.R*(N.DR/N.SR);   %Check this is correct

S_SV=y(1);
I_SV=y(2);
S_SS=y(3);
I_SS=y(4);
S_SR=y(5);
I_SR=y(6);

S_DV=y(7);
I_DV=y(8);
S_DS=y(9);
I_DS=y(10);
S_DR=y(11);
I_DR=y(12);
S_DD=y(13);
I_DD=y(14);


%
dydt=NaN(length(y),1);
     dydt(1)=sigma.SV-(alpha.SS_SV*I_SS/(y(3)+y(4))+alpha.SR_SV*(I_SR/(y(5)+y(6))))*S_SV+lambda.DV_SV*S_DV-lambda.SV_DV*S_SV-gamma.SV*S_SV;
     dydt(2)=(alpha.SS_SV*I_SS/(y(3)+y(4))+alpha.SR_SV*(I_SR/(y(5)+y(6))))*S_SV+lambda.DV_SV*I_DV-lambda.SV_DV*I_SV-gamma.SV*I_SV;

     dydt(3)=sigma.SS-(alpha.SV_SS)*(I_SV/(y(1)+y(2)))*S_SS+lambda.DS_SS*S_DS-lambda.SS_DS*S_SS-gamma.SS*S_SS;
     dydt(4)=alpha.SV_SS*(I_SV/(y(1)+y(2)))*S_SS+lambda.DS_SS*I_DS-lambda.SS_DS*I_SS-gamma.SS*I_SS;
     
     dydt(5)=sigma.SR*(1-y(6)/(y(5)+y(6))*r.SR)-alpha.SV_SR*(I_SV/(y(1)+y(2)))*S_SR+lambda.DR_SR*S_DR-lambda.SR_DR*S_SR-gamma.SR*S_SR;
     dydt(6)=sigma.SR*y(6)/(y(5)+y(6))*r.SR+alpha.SV_SR*(I_SV/(y(1)+y(2)))*S_SR+lambda.DR_SR*I_DR-lambda.SR_DR*I_SR-gamma.SR*I_SR;
     
     dydt(7)=sigma.DV-(alpha.DS_DV*(I_DS/(y(9)+y(10)))+alpha.DR_DV*(I_DR/(y(11)+y(12)))+alpha.DD_DV*(I_DD/(y(13)+y(14))))*S_DV+lambda.SV_DV*S_SV-lambda.DV_SV*S_DV-gamma.DV*S_DV;
     dydt(8)=(alpha.DS_DV*(I_DS/(y(9)+y(10)))+alpha.DR_DV*(I_DR/(y(11)+y(12)))+alpha.DD_DV*(I_DD/(y(13)+y(14))))*S_DV+lambda.SV_DV*I_SV-lambda.DV_SV*I_DV-gamma.DV*I_DV;

     dydt(9)=sigma.DS-(alpha.DV_DS)*(I_DV/(y(7)+y(8)))*S_DS+lambda.SS_DS*S_SS-lambda.DS_SS*S_DS-gamma.DS*S_DS;
     dydt(10)=(alpha.DV_DS)*(I_DV/(y(7)+y(8)))*S_DS+lambda.SS_DS*I_SS-lambda.DS_SS*I_DS-gamma.DS*I_DS;
     
     dydt(11)=sigma.DR*(1-r.DR*y(12)/(y(11)+y(12)))-(alpha.DV_DR)*(I_DV/(y(7)+y(8)))*S_DR+lambda.SR_DR*S_SR-lambda.DR_SR*S_DR-gamma.DR*S_DR;
     dydt(12)=sigma.DR*r.DR*y(12)/(y(11)+y(12))+(alpha.DV_DR)*(I_DV/(y(7)+y(8)))*S_DR+lambda.SR_DR*I_SR-lambda.DR_SR*I_DR-gamma.DR*I_DR;
     
     dydt(13)=sigma.DD-alpha.DV_DD*(I_DV/(y(7)+y(8)))*S_DD-gamma.DD*S_DD;
     dydt(14)=alpha.DV_DD*(I_DV/(y(7)+y(8)))*S_DD-mu.DD*I_DD;

end

