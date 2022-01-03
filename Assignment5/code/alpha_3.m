m = [40, 50, 64, 80, 100, 120];
n = 128;
alpha = 3;

% https://in.mathworks.com/help/matlab/ref/orth.html
% Generating Random Orthonormal Matrix
[U,~,~] = svd(rand(n));
indices = linspace(1,n,n);
eigval = indices.^(-alpha);

% Co-variance
lambda = diag(eigval);
covar = U*lambda*U';

% Generating 10 random signals with 0 mean and given covariance matrix
x = mvnrnd(zeros(1,n),covar,10);


%% For alpha = 3

error = zeros(1,length(m));
for k = 1:length(m)
    % https://stackoverflow.com/questions/18297078/independent-identically-distributioniid-gaussian-normal-matrix
    phi = (1/m(k))*randn(m(k),n);
    y = zeros(m(k),10);
    stdev = zeros(1,10);

    % https://in.mathworks.com/help/deeplearning/ref/meanabs.html
    for i = 1:10
        y(:,i) = phi*x(i,:)';
        stdev(i) = (0.01*meanabs(y(:,i)));
        noise = randn(m(k),1).*stdev(:,i);
        y(:,i) = y(:,i) + noise;
        predX = MAP_soln(y(:,i),phi,stdev(i),covar); 
        error(k) = error(k) + sqrt(immse(predX, x(i,:)'));
    end

    % https://in.mathworks.com/matlabcentral/answers/4064-rmse-root-mean-square-error
end

figure;
h = plot(m,error);
title('Plot for alpha=3');
xlabel('m') 
ylabel('RMSE') 
set(h, 'Color', 'r')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


