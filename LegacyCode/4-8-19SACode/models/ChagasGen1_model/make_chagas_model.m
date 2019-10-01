function [model_fn, event_fn] = make_chagas_model(params)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%% Shorten names of parameter sets
theta=params.theta;
p=params.p;
lambda=params.lambda;
mu=params.mu;
gamma=params.gamma;
%% I don't know what this is but I am keeping it
model_fn=@chagas_model;
event_fn=@frac_infected_event;
    function dydt = chagas_model(t,y)
         dydt=NaN(size(y));
         alpha=get_alpha(y,theta,p);
%      dydt(1)=mu.SV*(y(1)+y(2)) + lambda.DV_SV*y(5) - (alpha.ST_SV+alpha.DT_SV)*y(1)...
%          -(gamma.SV+lambda.SV_DV)*y(1);
%      dydt(2)=(alpha.ST_SV+alpha.DT_SV)*y(1) + lambda.DV_SV*y(6)...
%          -(gamma.SV+lambda.SV_DV)*y(2);
%      dydt(3)=mu.ST*(y(3)+y(4)) + lambda.DT_ST*y(7)- (alpha.SV_ST+alpha.DV_ST)*y(3)...
%          -(gamma.ST+lambda.ST_DT)*y(3);
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
A=[mu.SV-(alpha.ST_SV+alpha.DT_SV+gamma.SV+lambda.SV_DV), mu.SV, 0, 0, lambda.DV_SV, 0, 0, 0;
         alpha.ST_SV+alpha.DT_SV, -(gamma.SV+lambda.SV_DV), 0, 0, 0, lambda.DV_SV, 0, 0;
         0, 0, mu.ST-(alpha.SV_ST+alpha.DV_ST)-(gamma.ST+lambda.ST_DT), mu.ST, 0, 0, lambda.DT_ST,0;
         0, 0, alpha.SV_ST+alpha.DV_ST, -(gamma.ST+lambda.ST_DT), 0, 0, 0, lambda.DT_ST;
         lambda.SV_DV, 0, 0, 0, mu.DV-(alpha.ST_DV+alpha.DT_DV)-(gamma.DV+lambda.DV_SV), mu.DV, 0, 0;
         0, lambda.SV_DV, 0, 0, (alpha.ST_DV+alpha.DT_DV), -(gamma.DV+lambda.DV_SV), 0, 0;
         0, 0, lambda.ST_DT, 0, 0, 0, mu.DT-(alpha.SV_DT+alpha.DV_DT)-(gamma.DT+lambda.DT_ST), mu.DT;
         0, 0, 0, lambda.ST_DT, 0, 0, (alpha.SV_DT+alpha.DV_DT), -(gamma.DT+lambda.DT_ST)];
    dydt=A*y;
    end
            

end

