function [Polike,Pblike] = Plike(cues,mask,bins)
% Obtain the likelihood function of object and background regions
% inputs: 
%         bins --- number of bins
%         cues ---- local cues.
%         mask -- the object region

% output: 
%         Polike --- the likelihood of object set
%         Pblike --- the likelihood of background set
% 2016.10.30 ---- by Yang Kaifu
%=========================================================================%

np = size(cues,2);
Polike = zeros(size(cues));
Pblike = zeros(size(cues));

for k=1:np
    Tcue = cues(:,k);
    
    Tcue = round(Tcue*bins);
    Odata = Tcue(:);
    Odata(mask==0)=[];
    
    if ~isempty(Odata)
        Toidx = tabulate(Odata(:));
        Toidx(:,2)=[];
    end
    
    Bdata = Tcue(:);
    Bdata(mask==1)=[];    
    if ~isempty(Odata)
        Tbidx = tabulate(Bdata(:));
        Tbidx(:,2)=[];
    end
    
    Pol = zeros(size(Tcue));
    Pbl = zeros(size(Tcue));
     
    for i=0:bins
        if ~isempty(find(Toidx(:,1)==i))
            Pol(Tcue==i) = Toidx(Toidx(:,1)==i,2);
        else
            Pol(Tcue==i) = 0;
        end
        
        if ~isempty(find(Tbidx(:,1)==i))
            Pbl(Tcue==i) = Tbidx(Tbidx(:,1)==i,2);
        else
            Pbl(Tcue==i) = 0;
        end
    end
    Polike(:,k) = Pol./100;
    Pblike(:,k) = Pbl./100;
end
%=========================================================================%
