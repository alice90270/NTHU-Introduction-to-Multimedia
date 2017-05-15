function [ residual ] = fullsearch( Rimg, Timg, p, N)
startTime = cputime; % start time
[height, width, range] = size(Timg);%get image size
Timg=im2double(Timg);
Rimg=im2double(Rimg);
motionvectors = zeros(2, height*width/N^2);
predictImg = zeros(height, width, 3);
Total = 0;
count = 1;

% cut image to each NxN block 
for x = 1 : N : height-N+1
	for y = 1 : N : width-N+1
        % initial
		SAD = ones(2*p+1, 2*p+1) * 99999; 
        minSAD = 99999;
		motionvectors(1, count) = -p;
		motionvectors(2, count) = -p;
		% search range (2p+1)*(2p+1)
        for i = -p : p
			for j = -p : p
				row = x + i;
				col = y + j;
                if(row < 1 || col < 1 || row+N-1 > height || col+N-1 > width)
					continue;
                end
                SAD(i+p+1, j+p+1) = sum(sum(sum(abs(Timg(x:x+N-1,y:y+N-1,:) - Rimg(x+i:x+i+N-1,y+j:y+j+N-1,:)))),3);
                % find minimun SAD
                if(SAD(i+p+1,j+p+1)< minSAD)
					minSAD = SAD(i+p+1,j+p+1);
					motionvectors(1, count) = i;
					motionvectors(2, count) = j;
				end
            end
        end
		Total = Total + minSAD;
        predictImg(x:x+N-1, y:y+N-1,:) = Rimg(x+motionvectors(1, count):x+motionvectors(1, count)+N-1, y+motionvectors(2, count):y+motionvectors(2, count)+N-1, :);
		count = count + 1;
	end
end

residual = sum(abs(Timg-predictImg),3);

nowtime = cputime;
time = nowtime - startTime;


%printf result
fprintf('Full Search (range p=%d , block=%dx%d ) \n', p, N, N);
fprintf('(1)Time : %g\n',time);
fprintf('(2)SAD  : %g\n',Total);
fprintf('(3)PSNR : %g\n',PSNR(Timg, predictImg));
end
