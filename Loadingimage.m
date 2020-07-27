clc;
clear all; 
close all;
I=imread('ucid00029.tif');
image(I)
A=imresize(I,[256 256]);
imwrite(A,'new.jpg')
figure
image(A)
whos
info1=imfinfo('ucid00029.tif')
info2=imfinfo('new.jpg')
r=I(:,:,1);
g=I(:,:,2);
b=I(:,:,3);
figure;
imshow(r);
figure;
imshow(g);
figure;
imshow(b);
% figure;
% imshowpair(r,g,'montage');
% title('Red Channel                                                           Green Channel')
 I(5,5,:)
 I_gray=rgb2gray(I);
 figure;
% image(I_gray);
% figure;
 imhist(I_gray);
% I2=imadjust(I_gray);
% figure;
% image(I2);
% figure;
% imhist(I2);