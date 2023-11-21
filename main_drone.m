%This version has the measured covariances
%% Variables:
t_samp=0.065; %Discretization
delay=0.26;   %Delay

load ssH.mat;
load ssYaw.mat;
load tf.mat;

%% Height Subsystem

%Continuous-Time State-Space Matrices:

Gz_A = ssH.A;
Gz_B = ssH.B;
Gz_C = ssH.C;
Gz_D = ssH.D;

%Discrete-Time and Continuous-Time Transfer Functions:

[num,den]=ss2tf(Gz_A,Gz_B,Gz_C,Gz_D);

Gzc=tf(num,den);

Gzd = c2d(Gzc,t_samp,'ZOH');

numH_discrete = Gzd.Numerator{:,:};
denH_discrete = Gzd.Denominator{:,:};

%Continuous-Time Observable Canonical Form:

[Gzc_A_obs,Gzc_B_obs,Gzc_C_obs] = observable(num,den,2); 

%Discrete-Time Observable Canonical Form:

[Gzd_A_obs,Gzd_B_obs,Gzd_C_obs] = observable(Gzd.numerator{:,:},Gzd.denominator{:,:},2);

%Discrete-Time Observer Gain Matrix - Deadbeat Response:

Ke_z = observersDiscrete(Gzd_A_obs,Gzd_C_obs);

%Weighting Matrices: (change these values) - ch

Q_z = [ 0 0 0;
       0  3000 0
       0 0 0];

R_z = 100;

%LQR Gains:

[K_Z, K0_Z, P_Z, cloop_poles_Z] = gainLQR(Gzd_A_obs,Gzd_B_obs,Gzd_C_obs,Q_z,R_z,t_samp);

%Plot LQR

%Kalman Filter:
 
QE_Z=eye(2)*10^(-3);
RE_Z=0.002762;
 
KGe_Z = dlqe(Gzd_A_obs,QE_Z,Gzd_C_obs,QE_Z,RE_Z);

%% Heading Subsystem

%Continuous-Time State-Space Matrices:

Gyaw_A = ssYaw.A;
Gyaw_B = ssYaw.B;
Gyaw_C = ssYaw.C;
Gyaw_D = ssYaw.D;

%Discrete-Time and Continuous-Time Transfer Functions;

[num,den]=ss2tf(Gyaw_A,Gyaw_B,Gyaw_C,Gyaw_D);

Gyawc=tf(num,den);

Gyawd = c2d(Gyawc,t_samp,'ZOH');

numYaw_discrete = Gyawd.Numerator{:,:};
denYaw_discrete = Gyawd.Denominator{:,:};

%Continuous-Time Observable Canonical Form:

[Gyawc_A_obs,Gyawc_B_obs,Gyawc_C_obs] = observable(num,den,1); 

%Discrete-Time Observable Canonical Form:

[Gyawd_A_obs,Gyawd_B_obs,Gyawd_C_obs] = observable(Gyawd.numerator{:,:},Gyawd.denominator{:,:},1);

%Observer Discrete-Time Gain Matrix - Deadbeat Response:

Ke_yaw = observersDiscrete(Gyawd_A_obs,Gyawd_C_obs);

%Weighting Matrices:

Q_Yaw = [1 0
         0 1];

R_Yaw = 10;

%LQR Gains:

[K_yaw, K0_yaw, P_yaw, cloop_poles_yaw] = gainLQR(Gyawd_A_obs,Gyawd_B_obs,Gyawd_C_obs,Q_Yaw,R_Yaw,t_samp);

%Use PlotLQR?

%Kalman Filter:
 
QE_yaw=eye(1)*10^(-4);
RE_yaw=0.000061;
 
KGe_yaw = dlqe(Gyawd_A_obs,QE_yaw,Gyawd_C_obs,QE_yaw,RE_yaw);

%% Longitudinal Position Subsystem

%Continuous-Time State-Space Matrices:

[Gxc_A,Gxc_B,Gxc_C,Gxc_D] = tf2ss(tfX.Numerator{:,:},tfX.Denominator{:,:});

[num,den]=ss2tf(Gxc_A,Gxc_B,Gxc_C,Gxc_D);

Gxc=tf(num,den);

%Discrete-Time Transfer Function:

Gxd = c2d(Gxc,t_samp,'ZOH');

numX_discrete = Gxd.Numerator{:,:};
denX_discrete = Gxd.Denominator{:,:};

%Continuous-Time Observable Canonical Form:

[Gxc_A_obs,Gxc_B_obs,Gxc_C_obs] = observable(Gxc.numerator{:,:},Gxc.denominator{:,:},4); 

%Discrete-Time Observable Canonical Form:

[Gxd_A_obs,Gxd_B_obs,Gxd_C_obs] = observable(Gxd.numerator{:,:},Gxd.denominator{:,:},4);

%Observer Discrete-Time Gain Matrix - Deadbeat Response:

Ke_X = observersDiscrete(Gxd_A_obs,Gxd_C_obs);

%Observer Continuous-Time Gain Matrix - Deadbeat Response:

%Kec_X = observersContinuous(Gxc_A_obs,Gxc_C_obs);

%Weighting Matrices:

Q_X=[1 0 0 0 0;
     0 1 0 0 0; 
     0 0 1 0 0;
     0 0 0 1 0
     0 0 0 0 1];

R_X = 700;

%LQR Gains:

[K_X, K0_X, P_X, cloop_poles_X] = gainLQR(Gxd_A_obs,Gxd_B_obs,Gxd_C_obs,Q_X,R_X,t_samp);

%Plot LQR:

%[Gx_A_lqr, Gx_B_lqr, Gx_C_lqr, D] = plotLQR(Gxc_A_obs,Gxc_B_obs,Gxc_C_obs, K_X);

%Pole placement: (?)

%[A_acker, B_acker, C_acker, D_acker, Kx_acker] = poleplace(Gxc.numerator{:,:},Gxc.denominator{:,:});

%Kalman Filter 

QE_X=eye(4)*10^(-4);
RE_X=0.001166;
 
KGe_X = dlqe(Gxd_A_obs,QE_X,Gxd_C_obs,QE_X,RE_X);

%% Lateral Position Subsystem

%Continuous-Time State-Space Matrices:

[Gyc_A,Gyc_B,Gyc_C,Gyc_D] = tf2ss(tfY.Numerator{:,:},tfY.Denominator{:,:});

[num,den]=ss2tf(Gyc_A,Gyc_B,Gyc_C,Gyc_D);

Gyc=tf(num,den);

%Discrete-Time Transfer Function:

Gyd = c2d(Gyc,t_samp,'ZOH');

numY_discrete = Gyd.numerator{:,:};
denY_discrete = Gyd.denominator{:,:};

%Continuous-Time Observable Canonical Form:

[Gyc_A_obs,Gyc_B_obs,Gyc_C_obs] = observable(Gyc.numerator{:,:},Gyc.denominator{:,:},4); 

%Discrete-Time Observable Canonical Form:

[Gyd_A_obs,Gyd_B_obs,Gyd_C_obs] = observable(Gyd.numerator{:,:},Gyd.denominator{:,:},4);

%Discrete-Time Observer Gain Matrix:

Ke_Y = observersDiscrete(Gyd_A_obs,Gyd_C_obs);

%Weighting Matrices:

Q_Y=[1 0 0 0 0;
    0 1  0 0 0; 
    0 0 2 0 0;
    0 0 0 2 0
    0 0 0 0 2];

R_Y = 1500;

%LQR Gains:

[K_Y, K0_Y, P_Y, cloop_poles_Y] = gainLQR(Gyd_A_obs,Gyd_B_obs,Gyd_C_obs,Q_Y,R_Y,t_samp);


%Kalman Filter:
 
QE_Y=eye(4)*10^(-5);
RE_Y=0.000961;
 
KGe_Y = dlqe(Gyd_A_obs,QE_Y,Gyd_C_obs,QE_Y,RE_Y);

%% Discrete SS for devkit:

ssRoll_discrete=c2d(ssRoll,t_samp);
ssRoll2V_discrete=c2d(ssRoll2V,t_samp);
ssPitch_discrete=c2d(ssPitch,t_samp);
ssPitch2U_discrete=c2d(ssPitch2U,t_samp);
ssYaw_discrete=c2d(ssYaw,t_samp);
ssH_discrete=c2d(ssH,t_samp);



