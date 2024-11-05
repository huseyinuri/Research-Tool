function Omega = f2W(freq,centerFreq,bandwidth)
Omega = (centerFreq/bandwidth)*(freq/centerFreq-centerFreq/freq);
end