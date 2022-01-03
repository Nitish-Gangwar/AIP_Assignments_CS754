function [reconstruction] = patch_generation(image, image_code, epsilon)
        [height, width] = size(image);
        [~, ~, time] = size(image_code);
        
        % Building the 2D-DCT Matrix
        dct_1d = dctmtx(8);
        dct_2d = kron(dct_1d',dct_1d');
        % final_dct is used for generating  
        final_dct = kron(eye(time),dct_2d); 
        
        
        reconstruction = zeros(size(image_code));
        total_count = zeros(size(image));
        fprintf('inside the patch generation\n')
        for i = 1:(height-7)
            for j = 1:(width-7)
                b = reshape(image(i:i+7, j:j+7,:), 1, [])';
                code = image_code(i:i+7, j:j+7,:);
                    A = [];
                    for k = 1:time
                        temp_A = diag(reshape(code(:,:,k), 1, []))*(dct_2d)
                        A = cat(2,A,temp_A);
                    end
                size(A)
                theta = omp_algo(A, b, epsilon);
                recovered_patch = (final_dct)*theta;    
                reconstruction(i:i+7, j:j+7, :) = reconstruction(i:i+7, j:j+7, :) + reshape(recovered_patch,[8,8,time]);
                total_count(i:i+7,j:j+7) = total_count(i:i+7,j:j+7) + ones(8,8);
            end
        end
        reconstruction = reconstruction./total_count;
end