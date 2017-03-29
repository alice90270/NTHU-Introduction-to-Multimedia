img_LR = imread('\data\img_LR.png');
input = im2double(img_LR);
output3b(250*4,250*4,3) = 0;
for(i = 5:1000)
    for(j = 5:1000)
        for(k = 1:3)
            a = ceil(i/4);
            b = ceil(j/4);
            %weighted sum of the neighbor
            output3b(i,j,k) = (a-i/4)*(b-j/4)*input(a-1,b-1,k) + (a-i/4)*(j/4-b+1)*input(a-1,b,k) + (i/4-a+1)*(b-j/4)*input(a,b-1,k) + (i/4-a+1)*(j/4-b+1)*input(a,b,k);
        end
    end
end
imshow(im2uint8(output3b));
psnr=psnr(output3b, img_HR);