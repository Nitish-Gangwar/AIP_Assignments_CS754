% % https://eeweb.engineering.nyu.edu/iselesni/lecture_notes/sparse_signal_restoration.pdf
function [theta_k1, theta_k2] = ista(y,f1_basis,f2_basis,lambda,alpha1,alpha2,epsilon)
%   y is flattened image
%   A is phi*psi
%   lambda is regularization parameter
%   alpha is max eigenvalue
    [~, width] = size(f1_basis);
    theta_k = zeros(width,1);
    theta_k1 = ones(width,1);
    theta_k2 = ones(width,1);
    T1 = lambda/(2*alpha1);
    T2 = lambda/(2*alpha2);
    while norm(theta_k1 - theta_k) > epsilon
        
        % For vector A2
        Hx = f2_basis*theta_k2;
        theta_k = theta_k2;
        theta_k2 = soft(theta_k + (f2_basis'*(y - Hx))/alpha2, T2);
        
        % For vector A1
        Hx = f1_basis*theta_k1;
        theta_k = theta_k1;
        theta_k1 = soft(theta_k + (f1_basis'*(y - Hx))/alpha1, T1);
    end
end