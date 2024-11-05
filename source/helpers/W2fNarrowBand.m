function freq = W2fNarrowBand(Omega,centerFreq,bandwidth)
syms W0 f0 bw f

eqn=W0==2*(f-f0)/bw; 
sol=solve(eqn,f);    %Solve the relationship between the real frequency and 
                   % normalized frequency based on transformation
f=sol(1);            %f has 2 solutions, take the correct one.
freq=vpa(subs(f,[f0 bw W0],[centerFreq bandwidth Omega]),4); 
end