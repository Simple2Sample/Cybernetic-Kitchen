%% Assignment 11 - matlab - TEP 4100

%% Problem:
%   exercise 9-92 [ Fluid Mechanics - Cengle and Cimbala sec. edit]:
%
%       Repeat Example 9-17, except for the case in which the wall is 
%       inclined at angle alpha (Fig.P9-92). Generate expressions for both the 
%       pressure and velocity fields. As a check, make sure that your 
%       result agrees with that of Example 9-17 when alpha = 90 degrees. 
%       [Hint: It is most convenient to use the (s, y, n) coordinate system
%       with velocity components (us , v, un ), where y is into the page 
%       in Fig. P9-92. Plot the dimensionless velocity profile u* versus 
%       n* for the case in which alpha = 60 degrees.]
%
%   Additional matlab exercise:
%
%       Plot the dimensionless velocity profile u* versus n* for ten angles
%       alpha equally spaced between 90 degrees and 0 degrees, i.e the wall goes
%       from vertical to horizontal alignment. Plot some local velocity vectors
%       for the profiles as well.
%
%       Print the plot and hand in with the rest of the assignment.
%       
%       Optional for the eager student:
%           Can you orientate the plot so that the x-axis in the plot has
%           the same inclination as the wall? See if you can make an
%           animation of the profiles in which the plot is rotated according
%           to the different angles of the wall.
%           
%       Hints:
%           No particular hints necessary to solve the first task.
%           For the optional task one should check out how the command
%           'view()' works, and for layout and visual ease it is not a
%           stupid idea to investigate the command 'pause(duration)' and
%           how to delete previous plots (delete(axesX))
%           
%   Tilleggsoppgave for matlab:
%
%       Plott det dimensjonsløse hastighetsprofilet u* vs n* for ti vinkler
%       alpha likt fordelt mellom 90 grader og 0 grader, mao veggen går fra å være
%       vertikal til å være horisontal. Plott noen lokale
%       hastighetsvektorer for profilene også.
%
%       Print ut plotte og lever inn sammen med resten av øvingen.
%       
%       Frivilling for den ivrige student:
%           Kan du rotere plottet slik at x-aksen i plottet har samme
%           helning som veggen? Se om du kan lage en animasjon av profilene
%           der plottet roterer i henhold til det forskjellige vinklene til
%           veggen.
%           
%       Hint:
%           Ingen spesielle hint nødvendig for å løse første del. For den
%           frivillige oppgaven bør man sjekke ut hvordan kommandoen
%           'view()' virker, og for visningsvennlighetens skyld er det ikke
%           dumt å sjekke ut kommandoen 'pause(varighet)' og hvordan man
%           sletter tidligere plot ('delete(axesX)')
%           
%% Solution:
clear all
close all
clc
% Purely for figure layout
scrsz           = get(0,'ScreenSize');                                      % retrieving the size of the screen to position the figure
figsz1          = [scrsz(1)+100 scrsz(2)+100 scrsz(3)/2-100 scrsz(4)-200];  % making the four element vector for figure position

figure1     	= figure('Position',figsz1,'Name',...                       % creating an empty figure with a specified position and a
                    ['Oil film flow over a wall with',...                   % name instead of the default 'Figure X'.  
                    'decreasing inclination'],'NumberTitle','off');         

axes1           = axes('Parent',figure1,'PlotBoxAspectRatio',[1 1 1]);      % creating the axes to plot in (plots are actually made in axes, not in figures.
                                                                            % ('Parent',figure1) says that axes1 belongs in figure 1,'PlotBoxAspectRatio',[1 1 1]
                                                                            % sets the relative scale for the axis (x and y) equal

ylim([0 1.4])                                                               % applying specified axes limits
xlim([0 0.5])

box(axes1,'on');                                                            % creates a box frame around the plot
hold(axes1,'all');                                                          % holds everthing that has been specified for axes1

% Computations
nProfiles       = 10;                                                        % specifing the number of profiles to plot

alpha_start     = 90;                                                       % calculating the values for alpha depending on start-, 
alpha_end       = 0;                                                        % end-value, and number of profiles
delta_alpha     = (alpha_end-alpha_start)/(nProfiles-1);
alpha           = [alpha_start:delta_alpha:alpha_end];

n               = [0:0.1:1];                                                % positions in n-direction to find the velocities at evenly spaced between 0 and 1                                                 

for i=1:length(alpha)
    
    us(:,i)         = n/2.*(2-n)*sind(alpha(i));                            % computation of the velocity component 'us' parallel to the plate (s direction)
    
end

nArrows         = 6;                                                        % number of arrows to plot for the local velocity vector

for i=1:length(alpha)
    
            N(i,:)  = [0:1/(nArrows-1):1];                                  % positions of the arrows in the oil film evenly spaced between 0 and 1
            Us(i,:) = N(i,:)/2.*(2-N(i,:))*sind(alpha(i));                  % computing the velocity parallel to the wall at the N locations 
            V(i,:)  = zeros(1,nArrows);                                     % the normal velocity component is always zero
            S(i,:)  = zeros(1,nArrows);                                     % all s-values are zero for the start of all arrows
                        
end

% Plotting

plot(us,n,'Parent',axes1)                                                   % the velocity profile                  
quiver(S,N,Us,V,0,'Parent',axes1)                                           % the local velocity vectors

ylabel('dimensionless position from the wall')                              % labelling the axes
xlabel(['dimensionless velocity',sprintf('\n'),'parallell to the wall'])    % Notice that ['text1',sprintf('\n'),'text1'] creates a line shift
                                                                            % between text 1 and text 2

% Creating a legend
leg(1:length(alpha))=cellstr(strcat...                                      % the first elements in the legend are the velocity profiles
    ('velocity profile at \alpha = ',num2str(alpha'),'^o'));                           
                                                                                                                                                        
leg(length(alpha)+1)={'local velocities'};                                  % the last element is explaining what the arrows are
                                                                            
legend(leg,'Location','SouthEast');                                         % inserting the legend defined by 'leg' in the figure


%% Solution to the "optional for the eager student"- task 

figsz2 = [figsz1(1)+figsz1(3)+20 figsz1(2) figsz1(3) figsz1(4)];            % making a new vector for the position of the new figure

figure2             = figure('ActivePositionProperty','OuterPosition',...   % creating an empty figure2 with a new position
             'Position',figsz2,'Name',['Oil film flow animation over ',... 
             'a wall with decreasing inclination'],'NumberTitle','off');       

nView_deg           = 90;                                                   % defining how many angles we want to view
view_deg_start      = 90;                                                   % start, end and incremental values
view_deg_end        = 1;
view_deg_increment  = (view_deg_end-view_deg_start)/(nView_deg-1);

i=0;                                                                        % nulling a counter used in the for-loop below
for view_deg = view_deg_start:view_deg_increment:view_deg_end;
    
    i       =   i+1;                                                        % updating counter
    alpha   =   view_deg;                                                   % the computational angle is the same as our view angle
    n       =   [0:0.1:1];
    us      =   n/2.*(2-n)*sind(alpha);
    
    axes2   = axes('Parent',figure2,'PlotBoxAspectRatio',[1 1 1]);          % axes2 is defined inside the for-loop because at the end of each plotting we
                                                                            % must delete it, otherwise all plots will be saved and partially visible  
    
    ylim([0 1.4])                                                           % applying specified axes limits
    xlim([0 0.5])
    
    box(axes2,'on');                                                        % creates a box frame around the plot
    hold(axes2,'all');                                                      % hold everything defined in axes2

    nArrows = 6;                                                            % number of arrows to plot for the local velocity vector
    
    N       = [0:1/(nArrows-1):1];                                          % positions of the arrows in the oil film evenly spaced between 0 and 1
    Us      = N/2.*(2-N)*sind(alpha);                                       % computing the velocity parallel to the wall at the N locations
    V       = zeros(1,nArrows);                                             % the normal velocity component is always zero
    S       = zeros(1,nArrows);                                             % all s-values are zero for the start of all arrows

    % Plotting
    plot(us,n,'Parent',axes2)
    quiver(S,N,Us,V,0,'Parent',axes2)
    
    ylabel('dimensionless position from the wall')                          % labelling the axes
    xlabel(['dimensionless velocity',sprintf('\n'),'parallell to the wall'])
    
    legend(['velocity profile at \alpha= ',num2str(alpha),'^o'],...                % creating a legend
        'local velocites','Location','NorthEast')
    
    view(axes2,[alpha 90]);                                                 % here, the rotation of the plot occurs, read how view works!
    
    pause(0.1)                                                              % pause(duration) makes matlab take a pause of the specified duration. Write 'pause'
                                                                            % alone and one must press a key to proceed in the script
    if view_deg~=view_deg_end
    
        delete(axes2)                                                       % we must delete axes2, othervise all plots will be saved and partially visible,
                                                                            % comment this line and see what happens  

    end

end



