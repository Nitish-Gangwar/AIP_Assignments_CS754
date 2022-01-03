classdef c_forward_model
    properties
        length
        theta
    end
    
    methods
        function obj = c_forward_model(length, theta)
            obj.length = length;
            obj.theta = theta;
        end
        
        function forward_sol = mtimes(A, z)
            total = A.length*A.length;
            dct_coff_1 = reshape(z(1:total), A.length, A.length); 
            dct_coff_2 = reshape(z(total+1:end), A.length, A.length);
            temp_1 = reshape(radon(idct2(dct_coff_1), A.theta(1,:)), [], 1); 
            temp_2 = reshape(radon(idct2(dct_coff_1), A.theta(2,:)), [], 1);
            temp_3 = reshape(radon(idct2(dct_coff_2), A.theta(2,:)), [], 1);
            forward_sol = cat(1,temp_1,(temp_2+temp_3));


        end
    end
end