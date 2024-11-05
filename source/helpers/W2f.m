function freq = W2f(Omega,centerFreq,bandwidth)
syms W0 f0 bw f

eqn=W0==f0/bw*(f/f0-f0/f); 
sol=solve(eqn,f);    %Solve the relationship between the real frequency and 
                   % normalized frequency based on transformation
f=sol(2);            %f has 2 solutions, take the correct one.
freq=vpa(subs(f,[f0 bw W0],[centerFreq bandwidth Omega]),4); 

end