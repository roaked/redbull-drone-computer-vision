%% Variables:
t_samp=0.065; %Discretization
delay=0.26;   %Delay

load ssH.mat;
load ssYaw.mat;
load tf.mat;

%% Height Subsystem

%Continuous-Time State-Space Matrices:

A_H = ssH.A;
B_H = ssH.B;
C_H = ssH.C;
D_H = ssH.D;

%Discrete-Time and Continuous-Time Transfer Functions:

[num,den]=ss2tf(A_H,B_H,C_H,D_H);

tfH=tf(num,den);

tfH_discrete = c2d(tfH,t_samp,'ZOH');

numH_discrete = tfH_discrete.Numerator{:,:};
denH_discrete = tfH_discrete.Denominator{:,:};

%Continuous-Time Observable Canonical Form:

[A_H_obs,B_H_obs,C_H_obs] = observable(num,den,2); 

%Discrete-Time Observable Canonical Form:

[G_H,H_H,E_H] = observable(tfH_discrete.numerator{:,:},tfH_discrete.denominator{:,:},2);

%Discrete-Time Observer Gain Matrix - Deadbeat Response:

Le_H = observersDiscrete(G_H,E_H);

%Weighting Matrices:

Q_H = [0 0;
       0  3000];

R_H = 100;

%LQR Gains:

[K_H, K0_H] = gainLQR(G_H,H_H,E_H,Q_H,R_H,t_samp);

%Kalman Filter:

QE_H = eye(2)*10^(-4);
RE_H = 8.2685e-04;

Ke_H = dlqe(G_H,QE_H,E_H,QE_H,RE_H);


%% Heading Subsystem

%Continuous-Time State-Space Matrices:

A_Yaw = ssYaw.A;
B_Yaw = ssYaw.B;
C_Yaw = ssYaw.C;
D_Yaw = ssYaw.D;

%Discrete-Time and Continuous-Time Transfer Functions;

[num,den]=ss2tf(A_Yaw,B_Yaw,C_Yaw,D_Yaw);

tfYaw=tf(num,den);

tfYaw_discrete = c2d(tfYaw,t_samp,'ZOH');

numYaw_discrete = tfYaw_discrete.Numerator{:,:};
denYaw_discrete = tfYaw_discrete.Denominator{:,:};

%Continuous-Time Observable Canonical Form:

[A_Yaw_obs,B_Yaw_obs,C_Yaw_obs] = observable(num,den,1); 

%Discrete-Time Observable Canonical Form:

[G_Yaw,H_Yaw,E_Yaw] = observable(tfYaw_discrete.numerator{:,:},tfYaw_discrete.denominator{:,:},1);

%Observer Discrete-Time Gain Matrix - Deadbeat Response:

Le_Yaw = observersDiscrete(G_Yaw,E_Yaw);

%Weighting Matrices:

Q_Yaw = 1;

R_Yaw = 10;

%LQR Gains:

[K_Yaw, K0_Yaw] = gainLQR(G_Yaw,H_Yaw,E_Yaw,Q_Yaw,R_Yaw,t_samp);

%Kalman Filter:

QE_Yaw=eye(1)*10^(-4);
RE_Yaw=0.0044;

Ke_Yaw = dlqe(G_Yaw,QE_Yaw,E_Yaw,QE_Yaw,RE_Yaw);

%% Longitudinal Position Subsystem

%Continuous-Time State-Space Matrices:

[A_X,B_X,C_X,D_X] = tf2ss(tfX.Numerator{:,:},tfX.Denominator{:,:});

%Discrete-Time Transfer Function:

tfX_discrete = c2d(tfX,t_samp,'ZOH');

numX_discrete = tfX_discrete.Numerator{:,:};
denX_discrete = tfX_discrete.Denominator{:,:};

%Continuous-Time Observable Canonical Form:

[A_X_obs,B_X_obs,C_X_obs] = observable(tfX.Numerator{:,:},tfX.Denominator{:,:},4); 

%Discrete-Time Observable Canonical Form:

[G_X,H_X,E_X] = observable(tfX_discrete.numerator{:,:},tfX_discrete.denominator{:,:},4);

%Observer Discrete-Time Gain Matrix - Deadbeat Response:

Le_X = observersDiscrete(G_X,E_X);

%Weighting Matrices:

Q_X=[1 0 0 0;
     0 1 0 0; 
     0 0 1 0;
     0 0 0 1];

R_X = 700;

%LQR Gains:

[K_X, K0_X] = gainLQR(G_X,H_X,E_X,Q_X,R_X,t_samp);

%Kalman Filter:

QE_X=eye(4)*10^(-6);
RE_X=4.6370e-03;

% Ke_X = dlqe(G_X,QE_X,E_X,QE_X,RE_X);

%% Lateral Position Subsystem

%Continuous-Time State-Space Matrices:

[A_Y,B_Y,C_Y,D_Y] = tf2ss(tfY.Numerator{:,:},tfY.Denominator{:,:});

%Discrete-Time Transfer Function:

tfY_discrete = c2d(tfY,t_samp,'ZOH');

numY_discrete = tfY_discrete.Numerator{:,:};
denY_discrete = tfY_discrete.Denominator{:,:};

%Continuous-Time Observable Canonical Form:

[A_Y_obs,B_Y_obs,C_Y_obs] = observable(tfY.Numerator{:,:},tfY.Denominator{:,:},4); 

%Discrete-Time Observable Canonical Form:

[G_Y,H_Y,E_Y] = observable(tfY_discrete.numerator{:,:},tfY_discrete.denominator{:,:},4);

%Discrete-Time Observer Gain Matrix:

Le_Y = observersDiscrete(G_Y,E_Y);

%Weighting Matrices:

Q_Y=[1 0 0 0;
    0 1  0 0; 
    0 0 2 0;
    0 0 0 2];

R_Y = 1500;

%LQR Gains:

[K_Y, K0_Y] = gainLQR(G_Y,H_Y,E_Y,Q_Y,R_Y,t_samp);

%Kalman Filter:

QE_Y=eye(4)*10^(-4);
RE_Y=1.3640e-05;

Ke_Y = dlqe(G_Y,QE_Y,E_Y,QE_Y,RE_Y);

%% Discrete SS for devkit:

ssRoll_discrete=c2d(ssRoll,t_samp);
ssRoll2V_discrete=c2d(ssRoll2V,t_samp);
ssPitch_discrete=c2d(ssPitch,t_samp);
ssPitch2U_discrete=c2d(ssPitch2U,t_samp);
ssYaw_discrete=c2d(ssYaw,t_samp);
ssH_discrete=c2d(ssH,t_samp);








