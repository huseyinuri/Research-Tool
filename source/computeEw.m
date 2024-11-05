function [roots_Ew,Ew] = computeEw(Pw,Fw,eps,eps_r)
arguments
    Pw (1,:)
    Fw (1,:)
    eps (1,1) %{mustBePositive}
    eps_r (1,1) %{mustBePositive}
end

% Alternating pole method. Cameron pg. 188

nPw = length(Pw); nFw = length(Fw);
if nPw < nFw
    Pw = [zeros(1, nFw-nPw), Pw];
end
rhs1 = eps_r*Pw - 1j*eps*Fw;
alt_roots = roots(rhs1);
hasImg = any(imag(alt_roots(:))); % make sure that roots have imaginary part.
pos_roots = alt_roots(hasImg & imag(alt_roots) > 0); % takes the upper half-w plane roots.
neg_roots = alt_roots(hasImg & imag(alt_roots) < 0); % takes the lower half-w plane roots.
roots_Ew = [pos_roots;conj(neg_roots)];
Ew = poly(roots_Ew);

end