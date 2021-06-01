%% Assignment 4 - matlab - TEP 4100

%% Problem:
%   exercise 4-5 [ Fluid Mechanics - Cengle and Cimbala 2nd. edition in SI units]:
%
%       Consider the following steady, two-dimensional velocity field:
%
%         V = (u, v) = ( a^2 -( b^2 - cx )^2 )i + (-2cby + 2c^2 xy)j
%
%       Is there a stagnation point in this flow field? If so, where is it?
%
%   Additional matlab exercise:
%
%       Use matlab to plot the velocity field, for given constants
%       a = 0.6, b = 0.5, c = 0.2
%       Where is the stagnation point? Is it the only one? If not,
%       where are the other stagnation points?

%       Print the figure and hand it in with the rest of your answer for the assignment.
%
%       Hints: define 2D grid with:
%               [x,y] = meshgrid(0:0.5:2, -2:0.5:2);
%              
%              use vector plots to visualize the velocities
%               quiver(x,y,u,v):
%
%              to square a vector element-wise use .^
%                   e.g. >> x=[3,4]; 
%                        >> x.^2
%                           ans = 9  16
%              to multiply two vectors element-wise, use .*
%                   e.g. >> x = [2,3]; 
%                        >> y = [3,4];
%                        >> x .* y 
%                           ans =  6  12
%
%   Tilleggsoppgave for Matlab:
% 
%       Bruk Matlab til å plotte hastighetsfeltet, for de gitte konstanter
%       a = 0.6, b = 0.5, c = 0.2
%       Hvor er stagnasjonspunktet? Er dette det eneste?
%       Hvis ikke, hvor er de(t) andre stagnasjonspunkte(ne/t)?
%       
%       Print ut figuren og legg ved øvingen din som besvarelse på MatLab-oppgaven.
%
%       Hint:  Definer 2D grid ved å bruke:
%               [x,y] = meshgrid(0:0.5:2, -2:0.5:2);
%              
%              Bruk vektorplot til å visualisere hastighetene
%               quiver(x,y,u,v):
%
%              For elementvis kvadrering av en vector bruk .^
%                   feks >> x=[3,4]; 
%                        >> x.^2
%                           ans = 9  16
%              For elementvis multiplikasjon av to vektorer bruk .*
%                   feks >> x = [2,3]; 
%                        >> y = [3,4];
%                        >> x .* y 
%                           ans =  6  12

%% Solution:
clear all
clc
close all

a       = 0.6;                                                              % setting the constants
b       = 0.5;
c       = 0.2;

[x,y]   = meshgrid(-2:0.5:2, -2:0.5:2);                                     % define 2D grid 

                                                                            
u       = a^2 - (b-c*x).^2;                                                 % calculate the velocities u,v corresponding to the values of our grid
v       = -2*c*b*y + 2*c^2*x.*y;

scaling = 0;                                                                % "quiver(x,y,u,v)" autoscales the length of the vectors so that the vectors don't overlap. 
                                                                            % "quiver(x,y,u,v,scaling)" can scale the vectors according to the number assigned to "scaling", 
                                                                            % and if "scaling" is set to zero the autoscale feature of "quiver" is turned off. You can play 
                                                                            % with this value and see what happens. 

figure1 = figure('Name','Vector plot of a velocity field',...               % creating an empty figure with a name instead of the default 'Figure X'
    'NumberTitle','off');                                                        


quiver(x,y,u,v,scaling)                                                     % create plot with vectors that are scaled (or in this case not scaled since 'scaling' is 0

ylabel('y position [m]');                                                   % adding labels to the axes 
xlabel('x position [m]');

%% For advanced users:
%  Making plots more fancy: Changing the color of each vector to be dependent
%  of the length of the vector and pointing to the stagnation point

velolength  =   (u.^2+v.^2).^(0.5);                                         % creating a matrix consisting of the lengths of the vectors

normvelo    =   velolength/max(max(velolength));                            % creating a normalized matrix where all values are between 0 and 1. This will be explained below. 

numcol      =   length(u(1,:));                                             % finding the number of columns in u (and v) matrix (we need this as a counting variable later)

numrow      =   length(u(:,1));                                             % finding the number of rows in u (and v) matrix (we need this as a counting variable later)

figure2     =   figure('Name','Colored vector plot of a velocity field',... % creating an empty figure
                'NumberTitle','off');                                                        

hold on                                                                     % we are going to plot more than one object in the figure (see below)

for k= 1:numcol
    for i= 1:numrow
               
        quiver(x(i,k),y(i,k),u(i,k),v(i,k),scaling,...
            'Color',[normvelo(i,k) (1-normvelo(i,k)) 0]);                   % create plot with vectors, one at a time. Specifying color for the vector can also be made using 
                                                                            % numberical code defining the RGB value. Instead of writing "...'Color','r',...." one can write 
                                                                            % "...'Color',[1 0 0],....", but all values between 0 and 1 can be used to create a smooth color 
                                                                            % transition. We have created a matrix with values between 0 and 1 describing the length of the 
                                                                            % vectors which we can use for this purpose! Feel free to play with different variants of 
                                                                            % (1-normvelo(i,k)) and normvelo(i,k) in the three positions defining the RGB value and see how 
                                                                            % this affects the plot
    end
end

ylabel('y position [m]');                                                   % adding labels to the axes
xlabel('x position [m]');

axPos       = get(gca,'Position');                                          % gca gets the handle to the current axes

xMinMax     = xlim;                                                         % xlim and ylim returns a vector of the limits of the respective axes 
yMinMax     = ylim;

xstag       = (b-a)/c;                                                      % computing the x and y coordinates of the stagnation point
ystag       = 0;

xAnnotation = axPos(1) + ((xstag - xMinMax(1))/...                          % Finds the x position relative to the plot window in the figure corresponding to the stagnation 
    (xMinMax(2)-xMinMax(1))) * axPos(3);                                    % point coordinates (we need this because "annotation(....) positions an object regardless of the 
                                                                            % axis in the figure but in a position relative to the plot window)

yAnnotation = axPos(2) + ((ystag - yMinMax(1))/...
    (yMinMax(2)-yMinMax(1))) * axPos(4);
                                                                
annotation(figure2,'textarrow',[xAnnotation+0.1 xAnnotation],...            % Create textarrow
    [yAnnotation+0.1 yAnnotation],'TextEdgeColor','none',...
    'String',{'Stagnation point'});

% Comment: The arrowheads in the last plot become very small. Changing this is not easy. 
% However, there are a lot of people using matlab around the world, and someone has come up 
% with a solution to this. By visiting:
%
% "http://www.mathworks.com/matlabcentral/fileexchange/34305-adjust-quiver-arrowhead-size 
%
% and downloading the file (save it in the current folder) one can write
%
% h=quiver(x(i,k),y(i,k),u(i,k),v(i,k),scaling,'Color',[normvelo(i,k) (1-normvelo(i,k)) 0]);
%         adjust_quiver_arrowhead_size(h,5);
%
% inside the "for"- loops and the arrowheads are made bigger.
                                                                            
                                                                         
      


