% Q2 Part (b)

lambda=1.0;
epsilon = 0.00001;

tic;

image=imread('./barbara256.png');
imshow(image);
impixelinfo;
caption=sprintf('Original Image');
title(caption);

[height,width]=size(image);

% 2D-DCT basis
psi=kron(dctmtx(8)',dctmtx(8)');
% psi = compute_dct(64);
phi=randn(32,64);
H=double(phi*psi);% 32*64 64*64

alpha=eigs(H'*H,1)+10;

reconstructed_image=zeros(size(image));
count_matrix=zeros(size(image));

% https://in.mathworks.com/help/matlab/math/random-numbers-with-specific-mean-and-variance.html
noisy_image=double(image) + double(2.0*randn(size(image)));

% https://in.mathworks.com/matlabcentral/answers/177886-how-to-convert-a-range-of-pixel-values-to-another-range-0-255
noisy_image=uint8(255 * mat2gray(noisy_image));
% y = mat2gray(y);

figure;
imshow(noisy_image);
impixelinfo;
caption=sprintf('Noisy Image');
title(caption);


bar = waitbar(0, "Progress");
for i=1:(height-7)
    for j=1:(width-7)
        small_y = phi*im2double(reshape(noisy_image(i:i+7,j:j+7),[],1));
        [theta] = ista(small_y,H,lambda,alpha,epsilon);
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