
% https://in.mathworks.com/matlabcentral/answers/702502-how-do-i-concatenate-multiple-arrays
classdef d_forward_model
    properties
        length
        theta
    end
    
    methods
        function obj = d_forward_model(length, theta)
            obj.length = length;
            obj.theta = theta;
        end
        
        function forward_sol = mtimes(A, z)
            total = A.length*A.length;
            dct_coff_1 = reshape(z(1:total), A.length, A.length); 
            dct_coff_2 = reshape(z(total+1:2*total), A.length, A.length);
            dct_coff_3 = reshape(z(2*total+1:end), A.length, A.length);
            temp_1 = reshape(radon(idct2(dct_coff_1), A.theta(1,:)),[],1); 
            temp_2 = reshape(radon(idct2(dct_coff_1), A.theta(2,:)),[],1);
            temp_3 = reshape(radon(idct2(dct_coff_1), A.theta(3,:)),[],1);
            temp_4 = reshape(radon(idct2(dct_coff_2), A.theta(2,:)),[],1);
            temp_5 = reshape(radon(idct2(dct_coff_3), A.theta(3,:)),[],1);
            forward_sol = [temp_1; ...
                (temp_2 + temp_4); (temp_3 + temp_5)];

        end
    end
end