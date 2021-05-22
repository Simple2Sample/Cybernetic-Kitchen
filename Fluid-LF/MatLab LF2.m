%% Assignment 2 - matlab - TEP 4100

%% Problem:
%   Exercise 3-22 [ Fluid Mechanics - Cengel and Cimbala 2nd edition in SI units]:
%
%       Determine the pressure exerted on the surface of a submarine 
%       cruising 90 m below the surface of the sea. Assume that the 
%       barometric pressure is 101 kPa and the specific gravity 
%       of seawater is 1.03. 
%
%   Additional matlab exercise:
%
%       The submarine is travelling from Trondheim to Oslo. It will travel
%       to the following depths 0,50,100,80,110,50,30 and 0 [m], at
%       corresponding distances 0,100,500,550,900,1100,1200,1300 km.
%       Determine the pressure exerted on the surface of a submarine during
%       its cruise from Trondheim to Oslo at given distances. Assume that
%       between positions the sub ascends and descends linearly to the next depth and
%       make a plot of the pressure vs. travelled distance.
%
%   Tilleggsoppgave for Matlab:
%
%       Ubåten drar fra Trondheim til Oslo. Den vil nå følgende dybder;
%       0,50,100,80,110,50,30,0 [m], og disse dybdene når ubåten etter å ha
%       reist; 1,100,500,550,900,1100,1200,1300 [km]. Finn trykket som
%       virker på ubåtskroget ved de gitte dybder og avstander på turen fra
%       Trondheim til Oslo. Anta at ubåten stiger og synker lineært mellom
%       dybdene og lag et plot av trykk vs. reist avstand.

%% Solution : Sufficient answer to the given problem

% the pressures will be calculated using the same formula as in ex.3-22
% p = p_barometric + rho * g * h

clear all
clc

g   = 9.81;                                                                 %   gravitational acceleration
rho = 1.03*1000;                                                            %   specific gravity of seawater * water density

depths      = [0,50,100,80,110,50,30,0];                                    %   creating a vector containing the depths 
pressures   = 101000 + rho*g*depths;                                        %   computing the pressures corresponding to the elements in 'depths'- vector.
                                                                            %   Matlab understands that since 'depths' is a vector, 'pressures' must also be a vector.

waypoints = [0,100,500,550,900,1100,1200,1300];                             %  'wayPoints' containing the distances at which the depths are   

figure(1)                                                                   %   creating an empty figure

plot(waypoints,pressures)                                                   %   plotting the pressures at the distances

ylabel('Pressure [Pa]');                                                    %   adding labels to the axes 
xlabel('Distance [km]');

%% Refinement : To refine the plot one can add the depths and show its inverse relation with pressure

x = 1:length(pressures);                                                    %   creating an x-vector with the same number of elements as in the 'pressures' vector
                                                                            %   (Will need this for the plotting below)
figure(2)                                                                   %   creating a new epmty figure

[AX1,H11,H21] = plotyy(waypoints, pressures, waypoints, -depths,'plot');    %   plotyy(x,y1,x,y2,...) plots two series y1,y2 
                                                                            %   in the same figure using primary and secondary axes, see doc or help on plotyy for more information
 
set(get(AX1(1),'Ylabel'),'String','Pressures [Pa]')                         %   adding labels to the y-axes becomes a bit more cumbersome now since there are two of them,
set(get(AX1(2),'Ylabel'),'String','Depths [m above sea level]')             %   but we can set the properties of the handle created when we wrote
                                                                            %   '[AX1,H11,H21]= plotyy(....)' by the 'set(...)'-command
                                                                 
xlabel('Distance [km]');


