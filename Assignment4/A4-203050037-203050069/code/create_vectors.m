function [f1, f2] = create_vectors(sparsity,f1_mag,f2_mag)
    f1_cofft_values = randi([1 f1_mag],1,sparsity);
    f1_indices = randi([1 256],1,sparsity);
    f1_cofft = zeros(1,256);
    f1_cofft(f1_indices) = f1_cofft_values;
    f1_basis = dctmtx(256)/256;
%     f1_basis = compute_dct(256);
    f1 = f1_basis*f1_cofft';

    f2_cofft_values = randi([1 f2_mag],1,sparsity);
    f2_indices = randi([1 256],1,sparsity);
    f2_cofft = zeros(1,256);
    f2_cofft(f2_indices) = f2_cofft_values;
    f2_basis = eye(256);
    f2 = f2_basis*f2_cofft';
end