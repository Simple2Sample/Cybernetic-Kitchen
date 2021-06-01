%% Assignment 9 - matlab - TEP 4100

%% Problem for Matlab:
%   
%       Plot your own Moody chart. Your solution should contain the use of
%       an anonymous function made on the basis of the Colebrook equation
%       and then use the built-in function 'fzero' to find the values for
%       which this anonymous function is zero (see how an anonymous function
%       works by opening the Product Help and clicking on the following
%       path: MATLAB > Demos > Programming > Anonymous function). Remember
%       to add a legend to the chart which identifies the epsilon/D for
%       each line.
%
%       Print the chart and hand in with the rest of the assignment.
%       
%
%       Hints:
%
%       The Colebrook equation (eq. 8-50 in C&C) in an implicit equation
%       which must be solved by some iterative scheme. If you make an
%       anonymous function as the left hand side of Colebrook's equation
%       minus the right hand side of Colebrook's equation you can find the
%       value for f which make this anonymous fuction zero by letting the
%       function 'fzero' work it's magic on the anonymous function. Try
%       something like
%
%            frictionfactor=fzero('anonymous function','starting value')
%
%       and remember to find the friction factor for a set of values for
%       both epsilon/D and the Reynolds number.
%       To plot using logarithmic axes you should check out the
%       command 'loglog(   )'
%
%% Oppgave for Matlab:
%
%       Plot ditt eget Moody-diagram. Løsningen din bør inneholde bruken av
%       en anonym funksjon som baserer seg på Colebrook-ligningen, og i
%       tillegg bruke den innebygde funksjonen 'fzero' for å finne verdier
%       som gjør at den anonyme funksjonen blir null(se hvordan en anonym
%       funksjon fungerer ved å åpne Produkthjelpen i Matlab og klikk deg
%       videre på stien: MATLAB > Demos > Programming > Anonymous function).
%       Husk å lage en figurbenevnelse som viser verdien epdilon/d for hver
%       linje.
%
%       Print ut diagrammet og lever inn sammen med resten av øvingen.
%
%       Hint:
%
%       Colebrook-ligningen er en implisitt ligning som må løses vhja en
%       iterativ prosedyre. Hvis du lager en anonym funksjon som
%       venstresiden av Colebrook-ligningen minus høyresiden av
%       Colebrook-ligningen kan du finne når denne anonyme funksjonen er
%       null ved å la funksjonen 'fzero' utøve sin magi på den anonyme
%       funksjonen. Prøv med noe some ligner på
%
%             frictionfactor=fzero('anonymous function','starting value')
%
%       og husk å finne frictionfactor for et sett verdier både for
%       epsilon/D og Reynoldstallet.
%       For å plotte med logaritmiske akser bør du sjekke ut kommandoen
%       'loglog(   )'

%% Script making a plot of a Moody chart. Matlab exercise 9, TEP4100
% By: Arne Ilseng


clear all
close all

%% Calculations for the laminar flow regime

Rel             =500:100:2300;                                              % Creating a vector of Reynolds numbers for the laminar flow
fl              =64./Rel;                                                   % Elementwise division to find the laminar friction factor

figure1  = figure('Name',...                                                % creating an empty figure with a name instead of the default 'Figure X'
               'My very own Moody chart',... 
               'NumberTitle','off');

loglog(Rel,fl,'k')                                                          % Plot line for laminar flow using logarithmic axis for both abscissas.

hold on                                                                     % we must plot the friction facors for the turbulent flow regime in the same figure,
                                                                            % so we must set the value for hold to 'on'

%% Calculations for the turbulent flow regime

e_D     =logspace(-2,-7,6);                                                 % Creating a vector where epsilon/D varies logarithmically from 10^-7 to 10^-2 but 
                                                                            % in decreasing value which will fit better with the legend (Lowermost line will
                                                                            % correspond to lowest legend entry). You should try a linear variation like 
                                                                            % e_d=linspace(10^-7,10^-2,10) and see how that changes the plot

Re=logspace(3.6,8,100);                                                     % Creating a vector where Re varies logarithmically from 10^3.6 to 10^8 
                                                                            % (log10(4000)=3.6). You should try a linearvariation like Re=linspace(10^3.6,10^8,100)
                                                                            % and see how that changes the plot

f=zeros(length(Re), length(e_D));                                           % Preallocating f to reduce computation time. Matlab uses much less time putting things into
                                                                            % existing cells in a matrix than it does putting things into cells which it has to 
                                                                            % create as the script progress
                                                                            
for i=1:length(Re)                                                          % Going through all Reynold numbers
    
   for l=1:length(e_D)                                                      % Going trough all values of epsilon / D
       
    z=@(f)(1/sqrt(f))+2*log10(e_D(l)/3.7+2.51/(Re(i)*sqrt(f)));             % creating an anonumous function of Colebrook's formula
                                                                            % ((new anonymous function z)=(left hand side of Colebrook)-(right hand side of Colebrook)),
                                                                            % instead of a function.m -file. See how this works by opening the Product Help and
                                                                            % clicking on the following path: MATLAB > Demos > Programming > Anonymous function.
                                                                            % The variable 'f' in the anonymous function is as with a function.m -file invisible to
                                                                            % the rest of the script, so writing f()=... below doesn't affect anything
                                                                            
    f0=(-1/(1.8*log10(6.9/Re(i)+(e_D(l)/3.7)^1.11)))^2;                     % Haaland's formula used to determine starting value for finding the root of Colebrook's equation
        
    f(i,l)=fzero(z,f0);                                                     % using fzero to find when the anonymous function is zero, i.e. for what value of f in z
                                                                            % (corresponding to e_D(l) and Re(i)) which makes left hand side of Colebrook's
                                                                            % formula equal to right hand side of Colebrook's formula. The answer is assigned to the 
                                                                            % variable f(i,l) 
                                                                             
    
   end
   
end

%% Creating the rest of the plot for the turbulent flow regime

loglog(Re,f)

ylim([0.006 0.1])                                                           % setting a limitation for the y axis, it's our choise what we want to see

xlabel('Re_D')                                                              % labelling the axes
ylabel('friction factor f')

title('Moody chart')                                                        % Giving the chart a title

grid on                                                                     % adding a grid to ease the read-off of values

%% Create legend

leg(1)={'laminar'};                                                         % The first element in the legend should be the laminar line, so we make a string vector
                                                                            % with 'laminar' as the first entry
                                                                            
leg(2:length(e_D)+1)=cellstr(strcat('\epsilon /D=',num2str(e_D')));         % the rest of the elements should be the ones corresponding to the different epsilon/D-
                                                                            % ratios, this statement adds these string elements to the leg-vector

legend(leg,'Location','SouthWest');                                         % Finally, the 'legend'-command creates the legend with the elements in the 'leg'-vector,
                                                                            % and places the legend in the SouthWest corner of the figure frame. 






