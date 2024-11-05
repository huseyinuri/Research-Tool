function plotMagResponse(options)
% Argument validation using name-value pairs
arguments
    % Name-value pairs: Specify defaults for optional inputs
    options.ResponseBy (1,:) char {mustBeMember(options.ResponseBy, {'CharPoly', 'CouplingMatrix'})} = 'CharPoly'  % Default is 'CharPoly'
    options.DataSource {isCharPolyOrCM}    % Data source must be numeric (charpoly or cm)
end

% Extract name-value pairs from options
responseBy = options.ResponseBy;
dataSource = options.DataSource;

w = -5:0.01:5;


% Check the input type: array or matrix
switch lower(responseBy)
    case 'charpoly'
        if iscell(dataSource)
            Pw = dataSource{1};
            Fw = dataSource{2};
            Ew = dataSource{3};
            eps = dataSource{4};
            eps_r = dataSource{5};
            for ii = 1:numel(w)
                S21(ii) = polyval(Pw,w(ii))/polyval(Ew,w(ii))/eps;
                S11(ii) = polyval(Fw,w(ii))/polyval(Ew,w(ii))/eps_r;
            end
            S21_dB = 20*log10(abs(S21));
            S11_dB = 20*log10(abs(S11));
            hold on
            plot(w,S21_dB);
            plot(w,S11_dB);
            hold off
            xticks(-5:1:5);
            grid on

        else
            error('Data source is not Characteristic Polynomials');
        end
    case 'couplingmatrix'
        if ismatrix(dataSource) && ~isvector(dataSource)
                M = dataSource;
                Q0 = 4;
                
                [~,n] = size(M);
                
                sig = (1/Q0)*eye(n);
                U = eye(n); U(1,1) = 0; U(end,end) = 0;
                R = zeros(n); R(1,1) = 1; R(end,end) = 1;
                for ii = 1:numel(w)
                    A = w(ii)*U - 1j*R + (M - 1j*sig);
                    A_inv = inv(A);
                    S21(ii) = -2*1j*A_inv(end,1);
                    S11(ii) = 1+2*1j*A_inv(1,1);
                end
                S21_dB = 20*log10(abs(S21));
                S11_dB = 20*log10(abs(S11));
                hold on
                plot(w,S21_dB);
                plot(w,S11_dB);
                hold off
                xticks(-5:1:5);
                grid on
            
        else
            error('Data source is not a Coupling Matrix');
        end
    otherwise
        error('Unsupported data is given');

end

end

function isCharPolyOrCM(C)
if iscell(C)
    X = cellfun(@isnumeric,C)&length(C)==5;
    assert(all(X(:)),'Input must be either cell array or coupling matrix');
else
    assert((ismatrix(C) && ~isvector(C)),'Input must be either cell array or coupling matrix');
end
end


