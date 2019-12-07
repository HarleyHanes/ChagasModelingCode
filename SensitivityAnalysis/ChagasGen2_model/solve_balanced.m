function [soln_all] = solve_balanced(params)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%Load Initial Conditions
yf=params.init(1:8);

%Balancing
% tmax=2000;
% [model_fn, event_fn] = make_chagas_model(params);
% options = odeset('Events',event_fn);
% bal_soln = session.solver(model_fn, [0 tmax]);
% if numel(bal_soln.ie) == 0
%     warning('Could not balance the compartments. Check R0?')
%     keyboard
% end
%% Jessi uses balncing because she is testing intervention introduction
%% So she creates a stable population based on initial conditions
%% and then disrupts it but that is not what we're doing. 
model_fn = @(t,y) Chagas_Gen1_ODEs(t, y, params);
tspan=params.tspan;

[soln.x,soln.y]=ode45(model_fn, tspan, yf);
%soln.y(:,7)=soln.y(:,1)./(soln.y(:,1)+soln.y(:,2));
%soln.y(:,8)=soln.y(:,2)./(soln.y(:,1)+soln.y(:,2));
%soln.y(:,9)=soln.y(:,3)./(soln.y(:,3)+soln.y(:,4));
%soln.y(:,10)=soln.y(:,4)./(soln.y(:,3)+soln.y(:,4));
%soln.y(:,11)=soln.y(:,5)./(soln.y(:,5)+soln.y(:,6));
%soln.y(:,12)=soln.y(:,6)./(soln.y(:,5)+soln.y(:,6));
% soln.y(7,:)=soln.y(1,:)./(soln.y(1,:)+soln.y(2,:));
% soln.y(8,:)=soln.y(2,:)./(soln.y(1,:)+soln.y(2,:));
% soln.y(9,:)=soln.y(3,:)./(soln.y(3,:)+soln.y(4,:));
% soln.y(10,:)=soln.y(4,:)./(soln.y(3,:)+soln.y(4,:));
% soln.y(11,:)=soln.y(5,:)./(soln.y(5,:)+soln.y(6,:));
% soln.y(12,:)=soln.y(6,:)./(soln.y(7,:)+soln.y(8,:));
soln_all.x=soln.x;
soln_all.y=soln.y;


end

