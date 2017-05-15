img72= imread('./data/frame72.jpg');
img73= imread('./data/frame73.jpg');
img81= imread('./data/frame81.jpg');
img85= imread('./data/frame85.jpg');

%A
fprintf('================A===============\n');
%FS
residual1=fullsearch(img72, img73, 8, 8);
imwrite(residual1,'fs_img72_73_8_8.jpg');
figure(1);
subplot(4, 1, 1);imshow(residual1);
title('fs range p=8 , block=8x8');  
residual2=fullsearch(img72, img73, 8, 16);
imwrite(residual2,'fs_img72_73_8_16.jpg');
subplot(4, 1, 2);imshow(residual2);
title('fs range p=8 , block=16x16');
residual3=fullsearch(img72, img73, 16, 8);
imwrite(residual3,'fs_img72_73_16_8.jpg');
subplot(4, 1, 3);imshow(residual3);
title('fs range p=16 , block=8x8');  
residual4=fullsearch(img72, img73, 16, 16);
imwrite(residual4,'fs_img72_73_16_16.jpg');
subplot(4, 1, 4);imshow(residual4);
title('fs range p=16 , block=16x16');  
%2D
residual9=logrithmic(img72, img73, 8, 8);
imwrite(residual9,'log_img72_73_8_8.jpg');
figure(2);
subplot(4, 1, 1);imshow(residual9);
title('2D log range p=8 , block=8x8');  
residual10=logrithmic(img72, img73, 8, 16);
imwrite(residual10,'log_img72_73_8_16.jpg');
subplot(4, 1, 2);imshow(residual10);
title('2D log range p=8 , block=16x16');  

residual11=logrithmic(img72, img73, 16, 8);
imwrite(residual11,'log_img72_73_8_16.jpg');
subplot(4, 1, 3);imshow(residual11);
title('2D log range p=8 , block=16x16');  

residual12=logrithmic(img72, img73, 16, 16);
imwrite(residual12,'log_img72_73_16_16.jpg');
subplot(4, 1, 4);imshow(residual12);
title('2D log range p=16 , block=16x16');  


fprintf('=================B==============\n');

%B
%FS
residual5=fullsearch(img72, img81, 8, 8);
imwrite(residual5,'fs_img72_81_8_8.jpg');
figure(3);
subplot(4, 1, 1);imshow(residual5);
title('fs range p=8 , block=8x8');  
residual6=fullsearch(img72, img81, 8, 16);
imwrite(residual6,'fs_img72_81_8_16.jpg');
subplot(4, 1, 2);imshow(residual6);
title('fs range p=8 , block=16x16');  
residual7=fullsearch(img72, img81, 16, 8);
imwrite(residual7,'fs_img72_81_16_8.jpg');
subplot(4, 1, 3);imshow(residual7);
title('fs range p=16 , block=8x8');  
residual8=fullsearch(img72, img81, 16, 16);
imwrite(residual8,'fs_img72_81_16_16.jpg');
subplot(4, 1, 4);imshow(residual8);
title('fs range p=16 , block=16x16');  
%2D log
residual13=logrithmic(img72, img81, 8, 8);
imwrite(residual13,'log_img72_81_8_8.jpg');
figure(4);
subplot(4, 1, 1);imshow(residual13);
title('2D log range p=8 , block=8x8');  
residual14=logrithmic(img72, img81, 8, 16);
imwrite(residual14,'log_img72_81_8_16.jpg');
subplot(4, 1, 2);imshow(residual14);
title('2D log range p=8 , block=16x16');  
residual15=logrithmic(img72, img81, 16, 8);
imwrite(residual15,'log_img72_81_16_8.jpg');
subplot(4, 1, 3);imshow(residual15);
title('2D log range p=16 , block=8x8');  
residual16=logrithmic(img72, img81, 16, 16);
imwrite(residual16,'log_img72_81_16_16.jpg');
subplot(4, 1, 4);imshow(residual16);
title('2D log range p=16 , block=16x16');

fprintf('================Q2===============\n');
figure(5);
residual_bi = bi_directional( img72, img85, img81, 8, 8 );
imwrite(residual_bi,'bi_img72_85_81_8_8.jpg');
imshow(residual_bi);
title('bi directional range p=8 , block=8x8');  