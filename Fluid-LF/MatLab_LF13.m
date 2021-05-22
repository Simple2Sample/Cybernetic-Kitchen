
%% Assignment 13 - matlab - TEP 4100

%% Problem:
%   exercise 10-63 [ Fluid Mechanics - Cengel and Cimbala sec. edit]:
%
% 10-63   Water at atmospheric pressure and temperature  (rho = 998.2 kg/m3,
% and µ = 1.003 * 10^3 kg/(ms)) at free stream velocity V  = 0.100481 m/s
% flows over a two-dimensional  circular cylinder of diameter d = 1.00 m.
% Approximate the flow as potential flow.  (a) Calculate the Reynolds
% number, based on cylinder diameter. Is Re large enough that potential
% flow should be a reasonable approximation? (b) Estimate the minimum and
% maximum speeds |V |min  and |V |max  (speed is the magnitude of velocity)
% and the maximum and minimum pressure difference P - Pinf  in the flow,
% along with their respective locations.
% 
%
%   Additional matlab exercise:
%
%       Plot eleven non-dimensional streamlines of the potential flow valid
%       for the upper half of the cylinder for values of the dimensionless
%       stream function, psi*, from psi*= 0 to psi*=2. Use pi/100 as the
%       increment of the polar coordinate theta for high resolution. 
%       
%   Hints:
%       Page 522 in C&C is dedicated to this potential flow. So read this
%       for the necessary theory.
%       On each streamline, i.e. for each value of psi*, compute for each
%       value of theta the nondimensional radial coordinate r* of the
%       streamline.
%       Check out the command 'polar(..)' in order to plot using r-theta
%       coordinates.
%       Use the statements
%           ylim([-0 3])
%           xlim([-3 3])
%       from the start, because the equation describing the non-dimensional 
%       radius gives so high values for the radius that the autoscaling 
%       in Matlab will give the impression of something wrong in the 
%       calculations. 
% 
% Print out the plot and hand in with the rest of the assignment
% 
% Tilleggsoppgave for Matlab:
% 
%       Plot elleve dimensjonsløse strømlinjer for potensialstrømningen
%       gyldig for den øvre halvdelen av sylinderer for verdier av den
%       dimensjonsløse strømfunksjonen, phi*, fra phi* =0 til phi* =2. Bruk
%       pi/100 som inkrement for den polare koordinaten theta for å få høy
%       oppløsning.
%
%   Hint:
%       Side 522 i C&C er dedikert til denne potentialstrømningen, så les
%       dette for den nødvendige teori. 
%       På hver strømlinje, dvs. for hver verdi av psi*, beregn for hver
%       verdi av theta den dimensjonsløse radielle koordinaten r* av
%       strømlinjen. Finn ut hvordan kommandoen
%       'polar(..)' fungerer for å kunne plotte i r-theta koordinater.
%       Bruk setningene
%           ylim([-0 3])
%           xlim([-3 3])
%       fra begynnelsen av, fordi ligningen som beskriver
%       dimensjonsløs radius gir så høye verdier for radiusen at
%       autoskaleringen i Matlab får plottet til å se ut som at det er noe
%       galt i utregningene.
% 
% Skriv ut figuren og lever inn sammen med resten av øvingen.

%% Solution:

clear all
clc
close all

scrsz               = get(0,'ScreenSize');                                  % retrieving the size of the screen to position the figure
figsz1              = [scrsz(1)+100 scrsz(2)+...                            % setting a figure size and position
                        100 scrsz(3)-200 scrsz(4)-200]; 

Vinf                = 1.00043;                                              % setting the uniform flow velocity
a                   = 0.5;                                                  % setting the radius a of the cylinder
K                   = Vinf*a^2;                                             % determining the doublet strength

thetavec            = [1:99]*pi/100;                                        % creating a vector of the specified angles theta avoiding 0 and pi

constpsi_nondim     = linspace(0,2,11);                                     % creating a vector of the specified dimensionless stream function
                                                                            % values for the streamlines

figure1             = figure('Position',figsz1,'Name',...                   % creating an empty figure with a name instead of the default 'Figure X'
                    ['Potential flow around a cylinder; the combination',... 
                    ' of a uniform flow and a doublet'],'NumberTitle','off');         

hold on
grid on

for j=1:length(constpsi_nondim)                                             % one streamline at a time,...

    for i=1:length(thetavec)                                                % ...going through all the specified angles,...
        
            rstreamline_nondim(i,j)   = (constpsi_nondim(j) +...            % ...we compute the values for non-dimensional radius using formula 10.57 
            sqrt((constpsi_nondim(j))^2 +...
            4*sin(thetavec(i))^2))/(2*sin(thetavec(i)));

            thetamatrix_for_plot(i,j) = thetavec(i);                        % the radii for the streamlines above are stored in a matrix, so to make plotting
                                                                            % easier using a one-line statement we create an equally sized matix where
                                                                            % all columns are identical  
    end
    
end

% The rest is plotting using the polar-plot command 'polar'

polar(thetamatrix_for_plot(:,end:-1:1),rstreamline_nondim(:,end:-1:1));     % making the plot starting from the last value for the streamline function (last column)
                                                                            % and going to the first value, the reason for this is to start plotting the highest
                                                                            % streamline because 'legend' will place the first entry at upper position, and
                                                                            % in this way the uppermost streamline will correspond to the uppermost legend.
                                                                            % This is just "pimping" of the figure and of course not needed at all.

ylim([-0 3])                                                                % applying specified axes limits
xlim([-3 3])

xlabel('Dimensionless position, x*')                                        % labelling the axes
ylabel('Dimensionless position, y*')


current_axes=gca;                                                           % using the command 'gca' which is short for gETcURRENTaXES to create a handle called
                                                                            % current_axes....

set(current_axes,'PlotBoxAspectRatio',[1 0.5 1])                            % ... and setting the property 'PlotBoxAspectRatio' of the handle to [1 0.5 1],
                                                                            % ensuring equal axes ratios, since 'xlim' is two times 'ylim'.


leg(1:length(constpsi_nondim)-1)=cellstr(strcat...                          % creating the legend entries all but the last, and going backwards as for the plotting
     ('\Psi = ',num2str(constpsi_nondim(end:-1:2)')));                      % to make the values used in the legend to actually correspond to the right lines
             
leg(length(constpsi_nondim))=cellstr(strcat...                              % the last legend entry (for the first value of the streamline function) is given an
    (['\Psi = ',num2str(constpsi_nondim(1)),', cylinder wall']));           % addition, explaining that this is the line equivalent to the cylinder wall

legend(leg,'Location','NorthEast');

