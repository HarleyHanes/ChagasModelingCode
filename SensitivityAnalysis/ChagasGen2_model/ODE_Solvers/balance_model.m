function [new_init] = balance_model(init, params)

balance_init = init;
balance_init(2:2:length(init))=.01*balance_init(2:2:length(init)); %Set all infectous compartments to .0001
% for i=1:2:7
%     balance_init(i)=init(i)+init(i+1)-balance_init(i+1);
% end

options = odeset('Events',@(t,Y)balancing_event(t, Y, init));

t_balance = 100000; % how long we're willing to wait to balance
dydt_fn = @(t,y) Chagas_Gen2_ODEs(t, y, params);
Y = ode45(dydt_fn, [0 t_balance], balance_init, options);
new_init = Y.y(:,end);
end