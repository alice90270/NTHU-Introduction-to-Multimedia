img_LR = imread('\data\img_LR.png');
img_HR = imread('\data\img_HR.png');
input= im2double(img_LR);

output3a(250*4,250*4,3) = 0;
im2double(output3a);
for(i = 1:1000)
    for(j = 1:1000)
        for(k = 1:3)
        a = round(i/4);
        b = round(j/4);
        if(a==0)
            a=1;
        end
        if(b==0)
            b=1;
        end
        output3a(i,j,k) = input(a,b,k);
        end
    end
end
imshow(im2uint8(output3a));
psnr=psnr(output3a, img_HR);

