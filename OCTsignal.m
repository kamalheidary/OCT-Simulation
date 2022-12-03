%%% OCT Signal Simulator With MATLAB V. 1.1
%%% Aug 28 2021
%
clc
clearvars
% close all

%%%%%%%%%%%%%%%%%%%%
%%%       constants
%%%%%%%%%%%%%%%%%%%%

% lambda constants
lambda_c = 550e-9;    %center lambda
Bandwidth = 50e-9;    %spectrum bandwidth
d_lambda = 0.2e-9;    %delta lambda

% medium parameters
z0 = 10; %distance from source
N0 = 1; %refractive index of our medium
Ni = [1 1.5] ; %refractive indexes of our sample
Di = [200]*1e-6; % lengths of  our sample
Num_reflections = 1; %how many reflection we want to calculate

% space constants
Nx = 3; %number of pixels
Ny = 3;

x0_min = -5e-3;
x0_max =  5e-3;
y0_min = -5e-3;
y0_max =  5e-3;

wg = 200e-3;
%%%%%%%%%%%%%%%%%%%%
%       calculations
%%%%%%%%%%%%%%%%%%%%
% lambda
lambda_i = lambda_c - Bandwidth/2;
lambda_f = lambda_c + Bandwidth/2;
Llambda = Bandwidth /d_lambda+1;
lambda = linspace( lambda_i, lambda_f, Llambda - mod(Llambda, 2) );
AmpSpectrum =  gausswin( length(lambda), 3); %amplitude

% space
x0 = linspace(x0_min,x0_max,Nx);
y0 = linspace(y0_min,y0_max,Ny);
[x,y] = meshgrid(x0,y0);
dxo = x0(2) - x0(1);
dyo = y0(2) - y0(1);
r = sqrt(x.^2+y.^2);
A = exp(-(r/wg).^2);
N.Ni = Ni;
N.N0 = N0;
Ini.rfl = Num_reflections;

%%%%%%%%%%%%%%%%%%%%
%       Propagation
%%%%%%%%%%%%%%%%%%%%

% 1st arm (sample arm)
U_S = zeros(Nx, Ny, length(lambda));
OPL = N0*sqrt(x.^2+y.^2+z0^2);
Depth = zeros(1, length(lambda)/2);
for ii = 1 : length(lambda)
    Ini.lambda = lambda(ii);
    U.Ui = AmpSpectrum(ii).*A.*exp(1i.*OPL*2*pi/Ini.lambda); %initial wave for each wavelengths
    U_S(:, :, ii) = OCTsimulator(U, N, Di, Ini);
end
loopc = 1;
for i =1:loopc
    % 2nd arm (refrenc  e arm)
    rnd = normrnd(5,3,[1 10e+3]);
    t = 10e-6.*rnd;
    w = 1;
    
    for jj = 1: length(t)
        for ii = 1:length(lambda)
            U_r(:,:,ii) =0.4.*A.*AmpSpectrum(ii).*exp(1i.*(2*pi/lambda(ii))*(x*0+1)*(N0*z0+w*t(jj)));
        end
        I_sum = zeros(size(U_S));
        I_1 = zeros(size(U_S));
        U_sum = U_S + U_r;
        I_s = U_sum .* conj(U_sum);
        I_sum = I_s + I_sum;
        I_1r = U_r .* conj(U_r);
        I_1 = I_1r + I_1;
        
        
        % Interference
        I_OCT =  squeeze(I_sum(fix(end/2),fix(end/2),:));
        I_1 = squeeze(I_1(fix(end/2),fix(end/2),:));
        I_2 = U_S .* conj(U_S);
        I_2 = squeeze(I_2(fix(end/2),fix(end/2),:));
        ref  = I_1 + I_2;
        
        %Analyse and plot
        [ Xaxis, Depth1 ] = OCT_Analyse(I_OCT, ref, lambda);
        Depth = Depth1 + Depth;
        clear('I_1', 'I_2', 'I_OCT', 'U_r', 'I_sum' ,'I_s' ,'ref' ,'I_1r')
    end
end
Depth = Depth./loopc;
figure
plot(Xaxis(10:end), Depth(10:end))