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

RMICC.m is the main function. The input is the picture under illuminants, the groundtruth, and the mask area. The output is the euclidean distance, the angular error, and the reproduction angular error.
calc_Apro.m calculates the factors of the HC modulation.
myNCRF.m imitates the non-classical receptive field of ganglion cells.
GaussFun2D.m is a 2D gauss function.
calc_EucD.m calculates euclidean distance.
calc_AngE.m calculates angular error.
calc_RAE.m calculates reproduction angular error.
est_I.m estimates illuminants.
get_rgb.m calculates the normalization RGB value of a image.