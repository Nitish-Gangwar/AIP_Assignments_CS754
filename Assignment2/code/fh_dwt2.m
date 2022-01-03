function [coffts] = fh_dwt2(vector)
    patch = reshape(vector, [8,8]);
    [cA,cH,cV,cD] = dwt2(patch, 'db1');
    coffts = [reshape(cA,[],1); reshape(cH,[],1); reshape(cV,[],1); reshape(cD,[],1)];
end