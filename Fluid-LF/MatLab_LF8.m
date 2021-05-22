%% Assignment 8 - matlab - TEP 4100

%% Problem:
%   Addition to exercise 5-91 [ Fluid Mechanics - Cengel and Cimbala sec. edit]:
%
%       Consider problem 5-91, but now the nozzle of the fireboat can be
%       rotated to point upwards. Neglect friction beween the discharge jet
%       and the air and calculate the trajectories the jet will have for
%       angles with increment 5 degrees from 0 to 75 degrees. You should
%       use the built-in function 'fzero' to automate your calculations.
%       Approximately how far is the maximum distance the jet can reach?
%
%       Plot the trajectories and hand in with the rest of the assignment.
%
%       Hints:
%       Copy and paste the four sentences below into an empty m-file
%       which you save as 'zposition.m' in the folder you are working in.
% 
%         function z=zposition(time)
%         global g s0 v0z                                                   % writing this ensures that the functions knows
%                                                                           % to look in the workspace for the variables, this must
%                                                                           % also be written in the main script
% 
%         z=-0.5*g*time^2+v0z*time+s0;                                      % two time integration of the gravity to find the z-position 
%                                                                           % of the jet as a function of the 'time'
%         end
%
%       This creates a function which you call using the 'fzero' function
%       by writing [t(n),fval]=fzero(@zposition,tinterval) in the main
%       script. fzero uses values between the values specified in
%       'tinterval' and searches for the values which cause the function in
%       zposition to be zero, read about it in 'help'. In other words, this statment finds how long
%       time it takes before the z position of the jet is zero, i.e. at the
%       jet hits the surface. Set tinterval= [0 1000].
%       Create an outer for-loop for all the angles of the nozzle and an
%       inner for-loop which computes the z and x positions for the current
%       jet angle for as long time as the jet is above sea level. Something like:
%           
%           for n=1:length(theta)
% 
%             v0z=vertical component of nozzle velocity as a function of nozzle angle;
%     
%             v0x=horisontal component of nozzle velocity as a function of nozzle angle;
%     
%             [t(n),fval]=fzero(@zposition,tinterval)
%     
%             time=0;
%     
%               for k=0:100
%
%                   deltatime=t(n)/100;                                     % this ensures that all the vectors 
%                                                                           % containing the computed positions 
%                                                                           % have the same number of elements.
%         
%                   z(k+1,n)=zposition(time);                               % we have already made a function which
%                                                                           % computes the vertical position, so we
%                                                                           % just call it.
%         
%                   x(k+1,n)=v0x*time;                                      % horisontal distance is horisontal
%                                                                           % velocity multiplied with the time
%         
%                   time=time+deltatime;                                    % increasing the time with one time increment 
%               
%               end
%           end
%       
%
%
%
%%

clear all
close all
clc

global g v0z s0                                                             % declaring the parameters that our functions need to find in the workspace

g           = 9.81;                                                         % defining the global value for the parameters

s0          = 3;

v0          = 0.1/(pi()*0.05^2/4);

theta       = [0:5:75];                                                     % creating the span of angles to investigate

tinterval   = [0 1000];                                                     % defining the interval for which 'fzero' should search for a zero value

for n=1:length(theta)                                                       % the outer for-loop for the computations at different angles

    v0z         = v0*sind(theta(n));                                        % finding the vertical component of the nozzle velocity
    
    v0x         = v0*cosd(theta(n));                                        % finding the horizontal component of the nozzle velocity
    
    [t(n),fval] = fzero(@zposition,tinterval);                              % here, the call to find the times for which the jet hits the surface
                                                                            % (z position is zero) is executed.    

    time            = 0;                                                    % the following for-loop needs to have a starting value for the variable 'time' 
        
    deltatime   = t(n)/100;                                                 % this ensures that all the vectors containing the computed positions 
                                                                            % have the same number of elements.  
    for k=0:100
        
        z(k+1,n)    = zposition(time);                                      % we have already made a function which computes the vertical position, so we
                                                                            % just call it.
        
        x(k+1,n)    = v0x*time;                                             % horisontal distance is horisontal velocity multiplied with the time
                                                                            
        time        = time+deltatime;                                       % increasing the time with one time increment
    end
    
end

figure1         = figure('Name','Trajectories of friction free fireboat jets',...        % creating an empty figure with a name instead of the default 'Figure X'
        'NumberTitle','off');
    
plot(x,z)                                                                   % plotting the vertical and horisontal positions that corresponds tho each jet angle

grid on

xlabel('Distance from nozzle [m]')                                          % labelling the axes

ylabel('Height above sea level [m]')

legend([kron(ones(size(theta')),'\theta = '),num2str(theta')])              % creating the legend using the TeX syntax that shows the symbol for theta


