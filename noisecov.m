%This is for simulation only

%SNR=40; Maximize signa-to-noise ratio
%sigma=10^(-SNR/20);
%N=10;
%r=sigma*randn(N);
%V=cov(r);
%figure, imagesc(V);
%mean(diag(V))

y1 = wgn(1000, 1, -30); % a 1000-element white noise with power -30dBW
var(y1)

%-30dBW = 0.000001 Watt