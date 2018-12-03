function cues = getLocalcues(map,sigma,Edge)
% local cues: Luminance,R-G,B-Y,Texture
% inputs: 
%         map ------ RGB color map.
%         sigma ---- Scale of smoothing.
%         Edge -- response of edge
% output: 
%         cues --- four basic cues
% 2016.10.30 ---- by Yang Kaifu
%=========================================================================%

R = map(:,:,1);
G = map(:,:,2);
B = map(:,:,3);

gau2D = gaus(sigma); 
Chr = imfilter(R,gau2D,'conv','replicate');
Chg = imfilter(G,gau2D,'conv','replicate');
Chb = imfilter(B,gau2D,'conv','replicate');

f1 = (Chr+Chg+Chb)./3;     % luminance 
f2 = Chr - Chg;            % R-G opponency
f3 = Chb-(Chr+Chg)./2;     % B-Y opponency


Havg = fspecial('average',[11 11]);
f4 = imfilter(Edge,Havg,'same','replicate');

cues(:,1)=(f1(:)-min(f1(:)))./(max(f1(:))-min(f1(:))+eps);
cues(:,2)=(f2(:)-min(f2(:)))./(max(f2(:))-min(f2(:))+eps);
cues(:,3)=(f3(:)-min(f3(:)))./(max(f3(:))-min(f3(:))+eps);
cues(:,4)=(f4(:)-min(f4(:)))./(max(f4(:))-min(f4(:))+eps);
%=========================================================================%
