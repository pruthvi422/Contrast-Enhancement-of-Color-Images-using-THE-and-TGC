
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
alph1 = 0.25;
alph2 = 0.75;
alph3 = 1;
alph4 = 2;
% --- Weighting Distribution -----
pdf_max = max(pdf);
pdf_min = min(pdf);
pdf_w1 = pdf_max*((pdf - pdf_min)./(pdf_max - pdf_min)).^alph1;
pdf_w2 = pdf_max*((pdf - pdf_min)./(pdf_max - pdf_min)).^alph2;
pdf_w3 = pdf_max*((pdf - pdf_min)./(pdf_max - pdf_min)).^alph3;
pdf_w4 = pdf_max*((pdf - pdf_min)./(pdf_max - pdf_min)).^alph4;
% --- weighted cdf -----
% lmax: maximum intensity of input
lmax_idx = (find(counts, 1, 'last'));
lmax = max(V(:));
sum_pdf_w = 0;
all_pdf_w1 = sum(pdf_w1);
for i=1:lmax_idx
    sum_pdf_w = sum_pdf_w + pdf_w1(i);
    cdf_w1(i) = sum_pdf_w./all_pdf_w1;
end
sum_pdf_w2 = 0;
all_pdf_w2 = sum(pdf_w2);
for i=1:lmax_idx
    sum_pdf_w2 = sum_pdf_w2 + pdf_w2(i);
    cdf_w2(i) = sum_pdf_w2./all_pdf_w2;
end

sum_pdf_w3 = 0;
all_pdf_w3 = sum(pdf_w3);
for i=1:lmax_idx
    sum_pdf_w3 = sum_pdf_w3 + pdf_w3(i);
    cdf_w3(i) = sum_pdf_w3./all_pdf_w3;
end

sum_pdf_w4 = 0;
all_pdf_w4 = sum(pdf_w4);
for i=1:lmax_idx
    sum_pdf_w4 = sum_pdf_w4 + pdf_w4(i);
    cdf_w4(i) = sum_pdf_w4./all_pdf_w4;
end

gamma1 = 1-cdf_w1;
gamma2 = 1-cdf_w2;
gamma3 = 1-cdf_w3;
gamma4 = 1-cdf_w4;
% ---- Enhancement ----
V = reshape(V,r*c,1);
T = zeros(size(V));
for i=1:lmax_idx
    L = V(V==x(i));
    T(V==x(i)) = lmax*(L./lmax).^gamma2(i);
end
V2 = reshape(T,r,c);
hsv_image(:,:,3) = V2;
hsv_image(:,:,2) = HSV(:,:,2);
hsv_image(:,:,1) = HSV(:,:,1);
im_out = hsv2rgb(hsv_image);
im_out = uint8(im_out*255);                                         %Contrasted enhanced image
% figure,imshow(im_out);
% figure,imshowpair(img,im_out,'montage');
% title('input mage                                                             output image')
d1=gampdf(gamma1,1);
d2=gampdf(gamma2,1);
d3=gampdf(gamma3,1);
d4=gampdf(gamma4,1);
figure;
plot(d1,'r');
hold on
plot(d2,'g');
plot(d3,'b');
plot(d4,'m');
xlabel('intensity');
ylabel('gamma')
title('Alpha Variations for Gamma plot')
legend('Alpha1=0.25','Alpha2=0.75','Alpha3=1','Alpha4=2')
compareimq(img,im_out);