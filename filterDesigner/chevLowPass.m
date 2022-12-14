                                                                                                                                                                                              % Chebyshev Type I Lowpass filter designed using FDESIGN.LOWPASS.
function Hd = chevLowPass
% All frequency values are in Hz.
Fs = 16000;  % Sampling Frequency

N     = 12;   % Order
Fpass = 400;  % Passband Frequency
Apass = 1;    % Passband Ripple (dB)

% Construct an FDESIGN object and call its CHEBY1 method.
h  = fdesign.lowpass('N,Fp,Ap', N, Fpass, Apass, Fs);
Hd = design(h, 'cheby1');

% [EOF]
