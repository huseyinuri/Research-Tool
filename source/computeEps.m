function [eps,eps_r] = computeEps(n,rl,Pw,Fw,nPoles)
arguments
    n (1,1) {mustBeInteger, mustBePositive}
    rl (1,1) {mustBePositive}
    Pw (1,:)
    Fw (1,:)
    nPoles (1,1) {mustBeInteger}
end

if nPoles < n % non-canonical case
    eps = (1/sqrt(10^(0.1*rl)-1)) * abs(polyval(Pw,1)/polyval(Fw,1));
    eps_r = 1;
elseif nPoles == n
    eps = (1/sqrt(10^(0.1*rl)-1)) * abs(polyval(Pw,1)/polyval(Fw,1));
    eps_r = eps/sqrt(eps^2-1);
else
    error('Number of poles cannot be greater than the filter order')
end
end

