% https://stackoverflow.com/questions/6709871/matlab-how-to-implement-a-ram-lak-filter-ramp-filter-in-the-frequency-domain
% https://in.mathworks.com/help/images/ref/iradon.html#d123e197345

classdef b_adjoint_model
    properties
        length
        theta
        R
    end
    
    methods
        function obj = b_adjoint_model(length, theta, R)
            obj.length = length;
            obj.theta = theta;
            obj.R = R;
        end
        
        function adjoint_sol = mtimes(At, z)
            [p_length, p_width] = size(At.R);
            y = reshape(z, p_length, p_width);
            recon = dct2(iradon(y, At.theta, 'linear', 'Ram-Lak', 1.0, At.length));
            adjoint_sol = reshape(recon, [], 1);
        end
    end
end