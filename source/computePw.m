function Pw = computePw(n,poles)
arguments
    n (1,1) {mustBeInteger, mustBePositive}
    poles (1,:) = []
end

if isempty(poles)
    Pw = 1; 
    return 
end
poles = poles/1j;
Pw = poly(poles);

end