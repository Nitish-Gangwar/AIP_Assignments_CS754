% http://users.cs.cf.ac.uk/Dave.Marshall/Multimedia/PDF/CM3106lab7wk8.pdf

tic;
% setting parameters
lambda=0.6;
epsilon = 1e-15;
sparsity = 5;
sparsity_var = [5 10 15 20 25 30 35 40 45 50];
sigma = 0.01;
sigma_var = [0.01 0.05 0.1 0.2 0.5 0.6 0.7 0.8];
f1_magnitude = 100;
f2_magnitude = 100;
k_var = [1 2 3 4 5 6 7 8 9 10];

[f1,f2] = create_vectors(sparsity,f1_magnitude,f2_magnitude);

f_add = f1 + f2;
average = mean(f_add, 'all');
f = f_add + sigma*average;
% plot(f);

f1_basis = compute_dct(256);
f2_basis = eye(256);
alpha1 = eigs(f1_basis'*f1_basis,1)+10;
alpha2 = eigs(f2_basis'*f2_basis,1)+10;

[f1_rec, f2_rec] = ista(f,f1_basis,f2_basis,lambda,...
    alpha1,alpha2,epsilon);

%% Plotting the graphs
t = tiledlayout(2,2);
t.Padding = 'compact';
t.TileSpacing = 'compact';
nexttile
plot(f1)
title("f1");
nexttile
plot(f2)
title("f2");
nexttile
plot(f1_rec/256)
title("f1 recovered");
nexttile
plot(f2_rec)
title("f2 recoverd");
f1_err = relative_error(f1, f1_rec/256);
f2_err = relative_error(f2, f2_rec);

fprintf('F1 error: %f --- F2 error: %f\n',f1_err, f2_err);

%% Varying sigma
f1_sigma_var = zeros(1,length(sigma_var));
f2_sigma_var = zeros(1,length(sigma_var));

for i=1:length(sigma_var)
    f = f_add + sigma_var(i)*average;
    [f1_reco, f2_reco] = ista(f,f1_basis,f2_basis,lambda,...
    alpha1,alpha2,epsilon);
    f1_sigma_var(i) = sqrt(immse(f1, f1_reco/256));
    f2_sigma_var(i) = sqrt(immse(f2, f2_reco));
    % Uncomment to run for "Relative Error"
%     f1_sigma_var(i) = relative_error(f1, f1_reco/256);
%     f2_sigma_var(i) = relative_error(f2, f2_reco);
end

figure;
t = tiledlayout(2,1);
t.Padding = 'compact';
t.TileSpacing = 'compact';
nexttile
plot(sigma_var,f1_sigma_var)
title("f1 with varying sigma");
nexttile
plot(sigma_var,f2_sigma_var)
title("f2 with varying sigma");

%% Varying sparsity
f1_sparsity_var = zeros(1,length(sparsity_var));
f2_sparsity_var = zeros(1,length(sparsity_var));

for i=1:length(sparsity_var)
    [f1,f2] = create_vectors(sparsity_var(i),f1_magnitude,...
    f2_magnitude);
    f_add = f1 + f2;
    average = mean(f_add, 'all');
    f = f_add + sigma*average;
    [f1_reco, f2_reco] = ista(f,f1_basis,f2_basis,lambda,...
    alpha1,alpha2,epsilon);
    f1_sparsity_var(i) = sqrt(immse(f1, f1_reco/256));
    f2_sparsity_var(i) = sqrt(immse(f2, f2_reco));
     % Uncomment to run for "Relative Error"
%     f1_sparsity_var(i) = relative_error(f1, f1_reco/256);
%     f2_sparsity_var(i) = relative_error(f2, f2_reco);
end

figure;
t = tiledlayout(2,1);
t.Padding = 'compact';
t.TileSpacing = 'compact';
nexttile
plot(sparsity_var,f1_sparsity_var)
title("f1 with varying sparsity");
nexttile
plot(sparsity_var,f2_sparsity_var)
title("f2 with varying sparsity");

%% Varying 'k'
f1_k_var = zeros(1,length(k_var));
f2_k_var = zeros(1,length(k_var));

for i=1:length(k_var)
    [f1,f2] = create_vectors(sparsity,f1_magnitude,...
    k_var(i)*f1_magnitude);
    f_add = f1 + f2;
    average = mean(f_add, 'all');
    f = f_add + sigma*average;
    [f1_reco, f2_reco] = ista(f,f1_basis,f2_basis,lambda,...
    alpha1,alpha2,epsilon);
    f1_k_var(i) = sqrt(immse(f1, f1_reco/256));
    f2_k_var(i) = sqrt(immse(f2, f2_reco));
end

figure;
t = tiledlayout(2,1);
t.Padding = 'compact';
t.TileSpacing = 'compact';
nexttile
plot(k_var,f1_k_var)
title("f1 with varying k");
nexttile
plot(k_var,f2_k_var)
title("f2 with varying k");


toc;