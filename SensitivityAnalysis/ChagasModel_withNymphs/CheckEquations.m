syms gammaSV gammaDV I_SV I_DV alphaSS_SV alphaDS_DV I_DD I_SS NSS NDS alphaSR_SV alphaDR_DV I_DR NDR I_SR NSR alphaDD_DV I_DD NDD S_DV
syms bDS bDR bDD NDV I_DS
syms S_SV bSS bSR NSV lambdaDV_SV S_DV lambdaSV_DV S_SV I_DV I_SV
dydt(1)=gammaSV*I_SV-(alphaSS_SV*(I_SS/NSS)+alphaSR_SV*(I_SR/NSR))*S_SV+(bSS*NSS+bSR*NSR)*(I_SV/NSV)+lambdaDV_SV*S_DV-lambdaSV_DV*S_SV;
dydt(2)=-gammaSV*I_SV+(alphaSS_SV*(I_SS/NSS)+alphaSR_SV*(I_SR/NSR))*S_SV-(bSS*NSS+bSR*NSR)*(I_SV/NSV)+lambdaDV_SV*I_DV-lambdaSV_DV*I_SV;

dydt(7)=gammaDV*I_DV-(alphaDS_DV*(I_DS/NDS)+alphaDR_DV*(I_DR/NDR)+alphaDD_DV*(I_DD/NDD))*S_DV+(bDS*NDS+bDR*NDR+bDD*NDD)*(I_DV/NDV)+lambdaSV_DV*S_SV-lambdaDV_SV*S_DV;
dydt(8)=-gammaDV*I_DV+(alphaDS_DV*(I_DS/NDS)+alphaDR_DV*(I_DR/NDR)+alphaDD_DV*(I_DD/NDD))*S_DV-(bDS*NDS+bDR*NDR+bDD*NDD)*(I_DV/NDV)+lambdaSV_DV*I_SV-lambdaDV_SV*I_DV;

dydt(1)+dydt(2)
dydt(7)+dydt(8)

dydt(1)+dydt(2)+dydt(7)+dydt(8)