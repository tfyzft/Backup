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

function Output = RMICC(OriPic,ConPic,mask)
%OriPic is the picture under illuminants.
%ConPic is the picture without illuminants(groundtruth). 
%mask is the area need be masked

%cone input
input_picture = im2double(OriPic);
[high width cc] = size(input_picture);
h = fspecial('gaussian',[3 3],3);
input_picture = imfilter(input_picture,h);
%HC modulation
A = calc_Apro(input_picture);
Ar1 = A(1);
Ag1 = A(2);
Ab1 = A(3);
Ir = Ar1*input_picture(:,:,1);
Ig = Ag1*input_picture(:,:,2);
Ib = Ab1*input_picture(:,:,3);
Iy = (Ir+Ig)/2;


%single opponency with disinhibition
%adaptation
%%set threshold
temp_flag = 0;
th = 0.0001;
th2 = 0.0001;
rg_flag = 0;
by_flag = 0;
for i = 1:1:50
	Ar2 = i/5;
	Ag2 = i/5;
	Ab2 = i/5;
	Ay2 = i/5;
	Ar3 = Ar2/3;
	Ag3 = Ag2/3;
	Ab3 = Ab2/3;
	Ay3 = Ay2/3;
	Tr = myNCRF(Ir,1,3,1,1,Ar2,Ar3,Ig);
	Tg = myNCRF(Ig,1,3,1,1,Ag2,Ag3,Ir);
	Tb = myNCRF(Ib,1,3,1,1,Ab2,Ab3,Iy);
	Ty = myNCRF(Iy,1,3,1,1,Ay2,Ay3,Ib);
	RT(i) = sum(sum(Tr));
	GT(i) = sum(sum(Tg));
	BT(i) = sum(sum(Tb));
	YT(i) = sum(sum(Ty));
	rt(i) = RT(i)/(RT(i)+GT(i)+BT(i));
	gt(i) = GT(i)/(RT(i)+GT(i)+BT(i));
	bt(i) = BT(i)/(RT(i)+GT(i)+BT(i));
	yt(i) = YT(i)/(RT(i)+GT(i)+BT(i));
	k = i;
	if i > 2

		%caculate rg/by separately
		if rg_flag == 0
			if (abs(diff(RT(i-1:i))) <= th2 & abs(diff(diff(RT(i-2:i)))) <= th2)|(abs(diff(GT(i-1:i))) <= th2 & abs(diff(diff(GT(i-2:i)))) <= th2)
				rg_flag = 1;
			end
			krg = i;
		end
		if by_flag == 0
			if (abs(diff(BT(i-1:i))) <= th2 & abs(diff(diff(BT(i-2:i)))) <= th2)|(abs(diff(YT(i-1:i))) <= th2 & abs(diff(diff(YT(i-2:i)))) <= th2)
				by_flag = 1;
			end
			kby = i;
		end
		if (rg_flag == 1) & (by_flag == 1)
			break;
		end
	end
end

Ar2 = krg*Ar1/5;
Ag2 = krg*Ag1/5;
Ab2 = kby*Ab1/5;
Ar3 = Ar2/3;
Ag3 = Ag2/3;
Ab3 = Ab2/3;
Tr = myNCRF(Ir,1,3,1,1,Ar2,Ar3,Ig);
Tg = myNCRF(Ig,1,3,1,1,Ag2,Ag3,Ir);
Tb = myNCRF(Ib,1,3,1,1,Ab2,Ab3,Iy);

output_picture(:,:,1) = Tr;
output_picture(:,:,2) = Tg;
output_picture(:,:,3) = Tb;

ConPic = ConPic.*mask;
OriPic = OriPic.*mask;
output_picture = output_picture.*mask;

%Calculate euclidean distance for input1 and input2.
d = calc_EucD(output_picture,ConPic);
%Calculate angular error for input1 and input2.
ill = calc_AngE(est_I(ConPic,OriPic), est_I(output_picture, OriPic));
%Calculate reproduction angular error for input1 and input2.
ill2 = calc_RAE(est_I(ConPic,OriPic), est_I(output_picture, OriPic));

Output.distance = d;
Output.illuminant = ill;
Output.illuminant2 = ill2;
%Output.ill = est_I(output_picture, OriPic)
Output.picture = output_picture;

end
