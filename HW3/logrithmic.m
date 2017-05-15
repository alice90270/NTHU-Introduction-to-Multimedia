function [ residual ] = logrithmic ( Rimg, Timg, p, N )
Rimg= im2double(Rimg);
Timg= im2double(Timg);

startTime = cputime; % start time
[height, width, range] = size(Timg);%get image size
predictImg = zeros(height, width,3);
motionvectors = zeros(2, height*width/N^2);
totalSAD = 0;
count = 1;
stepMax = 2^(log2(p)-1);

% cut image to each 8X8 block
for x = 1 : N : height-N+1
	for y = 1 : N : width-N+1
        % cal middle SAD
		SAD = ones(3, 3) * 99999;
		SAD(2, 2)   = 0;
        SAD(2, 2) = sum(sum(sum(abs(Timg(x:x+N-1,y:y+N-1,:) - Rimg(x:x+N-1,y:y+N-1,:)))),3);
           
        %intial
        bX = x;
		bY = y;
        stepSize = stepMax;
        
        % calculate SAD 
        while(stepSize >= 1)
			mh = 1;
			for i = -stepSize : stepSize : stepSize
				mw = 1;
				for j = -stepSize : stepSize : stepSize
                    if(mh ~= 2 && mw ~= 2)
                        mw = mw + 1;
						continue;
                    end
                    row = bX + i;
					col = bY + j;
					
                    %if repeat
					if(mh == 2 && mw == 2)
                        mw = mw + 1;
						continue;
                    end
                     % beyond the boundary 
                    if(row < 1 || col < 1 || row+N-1 > height || col+N-1 > width)
                        mw = mw + 1;
						continue;
                    end
                    SAD(mh, mw) = 0;
                    SAD(mh, mw) = sum(sum(sum(abs(Timg(x:x+N-1,y:y+N-1,:) - Rimg(row:row+N-1,row:row+N-1,:)))),3);
					mw = mw + 1;
				end
				mh = mh + 1;
			end
			% find smallest SAD
			minSAD = SAD(1, 1);
			tempX = -stepSize;
			tempY = -stepSize;
            for mh = 1 : 3
				for mw = 1 : 3
					if(SAD(mh, mw) < minSAD)
						minSAD = SAD(mh, mw);
						tempX = (mh-1)*stepSize-stepSize;
						tempY = (mw-1)*stepSize-stepSize;
					end
				end
            end
            bX = bX + tempX;
			bY = bY + tempY;
            if(bX<=x-(p)||bX>=x+(p)||bY<=y-(p)||bY>=y+(p))
                if(bX <= x-(p))
                    bX = x-(p);                
                elseif(bX >= x+(p))
                    bX = x+(p);
                end
                if(bY <= y-(p))
                    bY = y-(p);
                elseif(bY >= y+(p))
                    bY = y+(p);
                end
                stepSize = stepSize / 2;
            end
            if(tempX==0&&tempY==0)
                stepSize = stepSize / 2;
            end

			SAD(2, 2) = minSAD;
        end
        % beyond boundary
        if(bX<1||bY<1||bX+N-1>height||bY+N-1>width)
            bX = x;
            bY = y;
        end
       
        motionvectors(1, count) = bX - x;
		motionvectors(2, count) = bY - y;
		totalSAD = totalSAD + minSAD;
        predictImg(x:x+N-1, y:y+N-1,:) = Rimg(x+motionvectors(1, count):x+motionvectors(1, count)+N-1, y+motionvectors(2, count):y+motionvectors(2, count)+N-1,:);
		count = count + 1;
	end
end
residual = sum(abs(Timg-predictImg),3);

nowtime = cputime;
time = nowtime - startTime;

%printf result
fprintf('2D logrithmic Search (range p=%d , block=%dx%d ) \n', p, N, N);
fprintf('(1)Time : %g\n',time);
fprintf('(2)SAD  : %g\n',totalSAD);
fprintf('(3)PSNR : %g\n',PSNR(Timg, predictImg));

end

