function SOmap = CGVSsalient(map,Iter)
% function SOmap = CGVSsalient(map,Iter)
% inputs: 
%         map ------ RGB color map.
%         Iter ----- times of iteration
% output: 
%         SOmap -- output of CGVS method (salient structure)
%
% Main function for performing salient structure detection 
% in paper:
% (1) Kai-Fu Yang, Hui Li, Chao-Yi Li, and Yong-Jie Li*. 
%     A Unified Framework for Salient Structure Detection by 
%     Contour-Guided Visual Search. TIP,25(8):3475-3488,2016.
% 
% Contact:
% Visual Cognition and Computation Lab(VCCL),
% Key Laboratory for NeuroInformation of Ministry of Education,
% School of Life Science and Technology(SLST), 
% University of Electrical Science and Technology of China(UESTC).
% Address: No.4, Section 2, North Jianshe Road,Chengdu,Sichuan,P.R.China, 610054
% Website: http://www.neuro.uestc.edu.cn/vccl/home.html

% 电子科技大学，生命科学与技术学院，
% 神经信息教育部重点实验室，视觉认知与计算组
% 中国，四川，成都，建设北路二段4号，610054

% 杨开富/Kaifu Yang <yang_kf@163.com>;
% 李永杰/Yongjie Li <liyj@uestc.edu.cn>;
% May 2016
%
%========================================================================%

% edge-based saliency, i.e.,spatial weights
[ESmap,Edge]= EdgeSaliency(map);

% extracting local cues, e.g. color,luminance,texture etc.
sigma = 1.5; 
cues = getLocalcues(map,sigma,Edge);

prior = ESmap; 
Wcues = 0.25*ones(1,size(cues,2));

for iter=1:Iter
    
    % obtaining the rough region of object
    [Omask,unused]= ObjMask(prior,cues,Wcues);
    
    % salient object with naive bayes framework
    [SOmap,Wcues]= SObayes(cues,prior,Omask);
    prior = medfilt2(SOmap,[21 21]);
    
end