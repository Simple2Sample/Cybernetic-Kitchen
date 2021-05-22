%% Assignment 5 - matlab - TEP 4100

%% Problem:
%   exercise 4-33 [ Fluid Mechanics - Cengle and Cimbala sec. edit]:
%
%       Converging duct flow (Fig. P4-16) is modeled by the steady,
%       two-dimensional velocity field of Prob. 4-16. 
%       Generate an analytical expression for the flow streamlines.
% 
%
%   Additional matlab exercise:
%
%       Use matlab to plot the streamlines, for given constants
%       U0 = 1 [m/s], b = 5 and C = [-2:0.3:2]';
% 
%       Find a way to automatically put the values for the streamlines 
%       corresponding to different values for C in the legend of the
%       figure.
%       
%       Print the figure and hand it in with the rest of your answer for
%       the assignment.
%
%       Hints: 
%              use normal 2D plot:
%                   plot(x,y) with x = [0:0.1:2]; 
%              where y is a matrix, containing in each line the values of
%              one streamline.
%              
%              Find out how the commands "legend(....)" and num2str(...)
%              work!
%
%   Tilleggsoppgave for Matlab:
%       
%       Bruk matlab til å plotte strømlinjene for følgende konstanter:
%       U0 = 1 [m/s], b = 5 and C = [-2:0.3:2]';
% 
%       Finn en måte å automatisk sette verdiene for C som 
%       korresponderer med forskjellige strømlinjer inn i figurforklaringen
% 
%       Skriv ut figuren og lever inn sammen med resten av øvingen.
%
%       Hint: 
%              Bruk vanlig 2D plot:
%                   plot(x,y) med x = [0:0.1:2]; 
%              hvor y er en matrise som inneholder verdiene for en
%              bestemt strømlinje i en rad.
%              
%              Finn ut hvordan kommandoene "legend(....)" og num2str(...)
%              virker!
%
%% Solution:

%   The analytical expression is as for problem 4-33:
%   y=C/(U0+bx)

clear all
clc
close all

U0          = 4;                                                            % defining the constants
b           = 5;

C           = [-2:0.25:2]';                                                 % defining the span for the integration parameter C, this is created as a column vector                                                             % define colum vector with C
x           = [0:0.1:2];                                                    % defining the x grid
                                    
y           =    C*(1./ (U0+b*x));                                          % calculate streamlines, this syntax is a bit tricky to understand,
                                                                            % but think like this: C[n:1]*B[1:m]=D[n:m]. C is a column vector,
                                                                            % so we must multiply by a row vector if we use "*". This row vector
                                                                            % is created when the parenthesized term uses elementvise division.        

figure1     = figure('Name','Streamlines in a converging duct',...          % creating an empty figure with a name instead of the default 'Figure X'
        'NumberTitle','off');        

plot(x,y);                                                                  % this plots all the streamlines in the same figure.
    
legend(['Integration constant C= ',num2str(C(1))],...                       % here, the legend is made using "num2str", which converts a number to 
    ['Integration constant C= ',num2str(C(2))],...                          % a string format so that it can be used wherever text strings are needed.  
    ['Integration constant C= ',num2str(C(3))],...                          % As you see, the numeric values (but not number of elements) of C can be  
    ['Integration constant C= ',num2str(C(4))],...                          % changed and the legend is automatically changed accordingly.
    ['Integration constant C= ',num2str(C(5))],...
    ['Integration constant C= ',num2str(C(6))],...
    ['Integration constant C= ',num2str(C(7))],...
    ['Integration constant C= ',num2str(C(8))],...
    ['Integration constant C= ',num2str(C(9))],...
    ['Integration constant C= ',num2str(C(10))],...
    ['Integration constant C= ',num2str(C(11))],...
    ['Integration constant C= ',num2str(C(12))],...
    ['Integration constant C= ',num2str(C(13))],...
    ['Integration constant C= ',num2str(C(14))],...
    ['Integration constant C= ',num2str(C(15))],...
    ['Integration constant C= ',num2str(C(16))],...
    ['Integration constant C= ',num2str(C(17))]);

   
ylabel('y position [m]');                                                   % adding labels to the axes 
xlabel('x position [m]');




