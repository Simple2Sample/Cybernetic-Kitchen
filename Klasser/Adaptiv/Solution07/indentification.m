function theta_dot = indentification(x)

%% Parameters
gamma = 50*diag([4,0.5,1]) ;

%% signals
Phi     =   x(2:4)  ;
z       =   x(1)    ;
Theta   =   x(5:7)  ;

%% Update law
e   = z - Theta'*Phi    ;
theta_dot = gamma*e*Phi ;
