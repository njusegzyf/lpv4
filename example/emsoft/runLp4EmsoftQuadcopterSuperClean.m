function [lpVer, solveResVer, resNorms] = runLp4EmsoftQuadcopterSuperClean()

clear;
echo on;

% disable warning of `Support of character vectors will be removed in a future release.`
% which is produced by function `monomials`.
warning('off')

% get the problem
[vars, f, eps, theta, psy, zeta] = getLp4EmsoftQuadcopterSuperCleanProblem();

x1 = vars(1);
x2 = vars(2);
x3 = vars(3);
x4 = vars(4);
x5 = vars(5);
x6 = vars(6);
x7 = vars(7);
x8 = vars(8);
x9 = vars(9);
x10 = vars(10);
x11 = vars(11);
x12 = vars(12);

degree = 2;
pLambdaDegree = 1;

maxIterations = lp4.Lp4Config.DEFAULT_MAX_ITERATION_COUNT;

% initPhy = x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9 + x10 + x11 + x12;

initPhy = (6125460164004971*x1^2)/1125899906842624 - (4512769157139313*x1*x8)/2251799813685248 - (13100782248304567*x1*x11)/4503599627370496 + (6125460164005083*x2^2)/1125899906842624 + (564096144642305*x2*x7)/281474976710656 + (13100782248303719*x2*x10)/4503599627370496 + (1126631741165689*x3^2)/1125899906842624 + (3269385089018433*x7^2)/2251799813685248 + (623753909514429*x7*x10)/562949953421312 + (6538770178036453*x8^2)/4503599627370496 + (2495015638057487*x8*x11)/2251799813685248 + (4649701592162465*x9^2)/4503599627370496 + (9367487224931077*x9*x12)/144115188075855872 + (6324983308235203*x10^2)/9007199254740992 + (6324983308235001*x11^2)/9007199254740992 + (1173122889175201*x12^2)/36028797018963968 - 1;
 


% run and verify
[lpVer, solveResVer, resNorms] = lp4.runAndVerifyLp4WithIterations1(...
    vars, f, eps, theta, psy, zeta, degree, pLambdaDegree,...
    maxIterations, initPhy);

warning('on')

echo off;
end
