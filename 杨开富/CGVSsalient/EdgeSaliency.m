function [Salmap,Edge]= EdgeSaliency(map)
% obtain the prior based edge layout and center prior
% inputs: 
%         map ------ RGB color map.
% output: 
%         Salmap -- the prior based on edge layout and center prior
%         Edge -- response of edge
% 2016.10.30 ---- by Yang Kaifu
%=========================================================================%

% parameters setting same as CO edge detector in CVPR2013 
ratio = 1;
angles = 8;
sigma = 1.5;
weights = -0.6;

[Edge,theta] = resDO(map,sigma,angles,ratio,weights);
[ww,hh,dd] = size(map);

Edge = Edge./max(Edge(:));
theta = (theta-1)*pi/angles; 
theta = mod(theta+pi/2,pi);
pb = nonmax(Edge,theta);
pb = max(0,min(1,pb));

Wbg = Wedge(pb,theta,Edge,min(ww,hh)/3);

Cweight = fspecial('gaussian',size(Wbg),min(size(Wbg))/3);
Cweight  = (Cweight-min(Cweight(:)))./(max(Cweight(:))-min(Cweight(:)));

Wbg = Wbg + Cweight;
Salmap  = (Wbg-min(Wbg(:)))./(max(Wbg(:))-min(Wbg(:)));
%=========================================================================%
