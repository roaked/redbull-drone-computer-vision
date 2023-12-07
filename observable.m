function [A_obs,B_obs,C_obs]=observable(num,den,n) 
 
%Puts into an observable canonical form
den=den(2:length(den));
 
%Matrix B
B_obs=1:n;
for i=1:n
    B_obs(i) = num(end+1-i) - den(end+1-i) * num(1);
end
B_obs=B_obs';
 
%Matrix A
A_obs(1,1:n-1)=zeros(1,n-1);
A_obs(2:n,1:n-1)=eye(n-1);
A_obs(:,n)=-fliplr(den)';
 
%Matrix C
C_obs(1:n-1)=0;
C_obs(n)=1;