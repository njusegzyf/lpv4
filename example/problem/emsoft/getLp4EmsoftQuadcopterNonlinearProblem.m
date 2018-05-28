function [vars, f, eps, g_theta, g_psy, g_zeta] = getLp4EmsoftQuadcopterNonlinearProblem()

% from https://github.com/dreal/benchmarks/blob/master/inv/quadcopter.inv

% independent variables
syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12;
vars = [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12];

% Constructing the vector field dx/dt = f
f = [x4;
    x5;
    x6;
    6.500000000000001e-9*x5*(0 + 1.3333333333333333e6* (-10.000000000000036*x3 - 10.012991560967121*x6)) - 0.7333333333333336*x5*x6 + 0.0009598666666666668* (0 + 138908.18169190164*(-54.40119545932723*x1 + 14.522729589881415*x11 - 10.040717998823085*x4 + 10.000000000178622*x8));
    -6.500000000000001e-9*x4*(0 + 1.3333333333333333e6* (-10.000000000000036*x3 - 10.012991560967121*x6)) + 0.7333333333333336*x4*x6 + 0.0009598666666666668* (0 + 138908.18169190164*(-14.522729589784493*x10 - 54.401195459125795*x2 - 10.040717998822942*x5 - 9.999999999987438*x7));
    0.00005769230769230769*(0 + 1.3333333333333333e6* (-10.000000000000036*x3 - 10.012991560967121*x6));
    x10;
    x11;
    x12;
    0.00004815384615384615*(0 + 31948.881789137376*(10.630145812734655*x12 + 9.999999999999577*x9))*(cos(x1)*cos(x3)*sin(x2) + sin(x1)*sin(x3));
    0.00004815384615384615*(0 + 31948.881789137376*(10.630145812734655*x12 + 9.999999999999577*x9))*(-(cos(x3)*sin(x1)) + cos(x1)*sin(x2)*sin(x3));
    9.81 - 0.00004815384615384615*(0 + 31948.881789137376* (10.630145812734655*x12 + 9.999999999999577*x9))*cos(x1)*cos(x2)];

eps = [0.001, 0.001];

% Constructing the theta constraint
g_theta = (vars+0.001)/0.002;

% Constructing the psy constraint
g_psy = (vars-1)/2;

% Constructing the zeta constraint
g_zeta = (vars-0.9)*10;

end
