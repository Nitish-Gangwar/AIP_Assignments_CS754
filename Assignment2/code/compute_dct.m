function dct_mtx = compute_dct(n)
    dct_mtx = zeros(n, n);
    std_basis = eye(n);
    for x = 1:n
        dct_i = reshape(dct2(reshape(std_basis(x,:), [8,8])),1,[]);
        dct_mtx(x,:) = dct_i;
    end
end