function [dydt] = Chagas_Gen1_ODEs(t,y,params)
%Chagas_Gen1_ODEs Buils ODE function for Gen1 Chagas Model
%   t: current time (unused currently)
%   y: vector of y values for current time
%   params: struct of paramter values
%   Calls on: get_alpha(y,theta,p)


%Abridging parameter names
alpha=params.alpha;
lambda=params.lambda;
gamma=params.gamma;
ratio=params.ratio;

lambda.DH_SH=lambda.H;
lambda.SH_DH=lambda.H/ratio.SH_DH;
lambda.DV_SV=lambda.V;
lambda.SV_DV=lambda.V/ratio.SV_DV;

S_SH=y(1);
I_SH=y(2);
S_SV=y(3);
I_SV=y(4);
S_DH=y(5);
I_DH=y(6);
S_DV=y(7);
I_DV=y(8);

%
dydt=NaN(size(y));
     
     dydt(1)=gamma.SH*I_SH + lambda.DH_SH*S_DH - (alpha.SV_SH*I_SV/(S_SV+I_SV)+alpha.DV_SH*I_DV/(S_DV+I_DV))*S_SH...
         -lambda.SH_DH*S_SH;
     dydt(2)=-gamma.SH*I_SH +lambda.DH_SH*I_DH + (alpha.SV_SH*I_SV/(S_SV+I_SV)+alpha.DV_SH*I_DV/(S_DV+I_DV))*S_SH ...
         -lambda.SH_DH*I_SH;
     
     dydt(3)=gamma.SV*I_SV + lambda.DV_SV*S_DV - (alpha.SH_SV*I_SH/(S_SH+I_SH)+alpha.DH_SV*I_DH/(S_DH+I_DH))*S_SV...
         -lambda.SV_DV*S_SV;
     dydt(4)=-gamma.SV*I_SV+ lambda.DV_SV*I_DV + (alpha.SH_SV*I_SH/(S_SH+I_SH)+alpha.DH_SV*I_DH/(S_DH+I_DH))*S_SV...
         -lambda.SV_DV*I_SV;
     
     dydt(5)=gamma.DH*I_DH + lambda.SH_DH*S_SH - (alpha.SV_DH*I_SV/(S_SV+I_SV)+alpha.DV_DH*I_DV/(S_DV+I_DV))*S_DH...
         -lambda.DH_SH*S_DH;
     dydt(6)=-gamma.DH*I_DH+ lambda.SH_DH*I_SH + (alpha.SV_DH*I_SV/(S_SV+I_SV)+alpha.DV_DH*I_DV/(S_DV+I_DV))*S_DH...
         -lambda.DH_SH*I_DH; 
     
     dydt(7)=gamma.DV*I_DV + lambda.SV_DV*S_SV - (alpha.SH_DV*I_SH/(S_SH+I_SH)+alpha.DH_DV*I_DH/(S_DH+I_DH))*S_DV...
         -lambda.DV_SV*S_DV;
     dydt(8)=-gamma.DV*I_DV+ lambda.SV_DV*I_SV + (alpha.SH_DV*I_SH/(S_SH+I_SH)+alpha.DH_DV*I_DH/(S_DH+I_DH))*S_DV...
         -lambda.DV_SV*I_DV;  

end

