clear;
set(0,'DefaultAxesFontSize',15)
%This code routes to baseline_params and solve_balanced
% parameters for SEIMFRB model

casenames = {'Baseline Model'};

                                                        
params = baseline_params();

soln = solve_balanced(params);
        py(:,1)=soln.y(:,1)./(soln.y(1,1)+soln.y(1,2));
        py(:,2)=soln.y(:,2)./(soln.y(1,1)+soln.y(1,2));
        py(:,3)=soln.y(:,3)./(soln.y(1,3)+soln.y(1,4));
        py(:,4)=soln.y(:,4)./(soln.y(1,3)+soln.y(1,4));
        py(:,5)=soln.y(:,5)./(soln.y(1,5)+soln.y(1,6));
        py(:,6)=soln.y(:,6)./(soln.y(1,5)+soln.y(1,6));
        py(:,7)=soln.y(:,7)./(soln.y(1,7)+soln.y(1,8));
        py(:,8)=soln.y(:,8)./(soln.y(1,7)+soln.y(1,8));
percentplot='yes';
infectonly='yes';
popplot='no';
justvertebrates='no';
if strcmpi(percentplot,'yes')
    if strcmpi(infectonly,'yes')
        plot(soln.x,py(:,[2,4,6,8]))
        legend('I_{SV}','I_{ST}','I_{DV}', 'I_{DT}');
        title('Proportion Infected')
        xlabel('Time (years)')
    else
        plot(soln.x,py(:,1:8))
        legend('S_{SV}','I_{SV}','S_{ST}','I_{ST}','S_{DV}','I_{DV}','S_{DT}','I_{DT}');
        title('Proportion in Each Compartment')
        xlabel('Time (years)')
    end
end
if strcmpi(percentplot,'yes')&&strcmpi(popplot,'yes')
    figure
end
if strcmpi(popplot,'yes')
    if strcmpi(justvertebrates,'yes')
        plot(soln.x, soln.y(:,[1,2,5,6]))
        legend('S_{SV}','I_{SV}','S_{UV}','I_{UV}');
    else
        plot(soln.x,soln.y(:,1:8))
        legend('S_{SV}','I_{SV}','S_{ST}','I_{ST}','S_{UV}','I_{UV}');
    end
    title('Population Sizes')
    ylabel('Individuals')
    xlabel('Time (years)')
end
