function [y21_num,y22_num,y_denum,Kinf] = computeY(n,nPoles,Es,Fs,Ps,eps,eps_r)
arguments
    n (1,1) {mustBeInteger, mustBePositive}
    nPoles (1,1) {mustBeInteger}
    Es (1,:)
    Fs (1,:)
    Ps (1,:)
    eps (1,1)
    eps_r (1,1)
end
EPlusF = Es + Fs/eps_r;

if mod(n,2)
    m1 = zeros(1,numel(Es));
    m1(1:2:end) = 1j*imag(EPlusF(1:2:end));
    m1(2:2:end) = real(EPlusF(2:2:end));

    n1 = zeros(1,numel(Es));
    n1(1:2:end) = real(EPlusF(1:2:end));
    n1(2:2:end) = 1j*imag(EPlusF(2:2:end));

    y21_num = Ps/eps/n1(find(n1,1));
    y22_num = m1/n1(find(n1,1));
    y_denum = n1/n1(find(n1,1));
else
    m1 = zeros(1,numel(Es));
    m1(1:2:end) = real(EPlusF(1:2:end));
    m1(2:2:end) = 1j*imag(EPlusF(2:2:end));

    n1 = zeros(1,numel(Es));
    n1(1:2:end) = 1j*imag(EPlusF(1:2:end));
    n1(2:2:end) = real(EPlusF(2:2:end));

    y21_num = Ps/eps/m1(find(m1,1));
    y22_num = n1/m1(find(m1,1));
    y_denum = m1/m1(find(m1,1));
end

if nPoles == n
    Kinf = eps*(eps_r-1)/eps_r;
    y21_num = y21_num - 1j*Kinf*y_denum;
elseif nPoles < n
    Kinf = 0;
else
    error('Number of poles cannot be greater than the filter order');
end
end