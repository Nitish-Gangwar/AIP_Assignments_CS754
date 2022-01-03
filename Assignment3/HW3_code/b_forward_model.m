% https://in.mathworks.com/help/matlab/ref/mtimes.html
% https://in.mathworks.com/help/matlab/matlab_oop/overloading-functions-for-your-class.html
% https://in.mathworks.com/help/matlab/matlab_oop/a-polynomial-class-1.html#f3-30100
% https://in.mathworks.com/help/matlab/matlab_oop/implementing-operators-for-your-class.html

classdef b_forward_model
    properties
        length
        theta
    end
    
    methods
        function obj = b_forward_model(length, theta)
            obj.length = length;
            obj.theta = theta;
        end
        
        function forward_sol = mtimes(A, z)
            dct_coff = reshape(z, A.length, A.length); 
            temp = radon(idct2(dct_coff), A.theta); 
            forward_sol = reshape(temp, [], 1);
        end
    end
end