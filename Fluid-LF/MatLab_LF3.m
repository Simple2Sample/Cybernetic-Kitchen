%% Assignment 3 - matlab - TEP 4100

%% Problem:
%   exercise 3-75 [ Fluid Mechanics - Cengel and Cimbala 2nd. edition in SI units]:
%
%       A retaining wall against a mud slide is to be constructed by
%       placing 1.2 m high and 0.25 m wide rectangular concrete blocks (rho
%       = 2700 kg/m^3) side-by-side, as shown in figure P3-75. The friction
%       coefficient between the ground and the concrete blocks is f=0.3,
%       and the density of the mud is about 1800kg/m^3. There is concern
%       that the concrete blocks may slide or tip over the lower left edge
%       as the mud level rises. Determine the mud height at which (a) the
%       blocks will overcome friction and start sliding and (b) the blocks
%       will tip over.
%       
%   Additional matlab exercise:
%
%       Use matlab to plot the mud heights for which the blocks start to
%       slide as a function of block width ranging from 0.05 m to 1 m with
%       increments of 0.05 m, and for two different values for the friction
%       coefficient, f=0.3 and f=0.6. Plot also at which height the blocks
%       will tip as a function of block width. All three plots must be in
%       the same figure and the figure must have a legend.
%
%       Hints:
%              All scripts should start with the 2 commands
%                       clear all   <- clears the workspace variables
%                       clc         <- clears the command window
%              And if all old figures should be closed as well
%                       close all   <- closes all figures 
%
%              To create a vector from e.g. 1 to 3 with increments 0,5 use
%                       >> vector = [1:0.5:3]  
%                          ans = 1 1.5 2 2.5 3
%              
%             A column vector A with dimensions [N:1] multiplied
%             by a row vector B with dimensions [1:M] creates a matrix C
%             (C=A*B)with dimensions [N:M]. Here, the column vector A could
%             consist of the two friction factors and the row B vector of 
%             the block weights corresponding to the different widths,
%             which multiplied would give a matrix C of the friction forces
%  
%   Tilleggsoppgave for Matlab:
%
%       Bruk Matlab til å plotte gjørmehøydene som får betongblokkene til å
%       gli som funksjon av bredde fra 0.05 m til 1 meter med 0.05 m i
%       inkrement. Gjør dette for to forskjellige verdier for
%       friksjonskoeffisienten, f=0.3 og f=0.6. Plott også gjørmehøydene
%       som får blokkene til å velte som funksjon av bredden. Alle tre 
%       plottene må være i samme figur, og figuren må ha forklaring av hva 
%       som vises (legend)

%       Hint:
%              Alle script bør starte med de tre kommandoene
%                    clear all   <- sletter variable som finnes i workspace
%                    clc         <- sletter det som står i kommandovinduet
%              Og hvis gamle figurer skal fjernes
%                       close all   <- closes all figures% 
%
%              For å lage en vektor fra feks 1 to 3 med inkrement på 0,5,
%              bruk
%                       >> vector = [1:0.5:3]  
%                          ans = 1 1.5 2 2.5 3
%              
%             En kolonnevektor A med dimensjon [N:1] multiplisert med en 
%             radvektor B med dimensjon [1:M] lager en matrise C (C=A*B)
%             med dimensjoner [N:M], i denne oppgaven kan A være en
%             kolonnevektor som består av de to friksjonskoeffisientene og 
%             radvektoren B kan bestå av vekten til klossene som
%             korresponderer med de forskjellige breddene, matrisen C ville
%             da beskrive de korresponderende friksjonskreftene
% 

%% Solution:

clear all
clc
close all

g   = 9.81;                                                                 % defining the gravitational constant

rho_block= 2700;                                                            % defining the density of the block

rho_mud=1800;                                                               % defining the density of the mud

height_block=1.2;                                                           % defining the height of the block

fric_coeff=[0.3, 0.6]';                                                     % creating the column vector consisting of the two friction coefficients,
                                                                            % notice that a simple "'" is sufficient to change from a row vector to a column vector

width=[0.05:0.05:1];                                                        % creating a row vector consisting of the desired widths

weight_block=rho_block*g*height_block*width;                                % calculating the vector of weights corresponding to the specified widths

Force_friction=fric_coeff*weight_block;                                     % calculating the matrix of friction forces as explained in the hint

height_mud_slide=sqrt(Force_friction/(rho_mud*g/2));                        % calculating the heights for which the blocks slide. This will be a matrix since
                                                                            % "Ffriction" is a matrix 

height_mud_tip = (3*weight_block.*width/(rho_mud*g)).^(1/3);                % calculating the heights for which the blocks tip. "weight_block" and "width" are
                                                                            % both vectors, so we need to use elementwise multiplication, ".*", as well as 
                                                                            % elementwise power, ".^" 

figure1=figure(1);                                                          % creating an empty figure named "figure1"

hold on                                                                     % "hold on" is necessary to have many plots in the same figure, otherwise only the last 
                                                                            % plot would show

plot(width, height_mud_slide(1,:),'LineStyle','-.','Color','g',...          % this plots the first row of the matrix "height_mud_slide". For more information about
    'DisplayName','height of mud when blocks slide, f=0,3')                 % the syntax for the function"plot" type "help plot" or the more descriptive "doc plot"
                                                                            % in the command window (The latter opens the help window for matlab". Notice that using
                                                                            % three dots "..." allow for a line break without a break in Matlabs interpretation of the code

plot(width, height_mud_slide(2,:),'LineStyle','-.','Color','b',...          % this plots the second row of the matrix "height_mud_slide".
    'DisplayName','height of mud when blocks slide, f=0,6')

plot(width, height_mud_tip,'LineStyle','-','Color','r',...                  % this plots the vector "height_mud_tip".
    'DisplayName','height of mud when blocks tips')

ylabel('Mud height [m]');                                                   % adding labels to the axes 
xlabel('Block width [m]');

legend('show')                                                              % since we have defined the property "DisplayName" in our plot commands, writing legend('show')
                                                                            % automatically use these properties to create a legend for the figure. 


%% Creating a textbox with a comment to the plot!

annotation(figure1,'textbox',...
    [0.55 0.30 0.2 0.1],...
    'String',{'Notice that for f=0,6 the first danger for',...
    'blocks narrower than approx. 0,35 m is',...
    'tipping, not sliding. This is because a',...
    'rising mud height will first reach the'...
    'level for tipping. For wider blocks it will'...
    'first reach the level for sliding'},...
    'FitBoxToText','on');
