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
ratio=params.ratio;

lambda.DH_SH=lambda.H;
lambda.SH_DH=lambda.H/ratio.SH_DH;
lambda.DV_SV=lambda.V;
lambda.SV_DV=lambda.V/ratio.SV_DV;

%
dydt=NaN(size(y));
alpha=get_alpha(y,theta,p);

     dydt(1)=mu.SH*(y(1)+y(2)) + lambda.DH_SH*y(5) - (alpha.SV_SH+alpha.DV_SH)*y(1)...
         -(mu.SH+lambda.SH_DH)*y(1);
     dydt(2)=(alpha.SV_SH+alpha.DV_SH)*y(1)+ lambda.DH_SH*y(6)...
         -(mu.SH+lambda.SH_DH)*y(2);
     
     dydt(3)=mu.SV*(y(3)+y(4)) + lambda.DV_SV*y(7)- (alpha.SH_SV+alpha.DH_SV)*y(3)...
         -(mu.SV+lambda.SV_DV)*y(3);
     dydt(4)=(alpha.SH_SV+alpha.DH_SV)*y(3) + lambda.DV_SV*y(8)...
         -(mu.SV+lambda.SV_DV)*y(4);
     
     dydt(5)=mu.DH*(y(5)+y(6)) + lambda.SH_DH*y(1) - (alpha.SV_DH+alpha.DV_DH)*y(5)...
         -(mu.DH+lambda.DH_SH)*y(5);
     dydt(6)=(alpha.SV_DH+alpha.DV_DH)*y(5) + lambda.SH_DH*y(2)...
         -(mu.DH+lambda.DH_SH)*y(6); 
     
     dydt(7)=mu.DV*(y(7)+y(8)) + lambda.SV_DV*y(3) -(alpha.SH_DV+alpha.DH_DV)*y(7)...
         -(mu.DV+lambda.DV_SV)*y(7);
     dydt(8)= (alpha.SH_DV+alpha.DH_DV)*y(7)+ lambda.SV_DV*y(4)...
         -(mu.DV+lambda.DV_SV)*y(8);  
% A=[mu.SH-(alpha.SV_SH+alpha.DV_SH+gamma.SH+lambda.SH_DH), mu.SH, 0, 0, lambda.DH_SH, 0, 0, 0;
%          alpha.SV_SH+alpha.DV_SH, -(gamma.SH+lambda.SH_DH), 0, 0, 0, lambda.DH_SH, 0, 0;
%          0, 0, mu.SV-(alpha.SH_SV+alpha.DH_SV)-(gamma.SV+lambda.SV_DV), mu.SV, 0, 0, lambda.DV_SV,0;
%          0, 0, alpha.SH_SV+alpha.DH_SV, -(gamma.SV+lambda.SV_DV), 0, 0, 0, lambda.DV_SV;
%          lambda.SH_DH, 0, 0, 0, mu.DH-(alpha.SV_DH+alpha.DV_DH)-(gamma.DH+lambda.DH_SH), mu.DH, 0, 0;
%          0, lambda.SH_DH, 0, 0, (alpha.SV_DH+alpha.DV_DH), -(gamma.DH+lambda.DH_SH), 0, 0;
%          0, 0, lambda.SV_DV, 0, 0, 0, mu.DV-(alpha.SH_DV+alpha.DH_DV)-(gamma.DV+lambda.DV_SV), mu.DV;
%          0, 0, 0, lambda.SV_DV, 0, 0, (alpha.SH_DV+alpha.DH_DV), -(gamma.DV+lambda.DV_SV)];
%     dydt=A*y;
end

