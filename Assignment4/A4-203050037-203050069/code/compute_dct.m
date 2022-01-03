function dct_mtx = compute_dct(n)
    dct_mtx = zeros(n, n);
    std_basis = eye(n);
    new_shape = sqrt(n);
    for x = 1:n
        dct_i = reshape(dct2(reshape(std_basis(x,:),new_shape,new_shape)),1,[]);
        dct_mtx(x,:) = dct_i;
    end
end