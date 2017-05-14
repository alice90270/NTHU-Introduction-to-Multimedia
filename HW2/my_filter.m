function [outputSignal, outputFilter] = my_filter(inputSignal, fsample, N, windowName, filterName, fcutoff)
%%% Input 
% inputSignal: input signal
% fsample: sampling frequency
% N : size of FIR filter(odd)
% windowName: 'Blackmann'
% filterName: 'low-pass', 'high-pass', 'bandpass', 'bandstop' 
% fcutoff: cut-off frequency or band frequencies
%       if type is 'low-pass' or 'high-pass', para has only one element         
%       if type is 'bandpass' or 'bandstop', para is a vector of 2 elements

%%% Ouput
% outputSignal: output (filtered) signal
% outputFilter: output filter 

%% 1. Normalization (p.80)
fcutoff=fcutoff/fsample; 
w_c=2*pi*fcutoff;
mid=floor(N/2); % dropping remainder


%% 2. Create the filter according the ideal equations (slide #76)
% (Hint) Do the initialization for the outputFilter here

    if strcmp(filterName,'low-pass') == 1
        for n=-mid:mid
            % avoid n=0
            if(n~=0)
                h_ideal(mid+1+n)=sin(w_c*n)/(pi*n);
            else
                h_ideal(mid+1+n)=2*fcutoff;
            end
        end      
    end
    if strcmp(filterName,'high-pass') == 1
        for n=-mid:mid
            % avoid n=0
            if(n~=0)
                h_ideal(mid+1+n)=-sin(w_c*n)/(pi*n);
            else
                h_ideal(mid+1+n)=1-2*fcutoff;
            end
        end
    end
    % cutoff has two fcutoffs: fcutoff(1), fcutoff(2)
    if strcmp(filterName,'bandpass') == 1
       for n=-mid:mid
            % avoid n=0
            if(n~=0)
                h_ideal(mid+1+n)= (sin(w_c(2)*n)/(pi*n)) - (sin(w_c(1)*n)/(pi*n)) ;
            else
                h_ideal(mid+1+n)= 2*(fcutoff(2)-fcutoff(1));
            end
       end
    end
    if strcmp(filterName,'bandstop') == 1
        for n=-mid:mid
            % avoid n=0
            if(n~=0)
                h_ideal(mid+1+n)= sin(w_c(1)*n)/(pi*n) - sin(w_c(2)*n)/(pi*n);
            else
                h_ideal(mid+1+n)=1-2*(fcutoff(2)-fcutoff(1));
            end
        end
    end

%% 3. Create the windowing function (slide #80) and Get the realistic filter
if strcmp(windowName,'Blackman') == 1 
    for n=1:N
        w(n)=0.42-0.5*cos(2*pi*n/(N-1))+0.08*cos(4*pi*n/(N-1));
        h_ideal(n)=h_ideal(n)*w(n);
    end
end
outputFilter= h_ideal;
%% 4. Filter the input signal in time domain. Do not use matlab function 'conv'
outputSignal = zeros( length(inputSignal) , 1);
len_input=length(inputSignal);
for n=1:len_input
    for m=1:N
        if(n-m)>0
            outputSignal(n)=outputSignal(n) + h_ideal(m)*inputSignal(n-m+1);
        end
    end
end


