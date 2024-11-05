clc;
clear;
close all;


%%
% % 5th order Chebyshev
% n = 5;
% rl = 20;
% poles = [];

%% 
% Design and Performance Comparison of Novel High Q Coaxial Resonator Filter
% for Ka-band High Throughput Satellite. pg. 49
% n = 4;
% rl = 26;
% poles = [-1.9j 1.9j];

%%
% Design of Microwave Filters and Multiplexers in Waveguide Techology
% using Distributed Models. pg. 52
% N=4, f0=12 GHz, Bw=27 MHz, Tz1=11.968 GHz, Tz2=12.032 GHz.

% n = 4;
% rl = 20;
% poles = [-2.3672j 2.3672j];

%%
% Design of Microwave Filters and Multiplexers in Waveguide Techology
% using Distributed Models. pg. 55
% N=8, f0=12 GHz, Bw=72 MHz, Tz1=11.95 GHz, Tz2=12.05 GHz, Tz3=11.93 GHz,
% Tz4=12.07 GHz

% n = 8;
% rl = 20;
% poles = [-1.9388j -1.386j 1.386j 1.9388j];

%%
% Synthesis of coupled resonator filters using gradient optimization.
% % Amari ex. 1 
% n = 4;
% rl = 20;
% poles = [-1.81j 1.81j];

%%
% Synthesis of coupled resonator filters using gradient optimization.
% % Amari ex. 2 
% n = 6;
% rl = 20;
% poles = [-2.132j -1.592j 1.592j 2.132j];

%%
% Synthesis of coupled resonator filters using gradient optimization.
% % Amari ex. 3 
% n = 5;
% rl = 20;
% poles = [-2.452j -1.432j];

%%  
% % Cameron pg. 265
% n = 7;
% rl = 23;
% poles = [1.2576j 0.9218-0.1546j -0.9218-0.1546j];

%%
% % Cameron pg. 195
% n = 4;
% rl = 22;  
% poles = [1.3217j 1.8082j];

%%
% % Cameron pg. 800
% n = 4;
% rl = 22;
% poles = [-2.6207j 2.6207j];

%%
% % Cameron pg. 276 !!! THIS IS A CANONICAL EXAMPLE. eps_r NOT 1.
% n = 4;
% rl = 22;
% poles = [-3.7431j -1.8051j 1.5699j 6.1910j];



%%

nPoles = length(poles);
Pw = computePw(n,poles);
if mod(n-nPoles,2)
    Ps = poly(poles);   % n-nftz is odd
else
    Ps = (poly(poles))*1j; % for preserving unitary condition
end

[roots_Fw, Fw] = computeFw(n,poles);
roots_Fs = roots_Fw*1j;
Fs = poly(roots_Fs);

[eps,eps_r] = computeEps(n,rl,Pw,Fw,nPoles);

[roots_Ew, Ew] = computeEw(Pw,Fw,eps,eps_r);
roots_Es = roots_Ew*1j;

Es = poly(roots_Es);

%% Lossy transfer function calculation
Q0 = 4;
sigma = 1/Q0;
lossless = 0;   % lossless-> 1, lossy->0

lossy_Es_coeffs = addLoss(Es,sigma);
lossy_Es_roots = roots(lossy_Es_coeffs);
lossy_Ew_roots = -1j*lossy_Es_roots;
lossy_Ew = poly(lossy_Ew_roots);

lossy_Ps_coeffs = addLoss(Ps,sigma);
lossy_Ps_roots = roots(lossy_Ps_coeffs);
lossy_Pw_roots = -1j*lossy_Ps_roots;
lossy_Pw = poly(lossy_Pw_roots);

%% Matrix Synthesis ( Valid for lossless case)

[ABCD_num,ABCD_denum]= computeABCD(Es,Ps,Fs,eps,eps_r);
[y21_num, y22_num, y_denum, Kinf] = computeY(n,nPoles,Es,Fs,Ps,eps,eps_r);
M = synthesizeMatrix(n,y21_num, y22_num, y_denum, Kinf);

%% Transversal to Folded 

Mfold = transversal2Folded(n,M);

%% Data preparation

if lossless 
    charPolys = {Pw Fw Ew eps eps_r};
else
    charPolys = {lossy_Pw Fw lossy_Ew eps eps_r};
end
rootsPolys = {roots_Fs roots_Es};
couplingMatrix = M;

%% Plotting

plotMagResponse('ResponseBy', 'CharPoly', 'DataSource', charPolys);
%plotGroupDelay('ResponseBy', 'CharPoly', 'DataSource', rootsPolys);
plotMagResponse('ResponseBy', 'CouplingMatrix', 'DataSource', couplingMatrix);

