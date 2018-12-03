%
% The method is described in the following paper:
% Xian-Shi Zhang, Shao-Bing Gao, Ruo-Xuan Li, Xin-Yu Du, Chao-Yi Li, Yong-Jie Li*,
% A Retinal Mechanism Inspired Color Constancy Model,
% IEEE Transactions on Image Processing, 2016, 25(3): 1219-1232.
%
% Contact:
% Visual Cognition and Computation Laboratory(VCCL),
% Key Laboratory for Neuroinformation of Ministry of Education,
% School of Life Science and Technology,
% University of Electronic Science and Technology of China, Chengdu, 610054, China
% Website: http://www.neuro.uestc.edu.cn/vccl/home.html
% Xian-Shi Zhang <zhangxianshi@163.com>
% Yong-Jie Li <liyj@uestc.edu.cn>;
%
% Only for non-commercial usage.
% Please cite the above paper when you use these codes for academic research. Thanks.
% Feb 1, 2016
%=========================================================================%

function [I] = calc_Apro(Input)
%I=[AR AG AB]
%with Brightest Area
t = 1;
%Ciurea11346
%p = 24;  %mask
%SFU321
p = 13;
%%SG568
%p = 10;  %mask


area = numel(Input(:,:,1));
img_I = (Input(:,:,1)+Input(:,:,2)+Input(:,:,3))/3;
adjust_img = 1-(img_I>t);

temp = (Input(:,:,1).*adjust_img).^p;
R = (sum(sum(temp))/area)^(1/p);
temp = (Input(:,:,2).*adjust_img).^p;
G = (sum(sum(temp))/area)^(1/p);
temp = (Input(:,:,3).*adjust_img).^p;
B = (sum(sum(temp))/area)^(1/p);

RGB = [R G B];


temp = sqrt(sum(RGB.^2));
AR = temp/RGB(1);
AG = temp/RGB(2);
AB = temp/RGB(3);
I = [AR AG AB];
