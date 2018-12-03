function convRlt = conByfft(img,tpl)
% by Zengchi
% conv2 throuht fft2, less compute cost (faster)...
% same as imfiter function with the border parameter: 'symmetric'...
% the output (convRlt) has the same size as input image(img)...
%-------------------------------------------------------------------------%

img = double(img);
[Nr,Nc,Ns] = size(img);
[nr,nc]    = size(tpl);
nrE = floor(double(nr)/2);
ncE = floor(double(nc)/2);
imgExpan2 = zeros(Nr+4*nrE,Nc+4*ncE,Ns);
tplExpan  = zeros(Nr+4*nrE,Nc+4*ncE);
tplExpan(1:nr,1:nc)  = tpl;
% te = ones(Nr+4*nrE,Nc+4*ncE,Ns);

for i = 1:Ns
    imgExpan1(:,:,i) = padarray(img(:,:,i),[nrE ncE],'symmetric','both');
    imgExpan2(1:Nr+2*nrE,1:Nc+2*ncE,i) = imgExpan1(:,:,i);
   % convRlt(:,:,i) = real(ifft2(fft2(imgExpan2(:,:,i)).*(te-fft2(tplExpan))));
    convRlt(:,:,i) = real(ifft2(fft2(imgExpan2(:,:,i)).*fft2(tplExpan)));
end

convRlt = convRlt(2*nrE+1:2*nrE+Nr,2*ncE+1:2*ncE+Nc,:);
%=========================================================================%
