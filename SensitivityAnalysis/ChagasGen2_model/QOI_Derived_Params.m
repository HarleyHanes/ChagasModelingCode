function Metrics = QOI_Derived_Params(params)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

b=params.b;
rho=params.bio.rho;
N=params.N;
gamma=params.gamma;
Metrics={
'Metric'               'Sylvatic'                 'Peridomestic';
'Compartment Sizes', '', '';
'# Vectors',              N.SV                          N.DV;
'# Synanthropes'          N.SS                          N.DS;
'# Rodents'               N.SR                          N.DR;
'# Pets'                   0                            N.DD;
'Vector Demographics', " ", " "; 
'Vector Lifspan'         1/gamma.SV                 1/gamma.DV;
'Vectors Dying per Day' gamma.SV*N.SV+b.SS*N.SS+b.SR*N.SR              gamma.DV*N.DV+b.DS*N.DS+b.DR*N.DR+b.DD*N.DD;
'Total Triatomines consumed' b.SS*N.SS+b.SR*N.SR , b.DS*N.DS+b.DR*N.DR+b.DD*N.DD;
'% Vectors dying due to host consumption' (b.SS*N.SS+b.SR*N.SR)/(gamma.SV*N.SV+b.SS*N.SS+b.SR*N.SR)*100 (b.DS*N.DS+b.DR*N.DR+b.DD*N.DD)/(gamma.DV*N.DV+b.DS*N.DS+b.DR*N.DR+b.DD*N.DD)*100;
'Triatomines consumed by synanthropes per day', b.SS*N.SS,     b.DS*N.DS;
'Triatomines consumed per synanthrope per day', b.SS,     b.DS;
'Triatomines consumed by rodents per day', b.SR*N.SR,        b.DR*N.DR;
'Triatomines consumed per rodent per day', b.SR,        b.DR;
'Triatomines consumed by pets per day', 0, b.DD*N.DD;
'Host Demographics', "", "";
'Synanthrope Lifespan', 1/gamma.SS,                1/gamma.DS;
'Rodent Lifespan', 1/gamma.SR,                     1/gamma.DR;
'Pet Lifespan',   "-",                     1/gamma.DD;
'Vector Feedings',         " ",  " ";
'Total Vector Feedings per day', b.SV*N.SV, b.DV*N.DV;
'Average Time between feedings', 1/b.SV, 1/b.DV;
'Triatomine Feedings per synanthrope per day', b.SV*rho.SS*N.SV/N.SS, b.DV*rho.DS*N.DV/N.DS;
'Triatomine Feedings per rodent per day', b.SV*rho.SR*N.SV/N.SR, b.DV*rho.DR*N.DV/N.DR;
'Triatomine Feedings per pet per day', 0, b.DV*rho.DD*N.DV/N.DD;
'R0',                   QOI_R0(params,'numeric'),          ""};
xlswrite('DerivedParams.xls',Metrics)
% %Total triatomines consumed per day
% Metrics{6,2}=b.SS*N.SS+b.SR*N.SR; Metrics{6,3}=b.DS*N.DS+b.DR*N.DR+b.DD*N.DD;
% Metrics{7,2}=b.SS*N.SS; Metrics{7,3}=b.DS*N.DS;
% Metrics{8,2}=b.SR*N.SR; Metrics{8,3}=b.DR*N.DR;
% Metrics{9,2}=0; Metrics{9,3}=b.DD*N.DD;
% %Total triatomines bites per day
% Metrics{10,2}=b.SV*N.SV; Metrics{10,3}=b.DV*N.DV;
% %Bites per Synanthrope
% Metrics{11,2}=b.SV*rho.SS*N.SV/N.SS; Metrics{11,3}=b.DV*rho.DS*N.DV/N.DS;%/N.SS;%+b.DV*rho.DS*N.DV/N.DS;
% %Bites per Rodent
% Metrics{12,2}=b.SV*rho.SR*N.SV/N.SR; Metrics{12,3}=b.DV*rho.DR*N.DV/N.DR;%/N.SR;%+b.DR*rho.DR*N.DV)/(N.SR+N.DR);
% %Bites per Dog
% Metrics{13,2}=0; Metrics{13,3}=b.DV*rho.DD*N.DV/N.DD;%/N.DD;


end

