%% MAP solution for x
function [x] = MAP_soln(y,phi,stdev,covar)
    x = inv((phi'*phi)/power(stdev,2) + inv(covar)) ...
    *(phi'*y)/power(stdev,2);
end