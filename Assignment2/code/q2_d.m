lambda=0.4;
epsilon = 0.0001;

% Kernel to convolve with the signal
h = [1 2 3 4 3 2 1]/16;

x = zeros(100,1);
random_numbers = randi([2 7], 1, 10);
random_indices = randperm(100, 10);
x(random_indices,:) = random_numbers;

% https://eeweb.engineering.nyu.edu/iselesni/lecture_notes/sparse_signal_restoration.pdf
H = convmtx(h',100);
y = H*x;
eta = 0.05*max(x,[],'all')*randn(size(H,1),1);

y = y + eta;
alpha=eigs(H'*H,1)+10;

[theta] = ista(y,H,lambda,alpha,epsilon);