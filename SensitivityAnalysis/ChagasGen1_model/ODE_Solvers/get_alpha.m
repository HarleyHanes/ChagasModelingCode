function [alpha] = get_alpha(y,theta,p)
%get_alpha Computes alpha for Chagas Gen1 Model
%   Output: 8 component structure of alpha terms
%   Input: y vector of compartments, theta and p parameter structures
         alpha.SV_SH=theta.SV_SH*p.SV_SH*y(4)/(y(3)+y(4));
         alpha.DV_SH=theta.DV_SH*p.DV_SH*y(8)/(y(7)+y(8));
         alpha.SH_SV=theta.SH_SV*p.SH_SV*y(2)/(y(1)+y(2));
         alpha.DH_SV=theta.DH_SV*p.DH_SV*y(6)/(y(5)+y(6));
         alpha.SV_DH=theta.SV_DH*p.SV_DH*y(4)/(y(3)+y(4));
         alpha.DV_DH=theta.DV_DH*p.DV_DH*y(8)/(y(7)+y(8));
         alpha.SH_DV=theta.SH_DV*p.SH_DV*y(2)/(y(1)+y(2));
         alpha.DH_DV=theta.DH_DV*p.DH_DV*y(6)/(y(5)+y(6));
end

