
%% Assignment 6 - matlab - TEP 4100

%% Problem:
%   exercise 4-104 [ Fluid Mechanics - Cengel and Cimbala sec. edit]:
%
%       Consider fully developed axisymmetric Poiseuille flow in a round 
%       pipe of radius R (diameter D = 2R), with a forced pressure gradient
%       dP/dx driving the flow as illustrated in Fig. P4-104. 
%       (dP/dx is constant and negative.) The flow is steady, 
%       incompressible, and axisymmetric about the x-axis. The velocity 
%       components are given by u=(r^2-R^2)(dP/dx)/(4\mu), u_r=0, u_\theta=0, 
%       where mu is the fluid viscosity. 
%       Is this flow rotational or irrotational? If it is rotational, 
%       calculate the vorticity component in the circumferential (theta) 
%       direction and discuss the sign of the rotation.
% 
%
%%  Additional matlab exercise:
%
%       Use matlab to plot the Poiseuille flow profile, for given constants
%       R = 1 m, dP/dx = -50 Pa/m, for the fluid viscosities mu = 0.5, 1 
%       and 2 kg/(m s).
%       In the last Matlab exercise the procedure in the solution to create
%       a legend was rather tedious and not flexible with respect to number
%       of plots. After the last plot command, use the syntax below to 
%       create a general legend in a much simpler way. 
%       Assume MU to be the column vector with the viscosity values above.
%
%           for i=1:length(MU)
%                D{i}=strcat('mu= ',num2str(MU(i)'));
%           end
%           legend(D);
%
%       You should read in the product help what 'strcat' and 'num2str' do.
%
%       In the solution you can find an even more elegant way of doing this
%       as a single line statement!
%
%       Can you find a way to display the actual symbol which we call "mu" 
%       in the legend? 
%       
%       Print out the plot of the velocity profiles and hand it in with the 
%       rest of the assignment.
%
%       Hints: 
%             plot more than one line with the standard 2D plot:
%                   >> plot(x_func1, y_func1, x_func2, y_func2, ...)
% 
%             define the radius from -R to R, then the whole profile is
%             displayed
%                   >> r = [-1:0.01:1]*R;
%
%             Matlab understands TeX language for writing symbols,
%             subscripts et.c., you should check out how to utilize this
%             feature in matlab, by searcing in 'help' using the phrase:
%             "Mathematical Symbols, Greek Letters, and TeX Characters"
%
%
%
%%  Tilleggsoppgave for Matlab:
%
%       Bruk Matlab til å plotte Poiseuille hastighetsprofil for gitte
%       konstanter R = 1 m, dP/dx = -50 Pa/m, og for fluider med viskositet 
%       mu =0.5, 1 og 2 kg/(m s).
%       I forrige matlaboppgave var det i løsningen en prosedyre for å lage
%       "legend" som var ganske arbeidskrevende og lite fleksibel med tanke
%       på varierende antall grafer. Etter det siste plot kommandoet 
%       bruk syntaksen nedenfor til å lage en
%       legend som tar høyde for dette og som er mye enklere å skrive.
%       Anta at MU er en kolonnevektor med verdiene for viskositet ovenfor.
%
%           for i=1:length(MU)
%                D{i}=strcat('mu= ',num2str(MU(i)'));
%           end
%           legend(D);
%
%       Du bør lese i produkthjelpen hva 'strcat' og 'num2str' gjør.
%
%       I løsningen kan du finne en enda mer elegant måte å gjøre dette på
%       ved hjelp av kun en enkelt setning!
%
%       Kan du finne en måte å få vist det faktiske symbolet vi kaller mu
%       i figurforklaringen? 
%       
%       Print ut figuren med hastighetsprofilene og lever inn med resten av 
%       øvingen.
%
%       Hint: 
%             plot flere enn en graf med standard 2D plot:
%                   >> plot(x_func1, y_func1, x_func2, y_func2, ...)
% 
%             definer radiusen fra -R til R, da får man fram hele profilet
%                   >> r = [-1:0.01:1]*R;
%
%             Matlab forstår TeX-formatering for å skrive symbol,
%             indekser etc., du bør sjekke ut hvordan man kan utnytte
%             denne funksjonaliteten i matlab, feks ved å søke i 'hjelp'
%             med frasen:
%             "Mathematical Symbols, Greek Letters, and TeX Characters"

%% Solution:
clear all
clc
close all

dPdx        = -50;                                                          % defining the pressure gradient

R           = 1;                                                            % Defining the radius of the pipe

r           = [-1:0.01:1]*R;                                                % Creating a vector with radial positions spaced by 0.01 m

MU          = [0.5,1,2]';                                                   % column vector for mu, here capital letters are use to avoid
                                                                            % confusion with the function 'mu', intrinsic to new versions of matlab.

u1          = 1/(4*MU(1)) * dPdx * (r.^2-R^2);                              % Calculating the three velocity profiles corresponding to the three mus
u2          = 1/(4*MU(2)) * dPdx * (r.^2-R^2);
u3          = 1/(4*MU(3)) * dPdx * (r.^2-R^2);

figure1     = figure('Name','Velocity profiles computed in a brute way',... % creating an empty figure with a name instead of the default 'Figure X'
        'NumberTitle','off');

plot(u1,r,u2,r,u3,r)                                                        % Using a standard 2D plot to plot the three profiles at the same time

xlabel('magnitude of local axial velocity')                                 % labelling the axes
ylabel('radial position')

for i=1:length(MU)                                                          % creating the legend using the supplied statement 
    D{i}    = strcat('mu= ',num2str(MU(i)'));
end

legend(D);

%% A more sophisticated solution:

clear all
clc
% close all

dPdx        = -50;                                                          % defining the pressure gradient (We have cleared all and must start over again)
R           = 1;                                                            % Defining the radius of the pipe
r           = [-1:0.01:1]*R;                                                % Creating a vector with radial positions spaced by 0.01 m

MU          = [0.5,1,2]';                                                   % column vector for mu

u           = 1./MU*(dPdx/4*(r.^2-R^2));                                    % matrix with one flow profiles in each line

figure2     = figure('Name','Velocity profiles computed in a more sophisticated way',... % creating an empty figure with a name instead of the default 'Figure X'
        'NumberTitle','off');

plot(u,r)                                                                   % plotting the profiles using standard 2D plot with a mtrix and vector as input

xlabel('magnitude of local axial velocity')                                 % labelling the axes
ylabel('radial position')

legend([kron(ones(size(MU)),'\mu = '),num2str(MU)])                         % Creating the legend using a single line statment, also including the mu-symbol by 
                                                                            % adding the backslash just before the symbol name (which is 'mu')!


