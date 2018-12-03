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

function gaussFun = GaussFun2D(hsize) 
% 
% sigma = double(hsize)/6.0; % 3*sigma = radius, i.e., 6*sigma = diameter (hsize)
% gaussFun = fspecial('gaussian',hsize,sigma);

gaussFun = zeros(hsize,hsize);
rr = (hsize+1)/2;
%rr = (hsize-1)/2;
for i=1:hsize
    for j=1:hsize
				tmpV = (i-rr)*(i-rr) + (j-rr)*(j-rr);
				gaussFun(i,j) = exp(-9.0*tmpV/rr/rr);
				%gaussFun(i,j) = exp(-4.5*tmpV/rr/rr);
    end
end
