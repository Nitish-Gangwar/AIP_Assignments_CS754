function [patch] = fh_idwt2(vector)
    cA = reshape(vector(1:16), [4,4]);
    cH = reshape(vector(17:32), [4,4]);
    cV = reshape(vector(33:48), [4,4]);
    cD = reshape(vector(49:64), [4,4]);
    patch = idwt2(cA,cH,cV,cD, 'db1');
end