function jac = getJacobian(POIs_, evalFcn_, select_, baseParams_,varargin)
% Takes a set of parameters for the function bHandle
%  as well as any arguments you'd like to pass to bHandle
%
% POIs - baseline parameters, p
% evalFcn - q(params)
%
% Returns the normalized jacobian evaluated at p:
%   (pj / qi) (partial qi/ partial pj) = S

%% Input Management
p = inputParser;

addRequired(p,'POIs',@isnumeric);
addRequired(p,'evalFcn',@(fh) isa(fh,'function_handle'));
addRequired(p,'select',@isstruct);
addRequired(p,'baseParams',@isstruct);

addOptional(p,'raw',false,@islogical);

parse(p, POIs_, evalFcn_, select_, baseParams_, varargin{:});

POIs = p.Results.POIs;
evalFcn = p.Results.evalFcn;
raw = p.Results.raw;
select=p.Results.select;
baseParams=p.Results.baseParams;
%%
nPOIs = length(POIs);

% calculate baseline point
baseQuants = evalFcn(POIs,select,baseParams);

nQuants = length(baseQuants);

%%
for i = nPOIs:-1:1
    init_x0(i) = POIs(i);
end

jac = NaN(nQuants, nPOIs);

factor = .001; % get .1% of initial parameters, HARD
delta_x0 = abs(init_x0 * factor);

% fudge number if delta is 0
delta_x0(delta_x0==0) = factor;
y0 = baseQuants;
for i = 1:nPOIs
    xi = POIs;
    % basic centered difference approximation of Jacobian
    xi(i) = init_x0(i) - delta_x0(i);
    yLo = evalFcn(xi,select,baseParams);
    
    xi(i) = init_x0(i) + delta_x0(i);
    yHi = evalFcn(xi,select,baseParams);
    
    for j = 1:nQuants
        % Calculate partial
        part_yj_xi = (yHi(j) - yLo(j)) / (2 * delta_x0(i));
        
        y0q = y0(j);
        jac(j,i) = part_yj_xi;
        if ~raw
            jac(j,i) = jac(j,i) * init_x0(i) * sign(y0q) / sqrt(eps + y0q^2);
        end
    end
end

end