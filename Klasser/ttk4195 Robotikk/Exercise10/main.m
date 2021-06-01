clear all;
close all;

l1 = 0.3;
l2 = 0.542;

tau = -40;
tau_sat = 180;
q1_init = 5*pi/6;
q2_init = pi + asin(l1/(2*l2));
t_max = 1;

print -deps -r300 -sballistic_flight_phase myfig.eps
sim ballistic_flight_phase
print -deps -r300 -sballistic_flight_phase fess2.eps

figure(1);
plot(data.Data(:,1),data.Data(:,2));
grid on
 
%{ 
BallPitchingPhasey
function qdd = fcn(tau, q, qd)
    persistent first l1 l2 m1 m2 l1c l2c I1 I2 k2 mB g
    
    if isempty(first),
        l1 = 0.3;
        l2 = 0.542;
        m1 = 2.934;
        m2 = 1.1022;
        l1c = 0.2071;
        l2c = 0.2717;
        I1 = 0.2067;
        I2 = 0.1362;
        k2 = 14.1543;
        mB = 0.064;
        g = 9.81;
        first = 1;
    end
    q1 = q(1);
    q2 = q(2);
    qd1 = qd(1);
    qd2 = qd(2);
    
    m11 = m1*l1c^2+(m2+mB)*l1^2+I1; 
    m12 = (m2+mB)*l1*l2*cos(q1-q2);
    m21 = (m2+mB)*l1*l2*cos(q1-q2);
    m22 = I2 + (m2+mB)*l2^2;
    c11 = 0;
    c12 = (m2+mB)*l1*l2*sin(q1-q2)*qd2;
    c21 = -(m2+mB)*l1*l2*sin(q1-q2)*qd1;
    c22 = 0;
    g11 = m1*g*l1c*cos(q1)+(m2+mB)*g*l1*cos(q1);
    g22 = m2*g*l2c*cos(q2)+mB*g*l2*cos(q2);
    k11 = -k2*(q2-q1);  
    k22 = k2*(q2-q1);
    
    M = [m11 m12; m21 m22];
    C = [c11 c12; c21 c22];
    G = [g11; g22];
    K = [k11; k22];
    u = [tau; 0];

qdd = M\(u-C*qd-G-K);

function pos = fcn(q, qd, t)
    persistent first transition l1 l2 p0 v0 g
    
    if isempty(first),
        l1 = 0.3;
        l2 = 0.542;
        g = 9.81;
        first = 1;
        transition = 0;
        p0 = [0;0];
        v0 = [0;0];
    end
    
    q1 = q(1);
    q2 = q(2);
    qd1 = qd(1);
    qd2 = qd(2);
    
    pp = [l1*cos(q1)+l2*cos(q2); l1*sin(q1)+l2*sin(q2)];
    vp = [-l1*qd1*sin(q1)-l2*qd2*sin(q2); l1*qd1*cos(q1)+l2*qd2*cos(q2)];
    
    if pp(1) >= -0.1  && transition == 0,
       p0 = pp;
       v0 = vp;
       disp(p0)
       disp(v0)
       transition = 1;
    end
    
    if transition == 1
        x = v0(1)*t + p0(1);
        y = v0(2)*t + p0(2)-g/2*t^2;
        if y <= 0
            pos = [x;0];
        else
            pos = [x;y];
        end
    else
        pos = pp;
    end
end
%}
