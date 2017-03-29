% read image file
thinker_grey_noised = imread('\data\thinker_gray_noised.jpg');
% Double
double_thinker_grey_noised = im2double(thinker_grey_noised);

output2a=zeros(size(double_thinker_grey_noised));
output2b=zeros(size(double_thinker_grey_noised));
% the vector with zeros
double_thinker_grey_noised = padarray(double_thinker_grey_noised,[4 4]);

%Gaussian Kernel
kernal3x3 = fspecial('Gaussian',[3 3],0.3);
kernal9x9 = fspecial('Gaussian',[9 9],1);

%Window size
[x,y]=meshgrid(-4:4,-4:4);
M = size(x,1)-1;
N = size(y,1)-1;

% All move +i for positive indexs
output2a=zeros(size(double_thinker_grey_noised));
output2b=zeros(size(double_thinker_grey_noised));
double_thinker_grey_noised = padarray(double_thinker_grey_noised,[4 4]);
%Convolution
for i = 1:size(double_thinker_grey_noised,1)-M
    for j =1:size(double_thinker_grey_noised,2)-N
        % formula
        Temp1 = double_thinker_grey_noised(i:i+2,j:j+2,:).*kernal3x3;
        Temp2 = double_thinker_grey_noised(i:i+8,j:j+8,:).*kernal9x9;
        output2a(i,j,:)=sum(Temp1(:));
        output2b(i,j,:)=sum(Temp2(:));
    end
end

%Image without Noise after Gaussian blur
subplot(1,2,1),imshow(im2uint8(output2a));
subplot(1,2,2),imshow(im2uint8(output2b));