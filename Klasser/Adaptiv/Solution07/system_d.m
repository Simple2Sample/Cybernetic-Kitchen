function Y = system_d(x)

%% Parameters
m       = 20        ;
beta    = 0.1       ;
k       = 5         ;

%% Signals
u       = x(1)      ;
y       = x(2)      ;
y_d     = x(3)      ;
 
%% System states Update
Y       = 1/m * (u - k*y - beta*y_d)    ;
