function dwt_mtx = compute_dwt(n)
    dwt_mtx = zeros(n, n);
    std_basis = eye(n);
    for x = 1:n
        [cA,cH,cV,cD] = dwt2(reshape(std_basis(x,:), [8,8]),'db1');
        dwt_i = [reshape(cA,[],1); reshape(cH,[],1); reshape(cV,[],1); reshape(cD,[],1)]';
        dwt_mtx(x,:) = dwt_i;
    end
end