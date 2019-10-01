function dydt = Chagas_ODEs(t, y, params)
% Return time derivatives for a basic SIR model
%Reduce Parameter Names
theta=params.theta;
p=params.p;
lambda=params.lambda;
mu=params.mu;
gamma=params.gamma;
ratio=params.ratio;
%Hardcoded Relationships
lambda.DV_SV=lambda.SV_DV*ratio.SV_DV;
lambda.DT_ST=lambda.ST_DT*ratio.ST_DT;



%Set Up Matrices
%Derive alpha
     alpha=get_alpha(y,theta,p);
% Calculate the time derivatives '
A=[-(alpha.ST_SV+alpha.DT_SV+lambda.SV_DV), mu.SV, 0, 0, lambda.DV_SV, 0, 0, 0;
         alpha.ST_SV+alpha.DT_SV, -(mu.SV+lambda.SV_DV), 0, 0, 0, lambda.DV_SV, 0, 0;
         0, 0, -(alpha.SV_ST+alpha.DV_ST)-lambda.ST_DT, mu.ST, 0, 0, lambda.DT_ST,0;
         0, 0, alpha.SV_ST+alpha.DV_ST, -(mu.ST+lambda.ST_DT), 0, 0, 0, lambda.DT_ST;
         lambda.SV_DV, 0, 0, 0, -(alpha.ST_DV+alpha.DT_DV)-lambda.DV_SV, mu.DV, 0, 0;
         0, lambda.SV_DV, 0, 0, (alpha.ST_DV+alpha.DT_DV), -(mu.DV+lambda.DV_SV), 0, 0;
         0, 0, lambda.ST_DT, 0, 0, 0, -(alpha.SV_DT+alpha.DV_DT)-lambda.DT_ST, mu.DT;
         0, 0, 0, lambda.ST_DT, 0, 0, (alpha.SV_DT+alpha.DV_DT), -(mu.DT+lambda.DT_ST)];
    dydt=A*y;
%      alpha=get_alpha(y,theta,p);
%      yt(1)=mu.SV*(y(1)+y(2)) + lambda.DV_SV*y(5) - (alpha.ST_SV+alpha.DT_SV)*y(1)...
%          -(mu.SV+lambda.SV_DV)*y(1);
%      yt(2)=(alpha.ST_SV+alpha.DT_SV)*y(1) + lambda.DV_SV*y(6)...
%          -(mu.SV+lambda.SV_DV)*y(2);
%      yt(3)=mu.ST*(y(3)+y(4)) + lambda.DT_ST*y(7)- (alpha.SV_ST+alpha.DV_ST)*y(3)...
%          -(mu.ST+lambda.ST_DT)*y(3);
%      yt(4)=(alpha.SV_ST+alpha.DV_ST)*y(3)+ lambda.DT_ST*y(8)...
%          -(mu.ST+lambda.ST_DT)*y(4);
%      yt(5)=mu.DV*(y(5)+y(6)) + lambda.SV_DV*y(1) - (alpha.ST_DV+alpha.DT_DV)*y(5)...
%          -(mu.DV+lambda.DV_SV)*y(5);
%      yt(6)=(alpha.ST_DV+alpha.DT_DV)*y(5) + lambda.SV_DV*y(2)...
%          -(mu.DV+lambda.DV_SV)*y(6); 
%      yt(7)=mu.DT*(y(7)+y(8)) + lambda.ST_DT*y(3) -(alpha.SV_DT+alpha.DV_DT)*y(7)...
%          - (mu.DT+lambda.DT_ST)*y(7);
%      yt(8)= (alpha.SV_DT+alpha.DV_DT)*y(7)+ lambda.ST_DT*y(4)...
%          - (mu.DT+lambda.DT_ST)*y(8);
%  %Adjust to be percentages
%      dydt(1)=yt(1)/(yt(1)+yt(2));
%      dydt(2)=yt(2)/(yt(1)+yt(2));
%      dydt(3)=yt(3)/(yt(3)+yt(4));
%      dydt(4)=yt(4)/(yt(3)+yt(4));
%      dydt(5)=yt(5)/(yt(5)+yt(6));
%      dydt(6)=yt(6)/(yt(5)+yt(6));
%      dydt(7)=yt(7)/(yt(7)+yt(8));
%      dydt(8)=yt(8)/(yt(7)+yt(8));
     
% repack the derivatives to mnemonic variables

end