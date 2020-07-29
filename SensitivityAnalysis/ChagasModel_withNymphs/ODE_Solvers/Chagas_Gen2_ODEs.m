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
epsilon=params.epsilon;
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
if ~isfield(r,'SR')||~isfield(r,'DR')
    r.SR=r.R;
    r.DR=r.R;
end


%% Movement Rates
%We compute lambda's in ODE so that we perserve their balance during
%sensitivity analysis because we can't change one without changing the
%other

lambda.DV_SV=lambda.V;
lambda.SV_DV=lambda.V*(N.DV/N.SV);   %Check this is correct

lambda.DS_SS=lambda.S;
lambda.SS_DS=lambda.S*(N.DS/N.SS);   %Check this is correct


lambda.DR_SR=lambda.R;
lambda.SR_DR=lambda.R*(N.DR/N.SR);   %Check this is correct


%% Population Sizes
%Sylvatic Vectors
S_SV=y(1);
I_SV=y(2);
N_SV=S_SV+I_SV;
%Sylvatic Synanthropes
S_SS=y(3);
I_SS=y(4);
N_SS=S_SS+I_SS;
%Sylvatic Rodents
S_SR=y(5);
I_SR=y(6);
N_SR=S_SR+I_SR;

%Peridomestic Vectors (Adult)
S_DV=y(7);
I_DV=y(8);
N_DV=S_DV+I_DV;
%Peridomestic Synanthropes
S_DS=y(9);
I_DS=y(10);
N_DS=S_DS+I_DS;
%Peridomestic Rodents
S_DR=y(11);
I_DR=y(12);
N_DR=S_DR+I_DR;
%Domestic Dogs
S_DD=y(13);
I_DD=y(14);
N_DD=S_DD+I_DD;

%Sylvatic Nymphs
S_SN=y(15);
I_SN=y(16);
N_SN=S_SN+I_SN;
%Peridomestic Nymphs
S_DN=y(17);
I_DN=y(18);
N_DN=S_DN+I_DN;

%% Infection Prevalences
p_SV=(I_SN+I_SV)/(N_SN+N_SV);
p_DV=(I_DN+I_DV)/(N_DN+N_DV);

p_SS=I_SS/N_SS;
p_DS=I_DS/N_DS;

p_SR=I_SR/N_SR;
p_DR=I_DR/N_DR;

p_DD=I_DD/N_DD;

%%  Compression Updated
if N_SR==0 && N_DR==0
    N_SR=10^(-18);
    N_DR=10^(-18);
end
if N_SS==0 && N_DS==0
    N_SS=10^(-18);
    N_DS=10^(-18);
end
if N_DD==0
    N_DD=10^(-18);
end


%
dydt=NaN(length(y),1);
     dydt(1)=epsilon.N*S_SN-(alpha.SS_SV*p_SS+alpha.SR_SV*p_SR)*S_SV+lambda.DV_SV*S_DV-lambda.SV_DV*S_SV-gamma.SV*S_SV;
     dydt(2)=epsilon.N*I_SN+(alpha.SS_SV*p_SS+alpha.SR_SV*p_SR)*S_SV+lambda.DV_SV*I_DV-lambda.SV_DV*I_SV-gamma.SV*I_SV;

     dydt(3)=sigma.SS-alpha.SV_SS*p_SV*S_SS+lambda.DS_SS*S_DS-lambda.SS_DS*S_SS-gamma.SS*S_SS;
     dydt(4)=alpha.SV_SS*p_SV*S_SS+lambda.DS_SS*I_DS-lambda.SS_DS*I_SS-gamma.SS*I_SS;
     
     dydt(5)=sigma.SR*(1-p_SR*r.SR)-alpha.SV_SR*p_SV*S_SR+lambda.DR_SR*S_DR-lambda.SR_DR*S_SR-gamma.SR*S_SR;
     dydt(6)=sigma.SR*p_SR*r.SR+alpha.SV_SR*p_SV*S_SR+lambda.DR_SR*I_DR-lambda.SR_DR*I_SR-gamma.SR*I_SR;
     
     dydt(7)=epsilon.N*S_DN-(alpha.DS_DV*p_DS+alpha.DR_DV*p_DR+alpha.DD_DV*p_DD)*S_DV+lambda.SV_DV*S_SV-lambda.DV_SV*S_DV-gamma.DV*S_DV;
     dydt(8)=epsilon.N*I_DN+(alpha.DS_DV*p_DS+alpha.DR_DV*p_DR+alpha.DD_DV*p_DD)*S_DV+lambda.SV_DV*I_SV-lambda.DV_SV*I_DV-gamma.DV*I_DV;

     dydt(9)=sigma.DS-alpha.DV_DS*p_DV*S_DS+lambda.SS_DS*S_SS-lambda.DS_SS*S_DS-gamma.DS*S_DS;
     dydt(10)=alpha.DV_DS*p_DV*S_DS+lambda.SS_DS*I_SS-lambda.DS_SS*I_DS-gamma.DS*I_DS;
     
     if N.DD==10^(-18)
         %If in 8ODE model, define mu.DR
         dydt(11)=sigma.DR*(1-r.DR*p_DR)-alpha.DV_DR*p_DV*S_DR+lambda.SR_DR*S_SR-lambda.DR_SR*S_DR-gamma.DR*S_DR;
         dydt(12)=sigma.DR*r.DR*p_DR+alpha.DV_DR*p_DV*S_DR+lambda.SR_DR*I_SR-lambda.DR_SR*I_DR-mu.DR*I_DR;
     else
         dydt(11)=sigma.DR*(1-r.DR*p_DR)-alpha.DV_DR*p_DV*S_DR+lambda.SR_DR*S_SR-lambda.DR_SR*S_DR-gamma.DR*S_DR;
         dydt(12)=sigma.DR*r.DR*p_DR+alpha.DV_DR*p_DV*S_DR*S_DR+lambda.SR_DR*I_SR-lambda.DR_SR*I_DR-gamma.DR*I_DR;
     end
     dydt(13)=sigma.DD-alpha.DV_DD*p_DV*S_DD-gamma.DD*S_DD;
     dydt(14)=alpha.DV_DD*p_DV*S_DD-mu.DD*I_DD;
     
     dydt(15)=sigma.SV-(alpha.SS_SV*p_SS+alpha.SR_SV*p_SR)*S_SN-(gamma.SN+epsilon.N)*S_SN;
     dydt(16)=(alpha.SS_SV*p_SS+alpha.SR_SV*p_SR)*S_SN-(gamma.SN+epsilon.N)*I_SN;
     
     dydt(17)=sigma.DV-(alpha.DS_DV*p_DS+alpha.DR_DV*p_DR+alpha.DD_DV*p_DD)*S_DN-(gamma.DN+epsilon.N)*S_DN;
     dydt(18)=(alpha.DS_DV*p_DS+alpha.DR_DV*p_DR+alpha.DD_DV*p_DD)*S_DN-(gamma.DN+epsilon.N)*I_DN;

if sum(isnan(dydt))~=0
    error('NaN derivative')
end

end

