function jac = getJacobian(POIs, evalFcn_, varargin)
% Takes a set of parameters for the function bHandle
%  as well as any arguments you'd like to pass to bHandle
%
% params - baseline parameters, p
% evalFcn - q(params)
%
% Returns the normalized jacobian evaluated at p:
%   (pj / qi) (partial qi/ partial pj) = S

%% Input Management
params_=POIs.params;
ref=POIs.ref;
p = inputParser;

addRequired(p,'params',@isnumeric);
addRequired(p,'evalFcn',@(fh) isa(fh,'function_handle'));

addOptional(p,'raw',false,@islogical);

parse(p, params_, evalFcn_, varargin{:});

params = p.Results.params;      %Harley: Why is it p.Results instead of p
evalFcn = p.Results.evalFcn;
raw = p.Results.raw;
%%
nParams = length(params);

% calculate baseline point
baseQuants = evalFcn(params,ref);

nQuants = length(baseQuants);

%%
for i = nParams:-1:1
    init_x0(i) = params(i);
end

jac = NaN(nQuants, nParams);

factor = .001; % get .1% of initial parameters, HARD
delta_x0 = abs(init_x0 * factor);

% fudge number if delta is 0
delta_x0(delta_x0==0) = factor;
y0 = baseQuants;
for i = 1:nParams
    xi = params;
    % basic centered difference approximation of Jacobian
    xi(i) = init_x0(i) - delta_x0(i);
    yLo = evalFcn(xi,ref);
    
    xi(i) = init_x0(i) + delta_x0(i);
    yHi = evalFcn(xi,ref);
    
    for j = 1:nQuants
        % Calculate partial
        part_yj_xi = (yHi(j) - yLo(j)) / (2 * delta_x0(i));
        
        y0q = y0(j);
        jac(j,i) = part_yj_xi;
        if ~raw
            jac(j,i) = jac(j,i) * init_x0(i) * sign(y0q) / sqrt(eps + y0q^2); %What's eps
        end
    end
end

end