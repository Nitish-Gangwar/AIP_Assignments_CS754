function [theta_k1] = ista_mod(y,phi,lambda,alpha,epsilon)
%   y is flattened image
%   A is phi*psi
%   lambda is regularization parameter
%   alpha is max eigenvalue
%   Nit total number of iterations
    [~, width] = size(phi);
    theta_k = zeros(width,1);
    theta_k1 = ones(width,1);
    T = lambda/(2*alpha);
    harr = @fh_dwt2;
    while norm(theta_k1 - theta_k) > epsilon
%     for i=1:10
        Hx = phi*harr(theta_k1);
%         J(k) = sum(abs(Hx(:)-y(:)).^2) + lambda*sum(abs(theta(:)));
        theta_k = theta_k1;
        theta_k1 = soft(theta_k + (phi'*(y - Hx))/alpha, T);
    end
end