function [ABCD_num,ABCD_denum] = computeABCD(Es,Ps,Fs,eps,eps_r)
arguments
    Es (1,:)
    Ps (1,:)
    Fs (1,:)
    eps (1,1)
    eps_r (1,1)
end
EPlusF = Es + Fs/eps_r;
EMinusF = Es - Fs/eps_r;

ABCD_num = zeros(4,numel(Es));
ABCD_denum = 1j*Ps/eps;

% As
ABCD_num(1,1:2:end) = 1j*imag(EPlusF(1:2:end));
ABCD_num(1,2:2:end) = real(EPlusF(2:2:end));
% Bs
ABCD_num(2,1:2:end) = real(EPlusF(1:2:end));
ABCD_num(2,2:2:end) = 1j*imag(EPlusF(2:2:end));
% Cs    
ABCD_num(3,1:2:end) = real(EMinusF(1:2:end));
ABCD_num(3,2:2:end) = 1j*imag(EMinusF(2:2:end));
% Ds    
ABCD_num(4,1:2:end) = 1j*imag(EMinusF(1:2:end));
ABCD_num(4,2:2:end) = real(EMinusF(2:2:end));

ABCD_num(abs(ABCD_num) < 1e-8) = 0;
end

