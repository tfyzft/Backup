%clear all
%close all
%load('sfulab_name.mat');
%for i = 1:321
%	i
%	name = regexp(all_image_names{i}, '.*/', 'split');
%	ori_picture = imread(['original\' name{2} '.tif']);
%	con_picture = imread(['groundtruth\' name{2} '.tif']);
%	%set the value of the place where need mask eq 0
%	mask = 1;
%	temp = RMICC(ori_picture, con_picture,mask);
%	output(i) = temp;
%end

ori_picture = imread('plastic-1_syl-wwf.tif');
con_picture = imread('plastic-1_syl-truth.tif');
mask = 1;
output = RMICC(ori_picture, con_picture,mask);


