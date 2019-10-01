function init = get_init_CG1(param)
popsize=param.popsize;
fracinfect=param.fracinfect;

init =  ...
    [popsize.SH*(1-fracinfect.SH);... %Susceptible SH
    popsize.SH*(fracinfect.SH);...    %Infected SH
    popsize.SV*(1-fracinfect.SV);...  %Susceptible SV
    popsize.SV*(fracinfect.SV); ...   %Infected SV
    popsize.DH*(1-fracinfect.DH);...  %Susceptible DH
    popsize.DH*(fracinfect.DH);...    %Infected DH
    popsize.DV*(1-fracinfect.DV);...  %Susceptible DV
    popsize.DV*(fracinfect.DV)];       %Infected DV
end