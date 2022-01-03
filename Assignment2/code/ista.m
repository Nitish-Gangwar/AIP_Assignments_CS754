% % https://eeweb.engineering.nyu.edu/iselesni/lecture_notes/sparse_signal_restoration.pdf
function [theta_k1] = ista(y,A,lambda,alpha,epsilon)
%   y is flattened image
%   A is phi*psi
%   lambda is regularization parameter
%   alpha is max eigenvalue
    [~, width] = size(A);
    theta_k = zeros(width,1);
    theta_k1 = ones(width,1);
    T = lambda/(2*alpha);
    while norm(theta_k1 - theta_k) > epsilon
        Hx = A*theta_k1;
%         J(k) = sum(abs(Hx(:)-y(:)).^2) + lambda*sum(abs(theta(:)));
        theta_k = theta_k1;
        theta_k1 = soft(theta_k + (A'*(y - Hx))/alpha, T);
    end
end