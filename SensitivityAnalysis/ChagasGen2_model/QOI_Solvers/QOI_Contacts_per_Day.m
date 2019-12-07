function Metrics = QOI_Contacts_per_Day(params)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

b=params.bio.b;
rho=params.bio.rho;
N=params.N;
Metrics={"Metric" "Sylvatic" "Peridomestic";
           "# Vectors", N.SV, N.DV;
           "# Synanthropes", N.SS, N.DS;
           "# Rodents", N.SR, N.DR;
           "# pets", 0, N.DD;
           "Total Triatomines consumed" , NaN , NaN;
           "Triatomines consumed by synanthropes", NaN, NaN;
           "Triatomines consumed by rodents", NaN, NaN;
           "Triatomines consumed by pets", 0, NaN;
           "Total Triatomine Feedings", NaN, NaN;
           "Triatomine Feedings per synanthrope", NaN, NaN;
           "Triatomine Feedings per rodent", NaN, NaN;
           "Triatomine Feedings per pet", 0, NaN};
%Total triatomines consumed per day
Metrics{6,2}=b.SS*N.SS+b.SR*N.SR; Metrics{6,3}=b.DS*N.DS+b.DR*N.DR+b.DD*N.DD;
Metrics{7,2}=b.SS*N.SS; Metrics{7,3}=b.DS*N.DS;
Metrics{8,2}=b.SR*N.SR; Metrics{8,3}=b.DR*N.DR;
Metrics{9,2}=0; Metrics{9,3}=b.DD*N.DD;
%Total triatomines bites per day
Metrics{10,2}=b.SV*N.SV; Metrics{10,3}=b.DV*N.DV;
%Bites per Synanthrope
Metrics{11,2}=b.SV*rho.SS*N.SV/N.SS; Metrics{11,3}=b.DV*rho.DS*N.DV/N.DS;%/N.SS;%+b.DV*rho.DS*N.DV/N.DS;
%Bites per Rodent
Metrics{12,2}=b.SV*rho.SR*N.SV/N.SR; Metrics{12,3}=b.DV*rho.DR*N.DV/N.DR;%/N.SR;%+b.DR*rho.DR*N.DV)/(N.SR+N.DR);
%Bites per Dog
Metrics{13,2}=0; Metrics{13,3}=b.DV*rho.DD*N.DV/N.DD;%/N.DD;


end

