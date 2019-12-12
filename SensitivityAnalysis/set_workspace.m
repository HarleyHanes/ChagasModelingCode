function set_workspace(model)
%% Set the MATLAB path to the libraries in this file's path
disp('Restoring default MATLAB path')
restoredefaultpath %

disp('Adding paths for local libraries')
prefix = mfilename('fullpath');
dirs = regexp(prefix,'[\\/]');
% this expects this file to be in lib's parent dir
addpath(genpath([prefix(1:dirs(end))]))

%Remove models not being used
switch model
    case "CG1"
        rmpath(genpath(sprintf('%s\\ChagasGen2_model',pwd)))
    case "CG2"
        rmpath(genpath(sprintf('%s\\ChagasGen1_model',pwd)))
    otherwise
end
%% Set a default for plot text style
%set(0,'DefaultAxesFontSize',13); 
%set(gca,'FontSize',16);

end

