clc;
clear all;
close all;
I=imread('ucid00008.tif');
I1=rgb2gray(I);
figure
imshow(I);
impixelinfo;
figure
imshow(I);
pixevalue=impixel
figure
imshow(I1);
I2=imadjust(I1);
figure
imshow(I2);
figure
imhist(I1);
figure
imhist(I2);
info1=imfinfo('ucid00008.tif')
impixel(I,25,45)
impixel(I,:,:)
