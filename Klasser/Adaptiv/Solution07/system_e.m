function Yn = system_e(x)

%% Signals
u       = x(1)      ;
y       = x(2)      ;
y_d     = x(3)      ;
t       = x(4)      ;
 
%% Parameters

if t<20
    m = 20          ;
else
    m = 20*(2-exp(-0.01*(t-20)))    ;
end
beta    = 0.1       ;
k       = 5         ;


%% System states Update
Y       = 1/m * (u - k*y - beta*y_d)    ;
Yn      = [Y;m];
