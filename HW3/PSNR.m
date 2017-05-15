function [ output ] = PSNR( image_origin, image_later )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% convert both the image to double.
image_origin = double(image_origin);
image_later = double(image_later);
% Find the mean squared error
mse = sum((image_origin(:)-image_later(:)).^2) / prod(size(image_origin));
% now find the psnr, as peak=255
output = 10*log10(255*255/mse); 
end

