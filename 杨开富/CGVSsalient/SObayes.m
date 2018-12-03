function [Psal,Wcues]= SObayes(cues,prior,Omask)
% Obtain object regions and background regions with adaptive threshold
% inputs: 
%         prior --- the spatial prior of salient structure
%         cues ---- local cues.
%         Omask -- the object region

% output: 
%         Psal  --- posterior probability
%         Wcues --- the weight of each cue
% 2016.10.30 ---- by Yang Kaifu
%=========================================================================%

np = size(cues,2);
[rr,cc] = size(Omask);

mask = [];
for i=1:np
    mask = [mask Omask(:)];
end

Cf = cues.*mask;
Sf = cues.*(1-mask);

mCf = sum(Cf)./sum(mask>0);
mSf = sum(Sf)./sum(mask==0);
dif = mCf-mSf;
ww = abs(dif);
w = (ww+eps)./sum(ww);

bins = 20;
[Polike,Pblike] = Plike(cues,Omask,bins);

pobj = ones(rr*cc,1);
pbck = ones(rr*cc,1);
for i=1:np
    pobj = pobj .* (Polike(:,i).^w(i));
    pbck = pbck .* (Pblike(:,i).^w(i));
end

Psal = (prior(:).*pobj)./(prior(:).*pobj+(1-prior(:)).*pbck+eps);
Psal = (Psal-min(Psal(:)))./((max(Psal(:))-min(Psal(:)))+eps);

Psal = reshape(Psal,[rr cc]);
Wcues = w;  %[luminance,rg,by,contrast]
%=========================================================================%


