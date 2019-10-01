function [dydt] = Chagas_Gen1_ODEs(t,y,params)
%Chagas_Gen1_ODEs Buils ODE function for Gen1 Chagas Model
%   t: current time (unused currently)
%   y: vector of y values for current time
%   params: struct of paramter values
%   Calls on: get_alpha(y,theta,p)


%Abridging parameter names
theta=params.theta;
p=params.p;
lambda=params.lambda;
mu=params.mu;
gamma=params.gamma;
ratio=params.ratio;

lambda.DH_SH=lambda.H;
lambda.SH_DH=lambda.H/ratio.SH_DH;
lambda.DV_SV=lambda.V;
lambda.SV_DV=lambda.V/ratio.SV_DV;
%
dydt=NaN(size(y));
alpha=get_alpha(y,theta,p);
%      dydt(1)=mu.SV*(y(1)+y(2)) + lambda.DV_SV*y(5) - (alpha.ST_SV*y(4)/(y(3)+y(4))+...
%          alpha.DT_SV*y(8)/(y(7)+y(8)))*y(1)-(gamma.SV+lambda.SV_DV)*y(1);
%      dydt(2)=(alpha.ST_SV*y(4)/(y(3)+y(4))+alpha.DT_SV*y(8)/(y(7)+y(8)))*y(1)...
%          + lambda.DV_SV*y(6)-(gamma.SV+lambda.SV_DV)*y(2);
%      dydt(3)=mu.ST*(y(3)+y(4)) + lambda.DT_ST*y(7)- (alpha.SV_ST*y(2)/(y(1)+y(2))+...
%          alpha.DV_ST*y(6)/(y(5)+y(6)))*y(3)-(gamma.ST+lambda.ST_DT)*y(3);
%      dydt(4)=(alpha.SV_ST+alpha.DV_ST)*y(3)+ lambda.DT_ST*y(8)...
%           -(gamma.ST+lambda.ST_DT)*y(4);
%      dydt(5)=mu.DV*(y(5)+y(6)) + lambda.SV_DV*y(1) - (alpha.ST_DV+alpha.DT_DV)*y(5)...
%           -(gamma.DV+lambda.DV_SV)*y(5);
%      dydt(6)=(alpha.ST_DV+alpha.DT_DV)*y(5) + lambda.SV_DV*y(2)...
%           -(gamma.DV+lambda.DV_SV)*y(6); 
%      dydt(7)=mu.DT*(y(7)+y(8)) + lambda.ST_DT*y(3) -(alpha.SV_DT+alpha.DV_DT)*y(7)...
%           - (gamma.DT+lambda.DT_ST)*y(7);
%      dydt(8)= (alpha.SV_DT+alpha.DV_DT)*y(7)+ lambda.ST_DT*y(4)...
%           -(gamma.DT+lambda.DT_ST)*y(8);  
A=[mu.SH-(alpha.SV_SH+alpha.DV_SH+gamma.SH+lambda.SH_DH), mu.SH, 0, 0, lambda.DH_SH, 0, 0, 0;
         alpha.SV_SH+alpha.DV_SH, -(gamma.SH+lambda.SH_DH), 0, 0, 0, lambda.DH_SH, 0, 0;
         0, 0, mu.SV-(alpha.SH_SV+alpha.DH_SV)-(gamma.SV+lambda.SV_DV), mu.SV, 0, 0, lambda.DV_SV,0;
         0, 0, alpha.SH_SV+alpha.DH_SV, -(gamma.SV+lambda.SV_DV), 0, 0, 0, lambda.DV_SV;
         lambda.SH_DH, 0, 0, 0, mu.DH-(alpha.SV_DH+alpha.DV_DH)-(gamma.DH+lambda.DH_SH), mu.DH, 0, 0;
         0, lambda.SH_DH, 0, 0, (alpha.SV_DH+alpha.DV_DH), -(gamma.DH+lambda.DH_SH), 0, 0;
         0, 0, lambda.SV_DV, 0, 0, 0, mu.DV-(alpha.SH_DV+alpha.DH_DV)-(gamma.DV+lambda.DV_SV), mu.DV;
         0, 0, 0, lambda.SV_DV, 0, 0, (alpha.SH_DV+alpha.DH_DV), -(gamma.DV+lambda.DV_SV)];
    dydt=A*y;
end

