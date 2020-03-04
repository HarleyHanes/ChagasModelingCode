function [params] = modify_params(POIs,select,baseParams)
%modify_params Function to take baseParams values and modify to fit model
%type to sensitivity analysis variation
%   To reduce confusion about what parameter values are being used
%   baseParams will remain unchanged through sensitivity analysis but POIs
%   and select will code how this function changes them. params should
%   therefore not be passed between functions.
pnames=select.POI;
if isfield(select,'model')
    model=select.model;
else
    model='full';
end
%% Initialize ODE solver
% convert the list of POIs into model variable names
% POIs will be same parameters as being optimized
params = get_p_struct_CG2(POIs,pnames,baseParams);
if strcmpi(model,'10ODE')
    params=CG2toODE10params(params);
elseif strcmpi(model,'8ODE')
    params=CG2toCG1params(params);
elseif ~strcmpi(model,'full')
    error('Unrecognized model type')
end
end

