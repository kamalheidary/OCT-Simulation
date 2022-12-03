function [ Xaxis, Depth ] = OCT_Analyse( OCT_Signal, Ref, Lambda)
fspectrum = fftshift(fft(OCT_Signal-Ref));    %remove background
padorder = 4; %zero padding
padBord = length(fspectrum)*padorder;
Bspectrum = ifft(ifftshift([zeros(1,padBord) fspectrum' zeros(1,padBord)])'); %Broaded Spectrum
BdLambda = linspace(Lambda(1),Lambda(end),length(Bspectrum)); %new lambda
K_NL = (2*pi)./BdLambda; %Non Linear K
K_L = linspace(max(K_NL),min(K_NL),length(fspectrum)); %Linear K
SpecInterp = interp1(K_NL, Bspectrum, K_L,'spline'); %Resampling Data
Depth = abs(fftshift(fft(SpecInterp))); %Depth Information
Depth = Depth((end/2+1):end); %Remove Imagenary Part
dK = K_L(1) - K_L(2); %delta k
Z_max = pi/(2*dK);
Xaxis = linspace(0,Z_max,length(Depth));