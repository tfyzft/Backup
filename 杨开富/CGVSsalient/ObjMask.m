function [Omask,Fpp]= ObjMask(prior,cues,Wcues)
% Obtain object regions and background regions with adaptive threshold
% inputs: 
%         prior --- the spatial prior of salient structure
%         cues ---- local cues.
%         Wcues --- the weight of each cue

% output: 
%         Omask -- the object region
%         Fpp  --- precentage of object region
% 2016.10.30 ---- by Yang Kaifu
%=========================================================================%

Dis0 =0;
np = size(cues,2);
Omask = zeros(size(prior));
Fpp =0.1;
Bins = 255;

for pert=0.1:0.02:0.5
    
    counts = imhist(prior,Bins); counts(1,1)=0;
    th = find(cumsum(counts)>=(1-pert)*sum(counts),1,'first')/Bins;
    if th==1, th = (Bins-1)/Bins; end
    
    tmask = prior>th;
    mask = [];
    for i=1:np
        mask = [mask tmask(:)];
    end
    Cf = cues.*mask;
    Sf = cues.*(1-mask);
    
    mCf = sum(Cf)./sum(mask>0);
    mSf = sum(Sf)./sum(mask==0);
    Dis = sqrt(sum(Wcues.*(mCf-mSf).^2));
    
    if Dis>Dis0
        Dis0 = Dis;
        Omask = tmask;
        Fpp = pert;
    end
end
%=========================================================================%
