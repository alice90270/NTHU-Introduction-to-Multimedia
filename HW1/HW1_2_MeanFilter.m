% read image file
thinker_grey_noised = imread('\data\thinker_gray_noised.jpg');
% Double
thinker_grey_noised = im2double(thinker_grey_noised);

output2c=zeros(size(double_thinker_grey_noised));
output2d=zeros(size(double_thinker_grey_noised));

edgex = round(size(window,1) / 2) 
edgey = round(size(window,2)/ 2)

for x=edgex:size(thinker_grey_noised,1)-edgex
    for y=edgey:size(thinker_grey_noised,2)-edgey
        i=0
        for fx=0:size(window,1)
            for fy=0:size(window,2)
                window(i) = inputPixelValue(x+fx-edgex, y+fy-edgey);
                i=i+1;
            end
        end
        sort(window)
        output2c(x,y)= window(size(window,1)*size(window,2)/2)
    end
end

subplot(1,2,1),imshow(im2uint8(output2c));
subplot(1,2,2),imshow(im2uint8(output2d));