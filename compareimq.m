% function [] = compareimq(img1, img2)
% Compares histogram and MAD of two images of the same size and type. This
% is an extension of a file compare.m written by Marcus Rodan as part of
% ET2584 during summer 2016.
% Ver 1.1 2016-07-18. Still under development. Benny L.

function [] = compareimq(img1, img2)
    s = size(img1);
    figure(10)
    subplot(2,2,1);
    imshow(img1);
    title('Image 1');
    subplot(2,2,2);
    imshow(img2);
    title('Image 2');
    subplot(2,2,3);
    if length(s) == 3
      hsvimg1 = rgb2hsv(img1);
      vimg1 = hsvimg1(:,:,3);   % Select only intensity of image
      mad = median(abs(vimg1(:)-median(vimg1(:))));
      imhist(vimg1);
      title(['Histogram of Image 1. MAD=' num2str(mad,2)]);
      subplot(2,2,4);
      hsvimg2 = rgb2hsv(img2);
      vimg2 = hsvimg2(:,:,3);   % Select only intensity of image
      mad = median(abs(vimg2(:)-median(vimg2(:))));
      imhist(hsvimg2(:,:,3));
      title(['Histogram of Image 2. MAD=' num2str(mad,2)]);
      showcolorhist(img1,101);title('Colour histogram of Image 1')
      showcolorhist(img2,102);title('Colour histogram of Image 2')
    else
      img1 = double(img1);
      img1 = img1/max(img1(:));
      mad = median(abs(img1(:)-median(img1(:))))
      imhist(img1);
      title(['Histogram of Image 1. MAD=' num2str(mad,2)]);
      subplot(2,2,4);
      img2 = double(img2);
      img2 = img2/max(img2(:));
      mad = median(abs(img2(:)-median(img2(:))));
      imhist(img2);
      title(['Histogram of Image 2. MAD=' num2str(mad,2)]);
    end
end

