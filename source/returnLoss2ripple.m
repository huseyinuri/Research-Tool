function ripple = returnLoss2ripple(rl)
ripple = -10*log10(1-10^(-rl/10));
end