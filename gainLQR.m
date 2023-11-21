function [KV, K0, P, cloop_poles] = gainLQR(Gxd_A_obs,Gxd_B_obs,Gxd_C_obs,Q_X,R_X,t_samp)
%Using this function one finds the Linear Quadratic Regulator gain matrix for a given
%system and given weighting matrices Q and R (which are positive!).
%In order to implement in simulink, K0 is calculated and represents the
%inverse of the dcgain. 

%All equations below are for discrete time systems!
%x(k+1) = Gx(k) + Hu(k), y(k) = Cx(k)

%Feedback gain matrix and closed loop poles obtained

n = size(Gxd_A_obs,1)+1;

An = [Gxd_A_obs Gxd_B_obs ;zeros(1,n)]; %matriz aumentada 5x5 

Bn = [zeros(n-1,1);1];

[K,P,cloop_poles] = dlqr(An,Bn,Q_X,R_X);

[KV] = (K + [zeros(1,n-1),1])*[Gxd_A_obs-eye(n-1) Gxd_B_obs; Gxd_C_obs*Gxd_A_obs Gxd_C_obs*Gxd_B_obs]^-1;

%To obtain poles we can use eig(A-BK) = closed loop poles (lecture slides)

%Determine the closed-loop state-space representation:
% sys = ss((Gxd_A_obs-Gxd_B_obs*K),Gxd_B_obs,G_C_obs,0,t_samp);

%Determine K0 magnitude:
% gain = dcgain(sys);
K0 = KV(end);
KV(end) = [];
end
