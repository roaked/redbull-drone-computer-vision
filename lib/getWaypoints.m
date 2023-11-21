function [ waypoint ] = getWaypoints(  )
%GETWAYPOINTS Generates a list of waypoints for the ARDrone
%   Each waypoint is a column vector that contains the desired position of the
%   drone, desired heading angle, and waiting time. The list of waypoints
%   is created combining the column vectors. 

% Number of waypoints. Edit this value as desired. 
% nPoints = 2;

waypointsListARDrone = zeros(5,20);
waypointsListARDrone(3,:) = 1;


% Edit the following entries for k =1,2,...,nPoints
% waypointsListARDrone(:,k) = [ Xe (m), Ye (m), h (m), psi, waiting time (sec)
% waypointsListARDrone(:,1) = [0 ; 0 ; 1 ; 0; 3] ; 
% waypointsListARDrone(:,2) = [1 ; 0 ; 1 ; 0 ; 2] ; 
% waypointsListARDrone(:,3) = [4 ; 0 ; 1.5 ; 0 ; 10] ; 
% waypointsListARDrone(:,4) = [ 0.0; 0.0; 1.0; 0.0; 5.0];% take off
% waypointsListARDrone(:,2) = [ 0.0; 0.0; 1.0; pi/4; 1.0];
% waypointsListARDrone(:,3) = [ 0.0; 0.0; 1.0; pi/2; 1.0];
% waypointsListARDrone(:,4) = [ 0.0; 0.0; 1.0; 3*pi/4; 1.0];
% waypointsListARDrone(:,5) = [ 0.0; 0.0; 1.0; pi; 0.0];
% waypointsListARDrone(:,6) = [ -3.0; 0.0; 1.0; pi; 5.0];
% waypointsListARDrone(:,3) = [ 1.0; 1.0; 1.0; 0.0; 2.0];
% waypointsListARDrone(:,4) = [ 0.0; 1.0; 1.0; 0.0; 2.0];
% waypointsListARDrone(:,5) = [ 0.0; 0.0; 1.0; 0.0; 10.0];
% waypointsListARDrone(:,3) = [ 1.0; 0.1; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,4) = [ 1.0; 0.2; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,5) = [ 1.0; 0.3; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,6) = [ 1.0; 0.4; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,7) = [ 1.0; 0.5; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,8) = [ 1.0; 0.6; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,9) = [ 1.0; 0.7; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,10) = [ 1.0; 0.8; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,11) = [ 1.0; 0.9; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,12) = [ 1.0; 1.0; 1.0; 0.0; 5.0];
% waypointsListARDrone(:,13) = [ 0.0; 1.0; 1.0; 0.0; 5.0];
% waypointsListARDrone(:,14) = [ 0.0; 0.9; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,15) = [ 0.0; 0.8; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,16) = [ 0.0; 0.7; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,17) = [ 0.0; 0.6; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,18) = [ 0.0; 0.5; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,19) = [ 0.0; 0.4; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,20) = [ 0.0; 0.3; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,21) = [ 0.0; 0.2; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,22) = [ 0.0; 0.1; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,23) = [ 0.0; 0.0; 1.0; 0.0; 5.0];
% waypointsListARDrone(:,3) = [ 0.2; 0.0; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,4) = [ 0.3; 0.0; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,5) = [ 0.4; 0.0; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,6) = [ 0.5; 0.0; 1.0; 0.0; 0.0]; 
% waypointsListARDrone(:,7) = [ 0.6; 0.0; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,8) = [ 0.7; 0.0; 1.0; 0.0; 2.0]; % go first corner
% waypointsListARDrone(:,9) = [ 0.7; 0.1; 1.0; 0.0; 0.0]; % go second corner
% waypointsListARDrone(:,10) = [ 0.7; 0.2; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,11) = [ 0.7; 0.3; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,12) = [ 0.7; 0.4; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,13) = [ 0.7; 0.5; 1.0; 0.0; 0.0]; 
% waypointsListARDrone(:,14) = [ 0.7; 0.6; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,15) = [ 0.7; 0.7; 1.0; 0.0; 2.0]; 
% waypointsListARDrone(:,16) = [ 0.6; 0.7; 1.0; 0.0; 0.0];% go third corner
% waypointsListARDrone(:,17) = [ 0.5; 0.7; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,18) = [ 0.4; 0.7; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,19) = [ 0.3; 0.7; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,20) = [ 0.2; 0.7; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,21) = [ 0.1; 0.7; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,22) = [ 0.0; 0.7; 1.0; 0.0; 2.0];
% waypointsListARDrone(:,23) = [ 0.0; 0.6; 1.0; 0.0; 0.0];% go fourth corner
% waypointsListARDrone(:,24) = [ 0.0; 0.5; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,25) = [ 0.0; 0.4; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,26) = [ 0.0; 0.3; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,27) = [ 0.0; 0.2; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,28) = [ 0.0; 0.1; 1.0; 0.0; 0.0];
% waypointsListARDrone(:,29) = [ 0.0; 0.0; 1.0; 0.0; 2.0];


waypoint = waypointsListARDrone ; 

end


% % % ORIGINAL
% % % waypointsListARDrone(:,1) = [ 0.0;0.0;1;0; 5] ; 
% % % waypointsListARDrone(:,2) = [-1.5;0;1;0; 0.1] ; 
% % % waypointsListARDrone(:,3) = [1.5;0;1;0; 0.1] ; 
% % % waypointsListARDrone(:,4) = [0;0;1;0; 2] ; 
% % % waypointsListARDrone(:,5) = [0;0;1.8;0; 5] ; 
% % % waypointsListARDrone(:,6) = [0;0;1;0; 5] ; 
% % % waypointsListARDrone(:,7) = [0;0;1;0; 5] ; 
% % % waypointsListARDrone(:,8) = [0;0;1;0; 5] ; 
% % % waypointsListARDrone(:,9) = [0;0;1;0; 5] ; 
% % % waypointsListARDrone(:,10) = [0;0;1;0; 5] ; 
% % % waypointsListARDrone(:,11) = [0;0;1;0; 5] ; 
