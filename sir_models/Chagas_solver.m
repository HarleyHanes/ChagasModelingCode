function [tsol, ysol] = Chagas_solver(POIs, yzero, tspan)
% solve the ODE system of equations for an SIR model

beta = POIs(1);
gamma = POIs(2);

% define the function handle
dydt_fn = @(t,y) SIR_ODEs(t, y, beta, gamma);

% Solve ODE
[tsol, ysol] = ode45(dydt_fn, tspan, yzero);

end