function [vars, f, eps, g_theta, g_psy, g_zeta] = getLp4EmsoftQuadcopterProblem()

% from https://github.com/dreal/benchmarks/blob/master/inv/quadcopter.inv
% barrier:
% x3*( 1.0006499994525422*x3 + 0.0006499999999998994*x6 ) + x4*(0.0020360452039992023*x1 - 0.000544321621037731*x11 + 0.00037500010850529997*x4 - 0.0003749999999934132*x8 ) + x5*(0.0005443216210414734*x10 + 0.0020360452040066417*x2 + 0.0003750001085053988*x5 + 0.00037500000000099617*x7 ) + x6*(0.0006499999999999839*x3 + 0.0006500005478254101*x6 ) + x10*(0.7022142099172516*x10 + 1.4544790092667315*x2 + 0.0005443216210415*x5 + 0.5540047616343005*x7 ) + x7*(0.5540047616343005*x10 + 1.0020360446146714*x2 + 0.0003750000000010419*x5 + 1.4518986408777725*x7 ) + x1*(5.440501528402005*x1 - 1.4544790092668254*x11 + 0.0020360452039995197*x4 - 1.0020360446148653*x8 ) + x2*(1.4544790092667312*x10 + 5.4405015284021045*x2 + 0.00203604520400671*x5 + 1.0020360446146714*x7 ) + x11*(-1.4544790092668256*x1 + 0.7022142099172292*x11 - 0.0005443216210377589*x4 + 0.5540047616342495*x8 ) + x8*(-1.0020360446148653*x1 + 0.5540047616342497*x11 - 0.0003749999999934508*x4 + 1.4518986408776808*x8 ) + x12*(0.03256070105692735*x12 + 0.03250000000000153*x9) + x9*(0.03250000000000156*x12 + 1.0324411530510036*x9) - 1;
% simplified barrier:
% (6125460164004971*x1^2)/1125899906842624 + (1173700150021249*x1*x4)/288230376151711744 - (4512769157139313*x1*x8)/2251799813685248 - (13100782248304567*x1*x11)/4503599627370496 + (6125460164005083*x2^2)/1125899906842624 + (4694800600101863*x2*x5)/1152921504606846976 + (564096144642305*x2*x7)/281474976710656 + (13100782248303719*x2*x10)/4503599627370496 + (1126631741165689*x3^2)/1125899906842624 + (2997595911977533*x3*x6)/2305843009213693952 + (6917531029210581*x4^2)/18446744073709551616 - (13835058055039847*x4*x8)/18446744073709551616 - (5020480818534999*x4*x11)/4611686018427387904 + (1729382757303101*x5^2)/4611686018427387904 + (864691128457485*x5*x7)/1152921504606846976 + (10040961637139021*x5*x10)/9223372036854775808 + (5995196876753173*x6^2)/9223372036854775808 + (3269385089018433*x7^2)/2251799813685248 + (623753909514429*x7*x10)/562949953421312 + (6538770178036453*x8^2)/4503599627370496 + (2495015638057487*x8*x11)/2251799813685248 + (4649701592162465*x9^2)/4503599627370496 + (9367487224931077*x9*x12)/144115188075855872 + (6324983308235203*x10^2)/9007199254740992 + (6324983308235001*x11^2)/9007199254740992 + (1173122889175201*x12^2)/36028797018963968 - 1;
 
% init
% 0<=x1,x2,x3<=1,    98<=x4,x5,x6<=100,  298<=x7<=300,   -300<=x8<=-298,  998<=x9<=1000,  198<=x10<=200,  -200<x11<-198,  198<=x12<=200

% unsafe
% -0.18<=xi,i=1..12<=0.18

% independent variables
syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12;
vars = [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12];

% Constructing the vector field dx/dt = f
f = [x4;
    x5;
    x6;
    -7253.4927279102985*x1 + 1936.3639453175222*x11 - 1338.7623998430781*x4 + 1333.3333333571497*x8;
    -1936.3639453045992*x10 - 7253.49272788344*x2 - 1338.762399843059*x5 - 1333.3333333316584*x7;
    -769.2307692307719*x3 - 770.2301200743939*x6;
    x10;
    x11;
    x12;
    9.809999999999999*x2;
    -9.809999999999999*x1;
    -16.354070481130236*x12 - 15.384615384614733*x9];

eps = [0.001, 0.001];



r = 0.1;

% Constructing the theta constraint
theta1 = x1;
theta2 = x2;
theta3 = x3;
theta4 = (x4-98)/2;
theta5 = (x5-98)/2;
theta6 = (x6-98)/2;
theta7 = (x7-298)/2;
theta8 = (x8+300)/2;
theta9 = (x9-998)/2;
theta10 = (x10-198)/2;
theta11 = (x11+200)/2;
theta12 = (x12-198)/2;
g_theta = [theta1, theta2, theta3, theta4, theta5, theta6, theta7, theta8, theta9, theta10, theta11, theta12];

% Constructing the psy constraint
psy1 = (x1+1)/2;
psy2 = (x2+1)/2;
psy3 = (x3+1)/2;
psy4 = (x4+100)/200;
psy5 = (x5+100)/200;
psy6 = (x6+100)/200;
psy7 = (x7+300)/600;
psy8 = (x8+300)/600;
psy9 = (x9+1000)/2000;
psy10 = (x10+200)/400;
psy11 = (x11+200)/400;
psy12 = (x12+200)/2200;
g_psy = [psy1, psy2, psy3, psy4, psy5, psy6, psy7, psy8, psy9, psy10, psy11, psy12];

% Constructing the zeta constraint
g_zeta = (vars+r)/(2*r);

end
