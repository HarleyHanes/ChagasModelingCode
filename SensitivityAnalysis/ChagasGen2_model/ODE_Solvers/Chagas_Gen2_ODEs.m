function [dydt] = Chagas_Gen2_ODEs(t,y,params)
%Chagas_Gen2_ODEs Buils ODE function for Gen1 Chagas Model
%   t: current time (unused currently)
%   y: vector of y values for current time
%   params: struct of paramter values
%   Calls on: get_alpha(y,theta,p)


%Abridging parameter names
N=params.N;
b=params.b;
gamma=params.gamma;
alpha=params.alpha;
beta=params.beta;
lambda=params.lambda;
r=params.r;

%We compute lambda's in ODE so that we perserve their balance during
%sensitivity analysis because we can't change one without changing the
%other
lambda.DV_SV=lambda.V;
lambda.SV_DV=lambda.V*(N.SV/N.DV);   %Check this is correct

lambda.DS_SS=lambda.S;
lambda.SS_DS=lambda.S*(N.SS/N.DS);   %Check this is correct

lambda.DR_SR=lambda.R;
lambda.SR_DR=lambda.R*(N.SR/N.DR);   %Check this is correct

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
     dydt(1)=gamma.SV*I_SV-(alpha.SS_SV*(I_SS/N.SS)+alpha.SR_SV*(I_SR/N.SR))*S_SV+(b.SS*N.SS+b.SR*N.SR)*(I_SV/N.SV)+lambda.DV_SV*S_DV-lambda.SV_DV*S_SV;
     dydt(2)=-gamma.SV*I_SV+(alpha.SS_SV*(I_SS/N.SS)+alpha.SR_SV*(I_SR/N.SR))*S_SV-(b.SS*N.SS+b.SR*N.SR)*(I_SV/N.SV)+lambda.DV_SV*I_DV-lambda.SV_DV*I_SV;

     dydt(3)=gamma.SS*I_SS-(alpha.SV_SS+beta.SV_SS)*(I_SV/N.SV)*S_SS+lambda.DS_SS*S_DS-lambda.SS_DS*S_SS;
     dydt(4)=-gamma.SS*I_SS+(alpha.SV_SS+beta.SV_SS)*(I_SV/N.SV)*S_SS+lambda.DS_SS*I_DS-lambda.SS_DS*I_SS;
     
     dydt(5)=gamma.SR*(1-r.R)*I_SR-(alpha.SV_SR+beta.SV_SR)*(I_SV/N.SV)*S_SR+lambda.DR_SR*S_DR-lambda.SR_DR*S_SR;
     dydt(6)=-gamma.SR*(1-r.R)*I_SR+(alpha.SV_SR+beta.SV_SR)*(I_SV/N.SV)*S_SR+lambda.DR_SR*I_DR-lambda.SR_DR*I_SR;
     
     dydt(7)=gamma.DV*I_DV-(alpha.DS_DV*(I_DS/N.DS)+alpha.DR_DV*(I_DR/N.DR)+alpha.DD_DV*(I_DD/N.DD))*S_DV+(b.DS*N.DS+b.DR*N.DR+b.DD*N.DD)*(I_DV/N.DV)+lambda.SV_DV*S_SV-lambda.DV_SV*S_DV;
     dydt(8)=-gamma.DV*I_DV+(alpha.DS_DV*(I_DS/N.DS)+alpha.DR_DV*(I_DR/N.DR)+alpha.DD_DV*(I_DD/N.DD))*S_DV-(b.DS*N.DS+b.DR*N.DR+b.DD*N.DD)*(I_DV/N.DV)+lambda.SV_DV*I_SV-lambda.DV_SV*I_DV;

     dydt(9)=gamma.DS*I_DS-(alpha.DV_DS+beta.DV_DS)*(I_DV/N.DV)*S_DS+lambda.SS_DS*S_SS-lambda.DS_SS*S_DS;
     dydt(10)=-gamma.DS*I_DS+(alpha.DV_DS+beta.DV_DS)*(I_DV/N.DV)*S_DS+lambda.SS_DS*I_SS-lambda.DS_SS*I_DS;
     
     dydt(11)=gamma.DR*(1-r.R)*I_DR-(alpha.DV_DR+beta.DV_DR)*(I_DV/N.DV)*S_DR+lambda.SR_DR*S_SR-lambda.DR_SR*S_DR;
     dydt(12)=-gamma.DR*(1-r.R)*I_DR+(alpha.DV_DR+beta.DV_DR)*(I_DV/N.DV)*S_DR+lambda.SR_DR*I_SR-lambda.DR_SR*I_DR;
     
     dydt(13)=gamma.DD*I_DD-(alpha.DV_DD+beta.DV_DD)*(I_DV/N.DV)*S_DD;
     dydt(14)=-gamma.DD*I_DD+(alpha.DV_DD+beta.DV_DD)*(I_DV/N.DV)*S_DD;
end

