
%% Assignment 7 - matlab - TEP 4100

%% Problem:
%   exercise 5 -18 [ Fluid Mechanics - Cengel and Cimbala sec. edit]:
%
%       At a certain location, wind is blowing steadily at 8 m/s. Determine
%       the mechanical energy of air per unit mass and the power generation
%       potential of a wind turbine with 50-m-diameter blades at that
%       location. Also determine the actual power generation assuming an
%       overall efficiency of 30 percent. Take the air density to be 1.25
%       kg/m3
%
%%  Additional matlab exercise:
%
%       Investigate the effect of wind velocity and the blade span diameter
%       on wind power generation. Let the velocity vary from 5 to 20 m/s in
%       increments of 5 m/s, and the diameter to vary from 20 m to 80 m in
%       increments of 20 m, and plot the results.
%
%       Print out the plot and hand in with the rest of the assignment.
%
%       Hints: No particular hints, everything needed to solve this problem
%       has been given in the solutions to the matlab problems up to now.

%%  Tilleggsoppgave for Matlab:
%
%       Undersøk effekten som vindhastigheten og rotordiameteren har på
%       effekten man kan hente ut fra vinden. La hastigheten variere fra 5
%       m/s til 20 m/s med inkrement på 5 m/s og la diameteren variere fra
%       20 m til 80 m med inkrement på 20 m/s. Plot resultatene.
%       
%       Print ut figuren og lever inn med resten av øvingen.
%
%       Hint: Ingen spesielle hint, alt som er nødvendig for å løse oppgaven
%       har blitt gitt i løsningsforslagene til matlaboppgavene frem til
%       nå.
%            

%% Solution:
clear all
clc
close all

rho_air         = 1.25;                                                     % setting the air density

efficiency      = 0.3;                                                      % setting the assumed efficiency

windvelo        = [5:5:20]';                                                % creating a column vector consisting of the wind velocities

bladespan       = [20:20:80];                                               % creating a row vector consisting of the diameters

windpower       = efficiency*0.5*rho_air*(windvelo.^3)*...                  % Creating a matrix of wind power according to the velocities and diameters.
    (pi()*bladespan.^2/4)/1000000;                                          % The synatx must be (column vector)*(row vector) to produce a matrix.
                                                                            % (row vector)*(column vector) doesn't work, it produces a single number

figure1         = figure('Name',...                                         % creating an empty figure with a name instead of the default 'Figure X'
    '2D plot of generated windpower, blade diameter is a parameter',... 
    'NumberTitle','off');
    
plot(windvelo,windpower)                                                    % using a standard 2D plot

xlabel('wind velocity [m/s]')                                               % labelling the axes

ylabel('Generated power from wind [MW]')

legend([kron(ones(size(bladespan')),'D = '),num2str(bladespan')])           % creating the legend using the single line statement from the previous assignment 
                                                                            % solution, input to this statement must be a column vector

%% Solution introducing 3D plot as an alternative to 2D plot that includes a legend

clear all
clc


rho_air         = 1.25;                                                     % setting the air density

efficiency      = 0.3;                                                      % setting the assumed efficiency

windvelo        = [5:5:20]';                                                % creating a column vector consisting of the wind velocities

bladespan       = [20:20:80];                                               % creating a row vector consisting of the diameters

windpower       = efficiency*0.5*rho_air*(windvelo.^3)*...                  % Creating a matrix of wind power according to the velocities and diameters
    (pi()*bladespan.^2/4)/1000000;                                          % The synatx must be (column vector)*(row vector) to produce a matrix.
                                                                            % (row vector)*(column vector) doesn't work, it produces a single number                        
for k=1:length(bladespan)
    
    parameterD(1:length(windvelo),k)   = bladespan(k);                      % plot3(X,Y,Z) is taking all elements xi,yi,zi and plotting them in an x,y,z coordinate.
                                                                            % But we would like to plot the power as a function of wind speed for each value for the
end                                                                         % blade diameter. We must therfore create a matrix with the same rowlength as windvelo, but
                                                                            % consisting of the constant value for the blade diameter that we want to plot, so the 
                                                                            % line remains at a given value for the blade span. See "doc plot3" to read about plot3
                                                                            % You should try to substitute plot3(windvelo,parameterD,windpower) with
                                                                            % plot3(windvelo,bladespan,windpower) to see what happens then. 
    
figure1         = figure('Name','3D plot of generated windpower',...        % creating an empty figure with a name instead of the default 'Figure X'
        'NumberTitle','off');

    plot3(windvelo,parameterD,windpower)                                    % plotting using plot3
    
grid on                                                                     % it's easier to read the 3D figure when a grid is imposed on the figure

xlabel('wind velocity [m/s]')% labelling the axes

ylabel('Blade diameter')

zlabel('Generated power from wind [MW]')

legend([kron(ones(size(bladespan')),'D = '),num2str(bladespan')])           % This legend is not necessary since the value for diameter appears on one of the axes,
                                                                            % but it might be used to to enhance readability, or perhaps to label if the efficiency
                                                                            % was different for the different diameters (might be possible due to scale effects)
