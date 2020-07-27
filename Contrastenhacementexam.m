clc;
clear all;
close all;
ima = imread('ima.tiff');
tire = imread('motion03.512.tiff');
[X, map] = imread('shadow.tif');
shadow = ind2rgb(X,map); % convert to truecolor
width = 210;
images = {ima, tire, shadow};

for k = 1:3
  dim = size(images{k});
  images{k} = imresize(images{k},[width*dim(1)/dim(2) width],'bicubic');
end

ima = images{1};
tire = images{2};
shadow = images{3};
pout_imadjust = imadjust(ima);
pout_histeq = histeq(ima);
pout_adapthisteq = adapthisteq(ima);

imshow(ima);
title('Original');

figure, imshow(pout_imadjust);
title('Imadjust');
figure, imshow(pout_histeq);
title('Histeq');

figure, imshow(pout_adapthisteq);
title('Adapthisteq');
tire_imadjust = imadjust(tire);
tire_histeq = histeq(tire);
tire_adapthisteq = adapthisteq(tire);

figure, imshow(tire);
title('Original');

figure, imshow(tire_imadjust);
title('Imadjust');
figure, imshow(tire_histeq);
title('Histeq');

figure, imshow(tire_adapthisteq);
title('Adapthisteq');

figure, imhist(ima), title('pout.tif');
figure, imhist(tire), title('tire.tif');

srgb2lab = makecform('srgb2lab');
lab2srgb = makecform('lab2srgb');

shadow_lab = applycform(shadow, srgb2lab); % convert to L*a*b*

% the values of luminosity can span a range from 0 to 100; scale them
% to [0 1] range (appropriate for MATLAB(R) intensity images of class double)
% before applying the three contrast enhancement techniques
max_luminosity = 100;
L = shadow_lab(:,:,1)/max_luminosity;

% replace the luminosity layer with the processed data and then convert
% the image back to the RGB colorspace
shadow_imadjust = shadow_lab;
shadow_imadjust(:,:,1) = imadjust(L)*max_luminosity;
shadow_imadjust = applycform(shadow_imadjust, lab2srgb);

shadow_histeq = shadow_lab;
shadow_histeq(:,:,1) = histeq(L)*max_luminosity;
shadow_histeq = applycform(shadow_histeq, lab2srgb);

shadow_adapthisteq = shadow_lab;
shadow_adapthisteq(:,:,1) = adapthisteq(L)*max_luminosity;
shadow_adapthisteq = applycform(shadow_adapthisteq, lab2srgb);

figure, imshow(shadow);
title('Original');

figure, imshow(shadow_imadjust);
title('Imadjust');

figure, imshow(shadow_histeq);
title('Histeq');

figure, imshow(shadow_adapthisteq);
title('Adapthisteq');