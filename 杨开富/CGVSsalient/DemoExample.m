% demo:
% Salient Structure Detection by Contour-Guided Visual Search
% paper in TIP 2016:
% (1) Kai-Fu Yang, Hui Li, Chao-Yi Li, and Yong-Jie Li*. 
%     A Unified Framework for Salient Structure Detection by 
%     Contour-Guided Visual Search. TIP,25(8):3475-3488,2016.
% Website: http://www.neuro.uestc.edu.cn/vccl/home.html

% Note: 
% we have repaired some bug in the original code, so the results will be 
% silghtly different (better) with that reported in the paper(TIP'2016).

% Kaifu Yang <yang_kf@163.com>
% May 2016
%=========================================================================%
clc; 
clear;

% original RGB image
map = double(imread('0_24_24965.jpg'))./255;
figure;imshow(map,[]);

% resize the image for speeding computation
[ww,hh,dd] = size(map);
if ww>hh
    map = imresize(map,[300 floor(hh*(300/ww))],'bilinear');
elseif ww<=hh
    map = imresize(map,[floor(ww*(300/hh)) 300],'bilinear');
end

Iter = 3; % time of iteration = Iter -1;

tic
SOmap = CGVSsalient(map,Iter);
toc

figure;imshow(SOmap,[]);

fprintf(2,'======== THE END ========\n');
%=========================================================================%
