function [lpVer, solveResVer, resNorms] = runLp4EmsoftQuadcopterNonlinear()

clear;
echo on;

% disable warning of `Support of character vectors will be removed in a future release.`
% which is produced by function `monomials`.
warning('off')

% get the problem
[vars, f, eps, theta, psy, zeta] = getLp4EmsoftQuadcopterNonlinearProblem();

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

initPhy = x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9 + x10 + x11 + x12;



% run and verify
[lpVer, solveResVer, resNorms] = lp4.runAndVerifyLp4WithIterations1(...
    vars, f, eps, theta, psy, zeta, degree, pLambdaDegree,...
    maxIterations, initPhy);

warning('on')

echo off;
end
