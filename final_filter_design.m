tic

D = "T5";
s = D+'.wav';
N = 12;
[y, Fs] = audioread(s);

% If stereo, make it single channel
sampleSize = size(y);

if (sampleSize(2) > 1)
    yMono = sum(y, 2) / size(y, 2);
end

% play
sound(y, Fs);

%write
% audiowrite('test252.wav', y , Fs);

%plotting audio as a function of sample num
sampleFunc = linspace(1, sampleSize(1), sampleSize(1));
figure;
plot(sampleFunc, y);

%  downsample it to 16 kHz
if Fs > 16000
    y = resample(y, 16000, Fs);
end
   

%cosine function
newSize = size(y);
time = newSize(1)/16000;
x = linspace(0, time, newSize(1));
cosine = cos(2000*pi*x);
figure;
plot(x, cosine);
%sound(cosine, Fs);

%Phase 2: filter design

% human hearing bounds in mels
upperMels = hz2mel(8000);
lowerMels = hz2mel(100);

% split determined bounds into N channels
channelInMel = linspace(lowerMels, upperMels, N + 1);

% convert from mels to hz
channelInFreq = mel2hz(channelInMel);

nArray = ones(N + 1);

% plot evenly splitted channels both in Hz and mels
figure;
plot(channelInFreq, nArray, '-o');
figure;
plot(channelInMel, nArray, '-x');

% this array will store the channels of input sound during filtering
inputChannels = [];

%task 5: filter the sound with a passband bank
Fp1 = 0;
Fp2 = 0;

for n=1:12
    Fp1 = channelInFreq(n);
    Fp2 = channelInFreq(n+1);
    
    if n == 12
        hd = chevFilter(6431, 8000);
    else
        hd = chevFilter(Fp1, Fp2);
    end

    outputFiltered = filter(hd,y);

    inputChannels = [inputChannels; [transpose(outputFiltered)]];
    
    % task 6: plot the output signal of the lowest and highest frequency channels
    if n==1
        figure;
        plot(outputFiltered);
        title('channel 1');
        xlabel('Time');
        ylabel('Amplitude');
    end
    
    if n==12
        figure;
        plot(outputFiltered);
        title('channel 12');
        xlabel('Time');
        ylabel('Amplitude');
    end
    
end % of the for loop that iterates throught the channels 1-12


% task 7: rectify
rectifiedOutput = abs(inputChannels);

% task 8:  detect the envelopes of all rectified signals using a lowpass filter
envelopedInput = zeros(N, length(y));

lowpass = chevLowPass();
for n = 1:12
    envelopedFilter = filter(lowpass, rectifiedOutput(n, :));
    envelopedInput(n, :) = envelopedFilter;

end

% task 9: plot the extracted envelope of the lowest and highest frequency channels
lowLength = length(inputChannels(1, :));

     samplePlot = linspace(1, lowLength, lowLength);
     figure;
     plot(samplePlot, abs(envelopedInput(1, :)));
     title('Lowest Frequency Channel');
     xlabel('sample');
     ylabel('magnitude');
 
     samplePlot = linspace(1, lowLength, lowLength);
     figure;
     plot(samplePlot, abs(envelopedInput(N, :)));
     title('Highest Frequency Channel');
     xlabel('sample');
     ylabel('magnitude');

% task 10: genereate signal using cosine function
cosineSignals = zeros(N, length(y));

for n=1:12
    time = lowLength/16000;
    x = linspace(0, time, lowLength);

    centerHz = sqrt(channelInFreq(n)*channelInFreq(n+1));

    cosine = cos(centerHz*2*pi*x);
    cosineSignals(n, :) = cosine;
end

% task 11:  amplitude modulates the cosine signal of Task 10 using the rectified signal of that channel
amplitudeSignals = zeros(N, length(y));

for n=1:12
   amplitudeSignals(n, :) = envelopedInput(n, :) .* cosineSignals(n, :) ;
end

% task 12: Add all signals and Normalize this signal by the maximum of its absolute value

outputSignals = zeros(1, lowLength);

for n=1:12
    outputSignals = outputSignals + amplitudeSignals(n, :) ;
end

% normalize by abs
maxAbs = max(abs(outputSignals));

outputSignals = outputSignals/maxAbs;

% task 13: play and write
sound(outputSignals, Fs-2000)

audiowrite((D + "OUT.wav"), outputSignals, Fs);

toc

