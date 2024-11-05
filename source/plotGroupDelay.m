function plotGroupDelay(options)
% Argument validation using name-value pairs
arguments
    % Name-value pairs: Specify defaults for optional inputs
    options.ResponseBy (1,:) char {mustBeMember(options.ResponseBy, {'CharPoly', 'CouplingMatrix'})} = 'CharPoly'  % Default is 'CharPoly'
    options.DataSource {isCharPolyOrCM}    % Data source must be numeric (charpoly or cm)
end

% Extract name-value pairs from options
responseBy = options.ResponseBy;
dataSource = options.DataSource;

w = -6:0.01:6;

% Check the input type: array or matrix
switch lower(responseBy)
    case 'charpoly'
        if iscell(dataSource)
            roots_Es = dataSource{2};
            sigma_Es = real(roots_Es); omega_Es = imag(roots_Es);
            groupDelay = 0;
            phase = 0;
            for ii = 1:numel(roots_Es)
                phase = phase + atand((w-omega_Es(ii))/sigma_Es(ii));
                groupDelay = groupDelay - (sigma_Es(ii) ./ (sigma_Es(ii)^2+(w- omega_Es(ii)).^2));
            end
            hold on
            %plot(w,groupDelay);
            plot(w,phase);
            hold off
            xticks(-6:1:6);
            grid on

        else
            error('Data source is not Characteristic Polynomials');
        end
    case 'couplingmatrix'
        if ismatrix(dataSource) && ~isvector(dataSource)
            surface(dataSource);
        else
            error('Data source is not a Coupling Matrix');
        end
    otherwise
        error('Unsupported data is given');

end
end

function isCharPolyOrCM(C)
if iscell(C)
    X = cellfun(@isnumeric,C)&length(C)==2;
    assert(all(X(:)),'Input must be either cell array or coupling matrix');
else
    assert((ismatrix(C) && ~isvector(C)),'Input must be either cell array or coupling matrix');
end
end