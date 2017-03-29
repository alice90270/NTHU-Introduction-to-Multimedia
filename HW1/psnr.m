function PSNR = psnr(distImg, origImg)
        origImg = double(origImg);
        distImg = double(distImg);

        [M N P] = size(origImg);
        error = origImg - distImg;
        MSE = sum(sum(sum(error.^2))) / (M * N * P);

        if(MSE > 0)
            PSNR = 20*log10(max(max(max(origImg))))-10*log10(MSE);
        else
            PSNR = 99;
        end    
