%%
% assignment 12 - matlab - TEP 4100
%%

%% Problem:
%   exercise 9-90 [ Fluid Mechanics - Cengel and Cimbala sec. edit]:
%
%       Consider steady, incompressible, parallel , laminar flow of a 
%       viscous fluid falling between two infinite vertical walls 
%       (Fig. P9- 90). The distance between the walls is h, and gravity
%       acts in the negative z-direction (downward in the figure). 
%       There is no applied (forced) pressure driving the flow - the fluid 
%       falls by gravity alone. The pressure is constant everywhere in the
%       flow field. Calculate the velocity field and sketch the velocity 
%       profile using appropriate nondimensionalized variables.
% 
%
%   Additional matlab exercise:
%
%       Make two different plots side-by-side in the same figure (the
%       figure window should contain two axes) where the left plot should
%       contain the velocity profile and the average velocity, the right
%       plot should contain the velocity profile and some local velocities.
%       Use dimensionless velocities.
%
%       Hints: 
%             To make multiple plots in a single figure you should check
%             out the command 'subplot(...)'.
%
%             To integrate a function between known limits you should check
%             out the function 'quad(...)'(for example to integrate a
%             velocity profile function as a step towards finding the
%             average velocity)
%
%       Print the figure and hand in with the rest of the assignment.
%
%
%   Tilleggsoppgave for MatLab:
%
%       Lag to plot ved siden av hverandre i den samme figuren
%       (figurvinduet skal inneholde to aksekors med plot) der det venstre
%       aksekorset skal inneholde hastighetsprofilet og en linje som
%       representerer gjennomsnittshastigheten, og det høyre skal inneholde
%       hastigetsprofilet og noen lokale hastighetsvektorer. Bruk
%       dimensjonsløse hastigheter.
%
%       Hint:
%            For å lage flere aksekors (plot) i en enkelt figur bør du
%            sjekke ut kommandoen 'subplot(...)'.
%
%            For å integrere en funksjon mellom kjente grenser bør du
%            sjekke ut funksjonen 'quad(...)' (for eksempel for å integrere
%            funksjonen for et hastighetsprofil som et steg på veien for å
%            finne gjennomsnittshastigheten)
%
%       Print ut figuren og lever inn sammen med resten av øvingen.

%% Solution:

clear all
close all
clc

%% computation of the velcoity profile

h=1;

x_nondim            = [-0.5:0.001:0.5];                                     % x_nondim = from -(h/2)/h to (h/2)/h = -0.5 to 0.5

w_nondim_fun        = @(position) 0.5*(position.^2-0.25);                   % 'position' is an internal variable in the anonymous function 'w_nondim_fun' created here,
                                                                            % the function is the solution from problem 9-90

w_nondim            = w_nondim_fun(x_nondim);                               % creating the vector 'w_nondim' at the positions specified by 'x_nondim'

int_velocity        = quad(w_nondim_fun,x_nondim(1),x_nondim(end));         % the function 'w_nondim_fun' is sent to the 'quad'-function for integration
                                                                            % between the minimum and maximum values for the position, which are the first
                                                                            % and last element in 'x_nondim'; 'x_nondim(1)' and 'x_nondim(end)'.
                                                                            

average_velocity    =int_velocity/(x_nondim(end)-x_nondim(1));              % to find the average one must divide the integral found above by the length
                                                                            % of integration, which of course is the difference between the last and the first
                                                                            % element in 'x_nondim'
%% creating the figure window

figure1             = figure('Name',...                                     % creating an empty figure with a specified position and a
                    ['Viscous fluid flow between two parallel',...          % name instead of the default 'Figure X'.  
                    ' and vertical walls'],'NumberTitle','off');         

%% ...and then the left axes and the plots

subplot1            = subplot(1,2,1);                                       % creating the axes defined by the command 'subplot(...)' which are given the
                                                                            % name 'subplot1'

plot(x_nondim,w_nondim,'Color','r','Parent',subplot1)                       % plotting in the axes named 'subplot1'
                                                                            
hold on                                                                     % we are going to make another plot is this frame, so we must use 'hold on'

plot([x_nondim(1) x_nondim(end)],...                                        % making a plot of the average velocity as a line of constant value 'average_velocity' 
        [average_velocity average_velocity],'Parent',subplot1);             % between the first and last non-dimensional x-values, syntax: plot([x1 x2],[y1 y2]), 
                                                                            % and plotting in 'subplot1'

% set(subplot1,'PlotBoxAspectRatio',[1 1 1]);                                 % setting the property 'PlotBoxAspectRatio' of subplot1 to [1 1 1] (equal relative axes),
                                                                            % not necessary at all but this is the way to manipulate the axes of individual subplots
                                                                            
legend(subplot1,'Velocity profile','Average velocity')                      % creating a legend, x-label, y-label and title in the axes called 'subplot1'
xlabel(subplot1,'Position from centerline [m]')
ylabel(subplot1,'Dimensionless velocity [-]')
title(subplot1,'Left plot')
%% computations to find the velocity arrows

n_arrows            = 13;                                                   % number of arrows to create

x_arrows            = x_nondim(1)+(x_nondim(end)-x_nondim(1))*...
                      [0:n_arrows-1]/(n_arrows-1);                          % positions of the arrows in the film
            
        
w_arrows            = w_nondim_fun(x_arrows);                               % creating the vector 'w_arrows' at the positions specified by 'x_arrows'

v_arrows            = zeros(1,n_arrows);                                    % velocity normal to the wall (v is in y direction and zero) 

y_arrows            = zeros(1,n_arrows);                                    % positions of the arrows in y direction (the starting point for all arrows is at y=0)

%% ....and creating the right axes and the plots

subplot2            = subplot(1,2,2);                                       % creating the axes defined by the command 'subplot(...)' which are given the
                                                                            % name subplot2

plot(x_nondim,w_nondim,'Color','r','Parent',subplot2)                       % plotting in the axes named subplot2

hold on

quiver(x_arrows,y_arrows,v_arrows,w_arrows,0,'Parent',subplot2)             % creating the arrows for the velocities in the axes called subplot2

% set(subplot2,'PlotBoxAspectRatio',[1 1 1]);                                 % setting the property 'PlotBoxAspectRatio' of subplot1 to [1 1 1] (equal relative axes),
                                                                            % not necessary at all but this is the way to manipulate the axes of individual subplots

legend(subplot2,'Velocity profile','Local velocities')                      % creating a legend, x-label, y-label and title in the axes called 'subplot2'
xlabel(subplot2,'Position from centerline [m]')
ylabel(subplot2,'Dimensionless velocity [-]')
title(subplot2,'Right plot')

