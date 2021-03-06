function [lp, solveRes, lpVer, solveResVer, resNorms] = runLp4Example4WithDegreeAndRangeCandidates()

clear; 
echo on;

% disable warning of `Support of character vectors will be removed in a future release.` 
% which is produced by function `monomials`.
warning('off')

% get the problem
[vars, f, eps, g_theta, g_psy, g_zeta] = getLp4Example4Problem();



% set the degree of phy and lambda
degrees = [1, 2, 3, 4];
pLambdaDegrees = [1, 2, 3];

% set the ranges
ranges = [1, 0.5, 0.3, 0.15, 0.1];
import lp4util.createRangeCandidates
[phyRanges, pLambdaRanges, phyRangesInVerify] = createRangeCandidates(ranges, ranges, 0);

% Note: For degree = [1 .. 4], pLambdaDegree = [1 .. 3], range = [1..0.1], unable to verify feasible solutions with lambda.



% run and verify
import lp4.runAndVerifyWithDegreeAndRangeCandidates
[lp, solveRes, lpVer, solveResVer, resNorms, isVerified] = runAndVerifyWithDegreeAndRangeCandidates(...
    vars, f, eps, g_theta, g_psy, g_zeta,...
    degrees, pLambdaDegrees,...
    phyRanges, pLambdaRanges, phyRangesInVerify);

warning('on')

echo off;
end
