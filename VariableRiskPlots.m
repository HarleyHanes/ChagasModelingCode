clear; close all;
sigma=1;
mu=4;
nbins=13;
nsamp=5000;
yrandom=normrnd(mu,sigma,[nsamp,1]);
ycategories=linspace(0,8,nbins);
CatArray=cell(nbins,1);
for in=1:nbins 
    CatArray{in,1}=sprintf('I_{%i}',in);
end
for iy=1:length(yrandom)
    binnumber=length(ycategories(yrandom(iy)>ycategories));
    CatValues(iy,1)=binnumber;
end
C=categorical(CatValues,1:13,CatArray);
histogram(C,'Normalization','probability')
ylabel('P(\eta)');
xlabel('\eta=Number of Infected Contacts')
figure
%histogram(CatValues,nbins,'Normalization','probability')

% barstings=cell(0,1);
% for in=1:nbins
%     barstrings{in,1}=sprintf('I_%i',in);
% end
% %barstrings = sprintf('I_%i,',1:13);
% text(x,n,barstrings,'horizontalalignment','center','verticalalignment','bottom')

Normal=@(x)1/(sigma*sqrt(2*pi))*exp(-(x-mu).^2/(2*sigma^2));
x=0:.01:8;
y=Normal(x);
plot(x,y)
ylabel('P(\eta)');
xlabel('\eta=Number of Infected Contacts')

xbins=0:10:8;
% for ix=1:length(xbins)
%     ybins(ix)=sum(y(x<xbins(ix)&& x>=(xbins-1)));
% end

