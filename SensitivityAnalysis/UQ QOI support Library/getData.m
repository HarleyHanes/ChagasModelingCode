function [param_data,quant_data] = getData(basePOIs_,baseRanges_,evalFcn_,select_,baseParams_,varargin)
% eg.
% getData([.1,.2],[0,1; 0.01,.1], @(x) x(1,:)*x(2,:)

%% Input Management
p = inputParser;

addRequired(p,'basePOIs',@isnumeric);
addRequired(p,'baseRanges',@isnumeric);
addRequired(p,'evalFcn',@(fh) isa(fh,'function_handle'));
addRequired(p,'select',@isstruct);
addRequired(p,'baseParams',@isstruct);

defaultNumPoints = 10;
addOptional(p,'numPoints',defaultNumPoints,@isnumeric);
parse(p, basePOIs_, baseRanges_, evalFcn_, select_, baseParams_, varargin{:});

basePOIs = p.Results.basePOIs;
baseRanges = p.Results.baseRanges;
select=p.Results.select;
baseParams=p.Results.baseParams;
evalFcn = p.Results.evalFcn;
nPoints = p.Results.numPoints;
%
nbasePOIs = length(basePOIs);
[nBaseRanges,two] = size(baseRanges);

assert(nbasePOIs == nBaseRanges, 'Every parameter needs a range');
assert(two == 2, 'Param ranges are two columns, [ min, max ]');
%%
% Evaluate at the base point
baseQuants = evalFcn(basePOIs,select,baseParams);

param_data.base = basePOIs;
quant_data.base = baseQuants;

param_data.range = NaN(nbasePOIs,nPoints);
quant_data.range = NaN(nbasePOIs,length(baseQuants),nPoints);

% First data point is baseline
for i = 1:nbasePOIs
    params = basePOIs; % copy to mutate
    if isnan(baseRanges(i,1)) || isnan(baseRanges(i,1)) || baseRanges(i,1) > baseRanges(i,2)
        continue % Don't calulate the param if the range is not a proper range
    end
    range = linspace(baseRanges(i,1),baseRanges(i,2),nPoints);
    param_data.range(i,:) = range;
    for j = 1:nPoints
        params(i) = range(j);
        % Calculate and save quants
        out = evalFcn(params,select,baseParams);
        quant_data.range(i,:,j) = out;
    end
end

end