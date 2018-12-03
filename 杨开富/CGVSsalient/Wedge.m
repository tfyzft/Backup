function Ws = Wedge(Pb,theta,Edge,radius)
% obtain the prior based edge layout
% inputs: 
%         Pb ------ one-pixel edge map.
%         theta --- orientation of edge pixels.
%         Edge ---- response of edge
%         radius -- radius of local region.
% output: 
%         Ws -- the spatial prior based on edge layout
% 2016.10.30 ---- by Yang Kaifu
%=========================================================================%
angles=8;
Pb(Pb<0.3)=0;
[ww,hh] = size(Pb);
theta = (pi-theta)-pi/8; 

Results = zeros(size(Pb));
for i=1:angles
    temp = zeros(size(Pb));
    temp(theta==(i-1)*pi/angles) = Pb(theta==(i-1)*pi/angles);
    [rr,cc]=find(temp>eps);
    xx =cc; yy=size(temp,1)-rr;
    
    [rr0,cc0]=meshgrid(1:hh,1:ww);
    xx0 =rr0; yy0=size(temp,1)-cc0;
    
 for j=1:length(rr)
     ttt = zeros(size(Pb));
     tregion = ttt;
     tregion(((cc(j)-rr0).^2+(rr(j)-cc0).^2)<=radius^2)=1;
     
     k = tan(theta(rr(j),cc(j)));
     b = yy(j)-k*xx(j);
     ttt(yy0<k*xx0+b)=1;
     
     sum1 = sum(sum(ttt.*Edge.*tregion));
     sum2 = sum(sum((1-ttt).*Edge.*tregion));
     if sum1>sum2
         Results = Results + ttt.*tregion;
     else
         Results = Results + (1-ttt).*tregion;
     end
 end 
end

Ws = Results;
Ws  = (Ws-min(Ws(:)))./(max(Ws(:))-min(Ws(:)));
%=========================================================================%
