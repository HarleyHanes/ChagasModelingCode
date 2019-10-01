function [params] = baseline_params
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%% Parameters (all time components need to be in days)
%Pop proportion
%Doesn't leave function but determines popsizes and movement rates
ratio.SH_DH=5;          %Assumed;
ratio.SV_DV=5;          %Assumed;
ratio.V_H=1289/101;     %Kribs-Zaleta2010EstimatingStates
% Theta Terms
%Currently coded so v->t and t->v are same if in between same compartment
    %but 1/5 if between dif compartment
theta.SV_SH=.015;
theta.DV_SH=theta.SV_SH/5;
theta.SH_SV=.015;
theta.DH_SV=theta.SH_SV/5;
theta.DV_DH=theta.SV_SH;
theta.SV_DH=theta.DV_DH/5;
theta.DH_DV=theta.SH_SV;
theta.SH_DV=theta.DH_DV/5;

% P Terms
p.SV_SH=.132;
p.DV_SH=p.SV_SH;
p.SH_SV=.116;
p.DH_SV=p.SH_SV;
p.DV_DH=p.SV_SH;
p.SV_DH=p.DV_DH;
p.DH_DV=p.SH_SV;
p.SH_DV=p.DH_DV;
% Alpha Terms (Not neccesarily the same data as Theta and P)
%alpha.SV_SH=1.26;
%alpha.DV_SH=.126;
%alpha.SH_SV=.517;
%alpha.DH_DV=.0517;
%alpha.DV_DH=1.26;
%alpha.SV_DH=.126;
%alpha.DH_DV=.517;
%alpha.SH_DV=.0517;
% Migration Terms
% proportion between migration rates muSV be inverse proportion
    %of pop sizes
lambda.H=.05;
lambda.V=.1;
%lambda.SH_DH=.05;
%lambda.DH_SH=lambda.SH_DH*ratio.SH_DH;
%lambda.SV_DV=.1;
%lambda.DV_SV=lambda.SV_DV*ratio.SV_DV;
% Birth/Death Rates
mu.SH=.83/365;
mu.SV=.271/365;
mu.DH=mu.SH;
mu.DV=mu.SV;
gamma.SH=mu.SH;
gamma.DH=mu.DH;
gamma.SV=mu.SV;
gamma.DV=mu.DV;
%% Test Conditions
% Population
popsize.SH=101;
popsize.SV=popsize.SH*ratio.V_H;
popsize.DH=popsize.SH/ratio.SH_DH;
popsize.DV=popsize.SV/ratio.SV_DV;
fracinfect.SH=.01;
fracinfect.SV=.01;
fracinfect.DH=.01;
fracinfect.DV=.01;

years=20;
tspan=linspace(0,years,years*365);
% Solvers
solver=@ode23tb;
% Initial Matrix
init(1,1)=popsize.SH*(1-fracinfect.SH); %Susceptible SH
init(2,1)=popsize.SH*(fracinfect.SH);   %Infected SH
init(3,1)=popsize.SV*(1-fracinfect.SV); %Susceptible SV
init(4,1)=popsize.SV*(fracinfect.SV);   %Infected SV
init(5,1)=popsize.DH*(1-fracinfect.DH); %Susceptible DH
init(6,1)=popsize.DH*(fracinfect.DH);   %Infected DH
init(7,1)=popsize.DV*(1-fracinfect.DV); %Susceptible DV
init(8,1)=popsize.DV*(fracinfect.DV);   %Infected DV
% Compile Variables
params.theta=theta;
params.p=p;
params.lambda=lambda;
params.mu=mu;
params.gamma=gamma;
params.init=init;
params.popsize=popsize;
params.fracinfect=fracinfect;
params.ratio=ratio;
params.tspan=tspan;
end

