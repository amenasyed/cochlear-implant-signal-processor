function Hd = butterBandPass(Fc1, Fc2)
%BUTTERBANDPASS Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.12 and DSP System Toolbox 9.14.
% Generated on: 07-Aug-2022 19:02:36

% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 16000;  % Sampling Frequency

N   = 12;    % Order
%Fc1 = 800;   % First Cutoff Frequency
%Fc2 = 1000;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');

% [EOF]
