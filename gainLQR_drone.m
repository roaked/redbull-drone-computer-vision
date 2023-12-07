function [K, K0] = gainLQR(G,H,C,Q,R,t_samp)
%This function finds the Linear Quadratic Regulator gain matrix for a given
%system and given weighting matrices Q and R. It also determines the gain
%K0 that is multiplied with the reference to ensure the system has an unit 
%steady-state gain. This function is to be used for discrete-time
%state-space representations.

%x(k+1) = Gx(k) + Hu(k), y(k) = Cx(k)

%Compute the feedback gain matrix:
K = dlqr(G,H,Q,R);

%Determine the closed-loop state-space representation:
sys = ss((G-H*K),H,C,0,t_samp);

%Determine K0 magnitude:
mag = bode(sys);
K0 = 1/(mag(:,:,1));

%Determine whether K0 is positive or negative:
sInfo = stepinfo(sys);

if sInfo.SettlingMax < 0
    
    K0 = -K0;
    
end

end

