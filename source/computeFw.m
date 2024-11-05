function [roots_Fw,Fw] = computeFw(n,poles)
arguments
    n (1,1) {mustBeInteger, mustBePositive}
    poles (1,:) = inf
end
syms w
w_prime = sqrt(w^2 - 1);
if isinf(poles)
    Fw = sym2poly(chebyshevT(n,w)); % TODO:return chebyshev roots
    return 
end

poles = poles/1j;
inf_poles = Inf(1,n-length(poles));
poles = [poles inf_poles];

% recursive execution
% base case
%U = sym(zeros(1,n)); V = sym(zeros(1,n));
U = cell(1,n); V = cell(1,n);
U1 = w - 1/poles(1);
U{1} = U1;
V1 = w_prime * sqrt(1-1/poles(1)^2);
V{1} = V1;

% iterative part
for ii = 2:length(poles)
    if isinf(poles(ii))
        U{ii} = w*U{ii-1} + w_prime*V{ii-1};
        V{ii} = w*V{ii-1} + w_prime*U{ii-1};
    else
        U{ii} = w*U{ii-1} - U{ii-1}/poles(ii) + w_prime*sqrt(1-1/poles(ii)^2)*V{ii-1};
        V{ii} = w*V{ii-1} - V{ii-1}/poles(ii) + w_prime*sqrt(1-1/poles(ii)^2)*U{ii-1};
    end
end
Un = vpa(simplify(U{n}),4);
num_Cw = sym2poly(Un);
roots_Fw = roots(num_Cw); % roots of the Cw is equal to reflection zeros
Fw = poly(roots_Fw);
end