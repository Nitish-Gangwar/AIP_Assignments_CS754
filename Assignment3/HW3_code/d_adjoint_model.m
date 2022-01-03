classdef d_adjoint_model
    properties
        length
        theta
        R
    end
    
    methods
        function obj = d_adjoint_model(length, theta, R)
            obj.R = R;
            obj.length = length;
            obj.theta = theta;
        end
        
        function adjoint_sol = mtimes(At, z)
            [p_length, p_width] = size(At.R);
            total = p_length*p_width;
            y1 = reshape(z(1:total), p_length, p_width);
            y2 = reshape(z(total+1:2*total), p_length, p_width);
            y3 = reshape(z(2*total+1:end), p_length, p_width);
            recon1 = reshape(dct2(iradon(y1, At.theta(1,:), 'linear',...
                'Ram-Lak', 1.0, At.length)),[],1);
            recon2 = reshape(dct2(iradon(y2, At.theta(2,:), 'linear',...
                'Ram-Lak', 1.0, At.length)),[],1);
            recon3 = reshape(dct2(iradon(y3, At.theta(3,:), 'linear',...
                'Ram-Lak', 1.0, At.length)),[],1);
            
            % Taking transposee of the forward matrix
            % https://in.mathworks.com/matlabcentral/answers/702502-how-do-i-concatenate-multiple-arrays
            adjoint_sol = [recon1+recon2+recon3;recon2;recon3];
        end
    end
end