function [Ch12 Ch21] = SingleOpponent(map,opponent,sigma,ratio,weights)
% computing the response of single opponent cells
% inputs: 
%         map ------ RGB color map.
%         opponent - opponent channel one of {'RG','BY','wb'}.
%         sigma ---- Scale of center. ratio*sigma is the scale of surround.
%         ratio ---- the ratio of fine scale(sigma) and coarse scale(ratio*sigma).
%                (1)ratio>=1,default: ratio = 1.0;
%                (2)ratio =1, describe center-only opponent cells;
%                (3)ratio >1, describe center-surround opponent cells;

%         weights -- the cone weights. (default: weights=[1.0,-0.5])
% output: 
%         Ch12 --- the response of channel1 + channel2 -  e.g. L+M-
%         Ch21 --- the response of channel1 - channel2 +  e.g. L-M+

% 2011.09.04 ---- by Yang Kaifu
%=========================================================================%

if nargin < 5, weights=[1 -0.5]; end
if nargin < 4,  ratio = 1.0;  end
[rr cc z] = size(map);
if z~=3
   error('the input image must be a color image(3-matrix)!\n');
end

% obtain each channel
  R = map(:,:,1);   % Cone-L
  G = map(:,:,2);   % Cone-M
  B = map(:,:,3);   % Cone-S
  Y = (R+G)/2;
  w = (R+G+B)./3; 
  b = max(w(:))-w;
  
% select the opponent channels
  if strcmp(opponent,'RG')
      channel1 = R;  channel2 = G; 
  elseif strcmp(opponent,'BY')
      channel1 = B;  channel2 = Y; 
  elseif strcmp(opponent,'wb')
      channel1 = w;  channel2 = b; 
  else
      error('the opponent channel parameter must be one of {RG BY wb}\n');
  end

% computing the response of center-only single opponent cells
% if length(weights)==1
   w1 = 1.0.*ones(rr,cc); 
   w2 = weights.*ones(rr,cc);
% elseif length(weights)==2
%    w1 = weights(1).*ones(rr,cc);
%    w2 = weights(2).*ones(rr,cc);
% else
%     error('The number of weights is mismatch!');
% end
   
Cgau2D = gaus(sigma);   % center -- fine scale -- sigma
Sgau2D = gaus(ratio*sigma); % surround -- coarse scale -- ratio*sigma (ratio>=1)

% channel1 -- center, channel2 -- surround,
Ch1 = imfilter(channel1,Cgau2D,'conv','replicate');
Ch2 = imfilter(channel2,Sgau2D,'conv','replicate');

Ch12 = w1.*Ch1 + w2.*Ch2;   % Ch1+ Ch2-
Ch21 = w2.*Ch1 + w1.*Ch2;   % Ch1- Ch2+

if ratio<1
     error('function SingleOpponent: the fouth parameter(ratio) should be: ratio>=1');
 end

%=========================================================================%