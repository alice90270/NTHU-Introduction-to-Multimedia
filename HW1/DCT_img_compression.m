function [ output_args ] = DCT_img_compression ( input_args )
addpath(genpath('C:\Users\alice\OneDrive\文件\Github\NTHU-Introduction-to-Multimedia'));
% read image file
lalaland = imread('\data\lalaland.png');
img_HR = imread('\data\img_HR.png');
img_LR = imread('\data\img_LR.png');
thinker_grey_noised = imread('\data\thinker_gray_noised.jpg');
% Double
double_lalaand = im2double(lalaland);

% separate into 8x8 cells
lalalad_cell_8x8 =mat2cell(double_lalaand,8*ones(1,size(double_lalaand,1)/8),8*ones(1,size(double_lalaand,2)/8),3);

% 8x8 DCT
Base=zeros(8);
for i=0:7
    for j=0:7
        if i==0
            u=sqrt(1/8);
        else
            u=sqrt(2/8);
        end
        % formula
        Base(i+1,j+1)=u*cos(pi*(j+0.5)*i/8);
    end
end

% DCT Transform 3 dimesions
for i=1:8    
    for j=1:8
        for k=1:3
            DCT{i,j}(:,:,k)=Base*lalalad_cell_8x8{i,j}(:,:,k)*Base';
        end
    end
end
% n by n
%Convert cell array to ordinary array of the underlying data type
cell2mat(nbyn2)




% Check by build in function
DCT_functest=dct2(X);%用matlab中的函??行DCT??


% Compute the PSNR values of the three reconstructed images

% Unit8
im2uint8(lalaland);
% show image file
imshow(lalaland)
end

