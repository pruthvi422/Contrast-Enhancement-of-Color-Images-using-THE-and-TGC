
close all;
clear all;
clc;
[f,p]=uigetfile('.jpg');
I=strcat(p,f);
img=imread(I);
figure,imshow(img);
title('Input Image','color','Red');
[r,c,~] = size(img);
i=img;
%%%%%%%%%%%%%RGB to HSV conversion%%%%%%%%%%%%%%%%%%
HSV = rgb2hsv(i);
% figure,imshow(HSV);
% title('HSV Image','color','Green');
%%%%%%%%%%%%%Third plane extraction of HSV Image%%%%
V = HSV(:,:,3);
% figure,imshow(V);
% title('Third plane of HSV image','color','Blue');
%%%%Probability Density Function Calculation%%%%%%%%
%pdf:Probability Density Function%%%%%%%%%%%%%%%%%%%
[counts, x] = imhist(V);
pdf = counts/(sum(counts));
% alph: adjusted parameter
alph = 0.75;
% --- Weighting Distribution -----
pdf_max = max(pdf);
pdf_min = min(pdf);
pdf_w = pdf_max*((pdf - pdf_min)./(pdf_max - pdf_min)).^alph; 
% --- weighted cdf -----
% lmax: maximum intensity of input
lmax_idx = (find(counts, 1, 'last'));
lmax = max(V(:));
sum_pdf_w = 0;
all_pdf_w = sum(pdf_w);
for i=1:lmax_idx
    sum_pdf_w = sum_pdf_w + pdf_w(i);
    cdf_w(i) = sum_pdf_w./all_pdf_w;
end

gamma = 1-cdf_w;
% ---- Enhancement ----
V = reshape(V,r*c,1);
T = zeros(size(V));
for i=1:lmax_idx
    L = V(V==x(i));
    T(V==x(i)) = lmax*(L./lmax).^gamma(i);
end
V2 = reshape(T,r,c);
hsv_image(:,:,3) = V2;
hsv_image(:,:,2) = HSV(:,:,2);
hsv_image(:,:,1) = HSV(:,:,1);
im_out = hsv2rgb(hsv_image);
im_out = uint8(im_out*255);                                         %Contrasted enhanced image
figure,imshow(im_out);
title('Output Image for alpha = 0.75','color','Blue');
% figure,imshowpair(img,im_out,'montage');
% title('input mage                                                             output image')
% d=gampdf(gamma,1);
% figure,plot(d);
% xlabel('intensity');
% ylabel('gamma')
compareimq(img,im_out);