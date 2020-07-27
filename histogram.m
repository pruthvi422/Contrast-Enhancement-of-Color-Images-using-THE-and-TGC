clc;
clear all;
close all;
x=imread('ucid00008.tif');
figure
imshow(x)
x1=rgb2gray(x);
figure
imhist(x1)