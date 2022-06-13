%% System Dynamics
function xdot = DoublePendulum(t,x,p)
    % Parameters
    m1 = p(1); m2 = p(2);
    l1 = p(3); l2 = p(4);
    g = p(5);
    
    % Helper variables
    dang = x(1)-x(3);
    mlml = m1*l1+m2*l1;
    f1 = 1/(m1*l1+m2*l1-m2*l1*(cos(dang).^2));
    f2 = 1/(l2+(l1*l2*m2*(cos(dang).^2)/(m1*l1+m2*l1)));
    % Dynamics
    xdot = zeros(4,1);
    xdot(1,1) = x(2);
    xdot(2,1) = f1*(-m2*l1*(x(2)^2)*cos(dang)*sin(dang)+m2*g*cos(dang)*sin(x(3))-m2*l2*(x(4)^2)*sin(dang)-m1*g*sin(x(1))-m2*g*sin(x(1)));
    xdot(3,1) = x(4);
    xdot(4,1) = f2*((m2*l1*l2*(x(4)^2)*cos(dang)*sin(dang)/(mlml))+(m1*l1*g*cos(dang)*sin(x(1))/(mlml))+(m2*l1*g*cos(dang)*sin(x(1))/(mlml))+l1*(x(2)^2)*sin(dang)-g*sin(x(3)));
end

