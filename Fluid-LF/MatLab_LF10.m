
%% Assignment 10 - matlab - TEP 4100

%% Problem:
%   exercise 8 -30 [ Fluid Mechanics - Cengel and Cimbala sec. edit]:
%       
%       Water at 15C (rho = 999.1 kg/m^3 and mu= 1.138 10^-3 kg/ms) is
%       flowing steadily in a 30-m-long and 5-cm-diameter horizontal pipe
%       made of stainless steel at a rate of 9 L/s. Determine (a) the
%       pressure drop, (b) the head loss, and (c) the pumping power
%       requirement to overcome this pressure drop.

%% Additional Matlab exercise:
%   
%       Reconsider the pipe in problem 8-30, which is now attached to a
%       tank (similar to figure P8-135 on page 414). The water level (with
%       elevation z1 above the pipe center line, in the figure called H) in
%       the tank is initially 17 meters above the center line of the pipe,
%       and the pipe is 5 meters above the floor. For decreasing water
%       levels z1 evenly distributed down to z1=2 meter in the tank plot
%       six trajectories for a jet out from the pipe end (i.e. the tank is
%       drained via the pipe and we are making 6 snapshots of this draining
%       transient). Plot the trajectories until the water hits the floor.
% 
%       Figures in matlab can be saved as figure files (-.fig) and can
%       later be opened and plotted in. This is convenient because you can
%       make a figure template according to some design criteria, and if
%       many figures are needed one can avoid having to modify each figure,
%       you just make a plot in the figure template. Accompanying this
%       assignment is a file named 'figureforassignment10.fig' which you
%       should plot the trajectories in. It contains a sketch of the tank
%       and the pipe. Can you also plot the accompanying water levels in
%       the figure? Use the following axes limits to view all the features
%       in the existing figure:
%       
%       ylim([0 24])
%       xlim([-12 6])
%
%       Print the plot and hand in with the rest of the assignment.
%
%% Tilleggsoppgave for Matlab:
%       
%       Ta utgangspnkt i røret i oppgave 8-30, som nå er koblet til en tank
%       (tilsvarende figur P8-135 på side 414). Vannivået (med stedshøyde
%       z1 over senterlinjen til røret, i figuern kalt H) i tanken er
%       initielt 17 meter over senterlinjen til røret, og røret er 5 meter
%       over gulvnivået. For minkende vannivå til z1=2 meter, plot banen
%       til 6 stråler ut av røret for 6 jevnt fordelte vannivå i tanken
%       (med andre ord tanken tømmes via røret og vi tar 6 bilder av
%       tømmingen). Plot strålebanene til strålene treffer gulvet.
%
%       Figurer i matlab kan lagres som figur-filer (-.fig) som kan åpnes
%       ved en senere anledning og plottes i. Dette er praktisk fordi man
%       kan lage seg en figurmal basert på et ønsket design, og skal man
%       lage mange figurer med likt utseende kan man slippe å endre alle
%       figurene til designønsket, man kan bare plotte i figurmalen. Til
%       denne oppgaven følger en fil kalt 'figureforassignment10.fig' som
%       du skal plotte strålebanene i. Den inneholder en skisse over tanken
%       og røret. Kan du også plotte de tilhørende vannivåene i tanken?
%       Bruk følgende aksegrenser for å se hele skissen i figuren:
%
%       ylim([0 24])
%       xlim([-12 6])
%       
%       Skriv ut figuren og lever inn sammen med resten av øvingen.
%
%%
%       Hints:
%       
%       Use the Bernoulli equation between the free surface water level in
%       the tank (point 1) and the pipe inlet (point 2). Then use the 
%       energy equation for steady incompressible flow from the inlet of 
%       the pipe (point 2) to the outlet of the pipe (point 3). Assume
%       fully developed pipe flow from inlet to outlet. When substituting
%       the unknown pressure P2 as found from the Bernoulli, the energy
%       equation reduces to:
%
%           hL=z1-V^2/(2g)=f*V^2*L/(2*g*D) (eq1),
%
%       where the average velocity V and friction factor f are unknowns and 
%       f=f(v) is given by the Colebrook equation for turbulent flow. 
%       Solving for f in (eq1) (right hand side and left hand side of the 
%       last equality sign) and inserting into the Colebrook equation along 
%       with the expression for the Reynolds number Re gives you an 
%       equation with V as the only unknown. That nonlinear equation has to
%       solved iteratively. As in the matlab problem in assigment 9, that 
%       nonlinear equation can be solved by creating an anonomous function
%       which the intrinsic function fzero can work its magic on. fzero
%       needs a starting value, and a good starting value Vs is found by 
%       the explicit equation describing V if the head loss for the pipe 
%       had been equal to the water level (you get this by substituting the
%       expression for Re and f (from hL=z1=f*Vs^2*L/(2*g*D)) into the
%       Colebrook equation:
%
%Vs=sqrt(2*g*z1*D/L)*(-2.0*log(e/(3.71*D)+2.51/(rho*D*sqrt(2*g*z1*D/L)/mu)))
%
%       The statement to open an existing 'figurename.fig'- file is quite
%       simply to write 'open figurename.fig'. The file must be present in
%       the current folder you are working in, i.e. you must originally
%       save it in the current folder you are working on in matlab. Writing
%       a plotting statement after opening a figure will create a plot in
%       that figure.
%
%       That average velocity V in the pipe is taken as the jet velocity at
%       the center point of the pipe outlet. The jet trajectories are
%       determined and plotted in a similar way as in the Matlab
%       assignment of Assignment 8.
%
%% Script solving matlab excersice 10

clear all
close all
clc
                                                                       % Setting the 
rho             = 999.1;                                                    % density

mu              = 1.138e-3;                                                 % viscosity

D               = 0.05;                                                     % diameter

L               = 30;                                                       % length

r               = 2e-6;                                                     % roughness (avoid using e since this is natural number in MATLAB)

g               = 9.81;                                                     % gravity constant

s0              = 5;                                                        % the elevation of the pipe center above the floor

numjets         = 6;                                                        % the desired number of jets

for j=1:1:numjets
%% velocity computations    
    z1(j)       = 17-(17-2)/(numjets-1)*(j-1);                                  % Calculating the evenly distributed water levels
    
    F1          = @(v)1/sqrt(D/L*(2*g*z1(j)/v^2-1))+2*log10(r/(D*3.7)+...   % the right hand side  minus the left hand side of the Colebrook equation
            2.51*mu/(rho*v*D*sqrt(D/L*(2*g*z1(j)/v^2-1))));                 % with the substitution given in 'hints' is the anonymous functoin to minimize

    vinitguess  = -sqrt(D/L*(2*g*z1(j)))*2*log10(r/(D*3.7)+...              % as the initial guess for the iterative procedure in 'fzero' is the velocity in the
            2.51*mu/(rho*D*sqrt(D/L*(2*g*z1(j)))));                         % pipe had the head loss been identical to the water level z1 as explained in 'hints' 

    v(j)        = fzero(F1,vinitguess);                                     % the velocity is the value which 'fzero' returns as the one making the anonymous 
                                                                            % function F1 equal to zero

%% Trajectory computations                                                     

    v0z         = 0;                                                        % finding the vertical component of the nozzle velocity
    
    v0x         = v(j);                                                     % finding the horizontal component of the nozzle velocity
    
    zposition   = @(time) -0.5*g*time^2+v0z*time+s0;                        % creating an anonymous function 'zposition' which calculates the position of a
                                                                            % mass with initial velocity and position under the influence of gravity alone
                                                                            
    treachfloor = sqrt(2*s0/g);                                             % time for which the jet hits the surface, identical for all jets since they are 
                                                                            % horizontal and exiting at the same elevation (integrating 'g' twice with respect
                                                                            % to time  to get the distance travelled s0, which we know and use to find the time
                                                                            
    time        = 0;                                                        % the following for-loop needs to have a starting value for the variable 'time' 
        
    deltatime   = treachfloor/100;                                          % creating the time increment used tom find the coordinates for the trajectory positions
                                                                            
% Finding trajectory positions
        for k=0:100
            
            zjet(k+1,j)    = zposition(time);                               % we have already declared a function which computes the vertical position, so we
                                                                            % just call it.
        
            x(k+1,j)    = v0x*time;                                         % horizontal distance is horisontal velocity multiplied with the time
                                                                            
            time        = time+deltatime;                                   % increasing the time with one time increment
        end
    
    hf(j)=z1(j)-v(j)^2/(2*g);                                               % computing the head loss due to friction (not asked for in the assignment)

end
%% Creating the values to be used for plotting the water levels

waterlevely     = [z1'+s0,z1'+s0];                                          % creating a matrix of the y-positions of the horizontal water level lines,
                                                                            % in which the two identical columns contain the different z1's plus the elevation of the pipe

waterlevelx     = [-11.45*ones(length(z1'),1),-8.35*ones(length(z1'),1)];   % this is a matrix with two columns containing the constant x-positions for the left and the 
                                                                            % right sides of the tank, respectively, in each column.

%% Plotting in the supplied figure

open figureforassignment10.fig                                              % opening the supplied figure

plot(x,zjet)                                                                % plotting the vertical and horizontal positions that correspond to each jet

hold on

plot(waterlevelx',waterlevely')                                             % plotting the corresponding water level lines

ylim([0 24])                                                                % applying the specified axes limits
xlim([-12 6])

xlabel('Distance from nozzle [m]')                                          % labelling the axes
ylabel('Height above floor [m]')


legend([kron(ones(size(z1')),'z1 = '),num2str(z1'),...                      % adding the water levels, the computed head losses and the jet velocities into the legend
        kron(ones(size(hf')),', h_L = '),num2str(hf'),...
        kron(ones(size(v')), ', V_{jet} ='),num2str(v')])
