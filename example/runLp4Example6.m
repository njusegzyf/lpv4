function [lp, solveRes] = runLp4Example6()

clear; 
echo on;

% disable warning of `Support of character vectors will be removed in a future release.` 
% which is produced by function `monomials`.
warning('off')

[vars, f, eps, g_theta, g_psy, g_zeta] = getLp4Example6Problem();



import lp4.LinearProgram4_v2
lp = LinearProgram4_v2(vars);

lp.f = f;
lp.eps = eps;

% Set the degree of phy
degree = 4;
pLambdaDegree = 0;
lp = lp.setDegreeAndInit(degree, pLambdaDegree);

lp = lp.setThetaConstraint(g_theta);
lp = lp.setPsyConstraint(g_psy);
lp = lp.setZetaConstraint(g_zeta);
lp = lp.generateEqsForConstraint1To3();

import lp4util.Partition
lp.pPartitions = repmat(Partition(-1, 1), 1000, 1);
lp.pLambdaPartitions = repmat(Partition(-1, 1), 1000, 1);
lp = lp.setWConstraint();

lp = lp.setDevVarsConstraint();

lp = lp.setLinprogF();

% see http://blog.sina.com.cn/s/blog_68b0c65f0100mq5m.html
% options = optimset(��MaxIter��, 2000);

% solve the lp problem
[lp, solveRes] = lp.solve();
% [lp, solveRes] = lp.solve(options);
% [lp, solveRes] = lp.solve1And3();

warning('on')

echo off;
end
