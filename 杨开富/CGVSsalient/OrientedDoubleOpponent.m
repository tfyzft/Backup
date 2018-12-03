function [DO12 DO21] = OrientedDoubleOpponent(map,opponent,sigma,angles,ratio,weights)
% computing the responses of oriented double-opponent cells on R-G or B-Y channel
% inputs: 
%         map ------ RGB color map.
%         opponent- opponent channel one of {'RG','BY','wb'}.
%         sigma ---- Scale of local.
%         angles --- the number of orientation. (default:angles = 12)
%         ratio ---- the ratio of fine scale(sigma) and coarse scale(ratio*sigma).
%                (1)ratio>=1,default: ratio = 1.0;
%                (2)ratio =1, describe center-only opponent cells;
%                (3)ratio >1, describe center-surround opponent cells;

%         weights -- the cone weights. (default: weights=[1.0,-0.5])
% output: 
%        Double_Opponent---responses of oriented double-opponent cells in 'channel'.
% 2011.09.04 ---- by Yang Kaifu
%==========================================================================%

if nargin < 6, weights=[1 -0.5]; end
if nargin < 5, ratio=1.0; end
if nargin < 4,  angles = 12;  end

% computing single opponent
[Ch12 Ch21] = SingleOpponent(map,opponent,sigma,ratio,weights);

% construct the oriented double-opponent(color opponent & spatial opponent)
sig = 2*sigma;
DO12 = zeros(size(map,1),size(map,2),angles);
DO21 = zeros(size(map,1),size(map,2),angles);

fprintf(2,'[');

% Implement 1: simple computing...
% Compute Gratient on color opponent channels(R-G and B-Y)
for i = 1:angles % rotate 180 degree
   dgau2D = DivGauss2D(sig,(i-1)*pi/angles);
   S = sum(abs(dgau2D(:)));
   t1 = conByfft(Ch12,dgau2D/S); % Ch12
   DO12(:,:,i) = abs(t1);
   t2 = conByfft(Ch21,dgau2D/S); % Ch21
   DO21(:,:,i) = abs(t2);
   
   fprintf(2,'.');
end

  fprintf(2,']\n');
%=========================================================================%
