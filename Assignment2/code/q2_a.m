lambda=0.1;
epsilon = 0.0001;

tic;

image=imread('./barbara256.png');
imshow(image);
caption = sprintf('Original image');
title(caption);

% https://in.mathworks.com/help/matlab/math/random-numbers-with-specific-mean-and-variance.html
noisy_image=double(image) + double(2.0*randn(size(image)));

% https://in.mathworks.com/matlabcentral/answers/177886-how-to-convert-a-range-of-pixel-values-to-another-range-0-255
noisy_image=uint8(255 * mat2gray(noisy_image));

figure,imshow(noisy_image);
caption = sprintf('Noisy image');
title(caption);

psi=kron(dctmtx(8)',dctmtx(8)');
alpha=eigs(psi'*psi,1)+10;
reconstructed_image=zeros(size(image));
count_matrix=zeros(size(image));

%figure,imshow(y)
bar = waitbar(0, "Progress");
for i=1:(height-7)
    for j=1:(width-7)
        small_y = im2double(reshape(noisy_image(i:i+7,j:j+7),[],1));
        [theta] = ista(small_y,psi,lambda,alpha,epsilon);
%         recovered_x = idct2(reshape(theta,[8,8]));
        recovered_x = psi*theta;
        reconstructed_image(i:i+7,j:j+7) = reconstructed_image(i:i+7,j:j+7)...
                                        + reshape(recovered_x,[8,8]);
        count_matrix(i:i+7,j:j+7) = count_matrix(i:i+7,j:j+7)+ones(8,8);
    end
    waitbar(i/(height-7));
end
close(bar);


reconstructed_image = reconstructed_image./count_matrix;
rmse = norm(im2double(image) - reconstructed_image)/norm(im2double(image));
figure;
imshow(reconstructed_image)
impixelinfo;
caption=sprintf('Reconstructed Image with RMSE: %d', rmse);
title(caption);

toc;