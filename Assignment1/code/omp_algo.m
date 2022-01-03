function [final_theta] = omp_algo(A, b, epsilon)
    r=b;
    [~,n] = size(A);
    fprintf("size of A is %d %d",size(A))
    theta = zeros(n,1);
    support=[];
    
    while abs(norm(r).^2) > epsilon
%        disp(abs(norm(r).^2));
       [~,new_support]=max(abs(r'*normc(A))); 
       support = [support new_support];
       present_support = A(:,support);
       theta(support) = pinv(present_support)*b;
       r = b - present_support*theta(support);
    end
    final_theta = theta;
end