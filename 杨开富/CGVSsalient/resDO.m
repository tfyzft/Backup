function [Re theta] = resDO(map,sigma,angles,ratio,weights)
% computing the response of oriented double-oponent cells
% and the optimal orientation of each pixel
%=========================================================================%

[w h d] = size(map);
theta = zeros(w,h);
MaxRe = zeros(w,h);

[Drg Dgr]= OrientedDoubleOpponent(map,'RG',sigma,angles,ratio,weights); 
[Dby Dyb]= OrientedDoubleOpponent(map,'BY',sigma,angles,ratio,weights); 

[Boundary(:,:,1),Orients(:,:,1)] = max(Drg,[],3);
[Boundary(:,:,2),Orients(:,:,2)] = max(Dgr,[],3);
[Boundary(:,:,3),Orients(:,:,3)] = max(Dby,[],3); 
[Boundary(:,:,4),Orients(:,:,4)] = max(Dyb,[],3); 

CBrg(:,:) = Boundary(:,:,1);
CBgr(:,:) = Boundary(:,:,2);
CBby(:,:) = Boundary(:,:,3);
CByb(:,:) = Boundary(:,:,4);

CBrg = CBrg./max(CBrg(:));     % norm
CBgr = CBgr./max(CBgr(:));
CBby = CBby./max(CBby(:)); 
CByb = CByb./max(CByb(:));

Boundary(:,:,1) = CBrg;
Boundary(:,:,2) = CBgr;
Boundary(:,:,3) = CBby;
Boundary(:,:,4) = CByb;

% max-pool
[MaxRe(:,:),idx(:,:)]= max(Boundary,[],3);

for i = 1:w
    for j =1:h
        theta(i,j) = Orients(i,j,idx(i,j));
    end
end

Re = MaxRe;
%=========================================================================%
