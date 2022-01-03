classdef c_adjoint_model
    properties
        length
        theta
        R
    end
    
    methods
        function obj = c_adjoint_model(length, theta, R)
            obj.R = R;
            obj.length = length;
            obj.theta = theta;
        end
        
        function adjoint_sol = mtimes(At, z)
            [p_length, p_width] = size(At.R);
            total = p_length*p_width;
            y1 = reshape(z(1:total), p_length, p_width);
            y2 = reshape(z(total+1:end), p_length, p_width);
            recon1 = dct2(iradon(y1, At.theta(1,:), 'linear',...
                'Ram-Lak', 1.0, At.length));
            recon2 = dct2(iradon(y2, At.theta(2,:), 'linear',...
                'Ram-Lak', 1.0, At.length));
            
            % Taking transposee of the forward matrix
            adjoint_sol = cat(1,reshape(recon1, [], 1)+ ...
                reshape(recon2, [], 1), reshape(recon2, [], 1));
        end
    end
end