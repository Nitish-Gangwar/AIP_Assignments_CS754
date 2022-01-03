
tic;
% Reading the image
image=imread('./slice_50.png');
image_mod = im2double(pad_image(image));
[length, width] = size(image_mod);
theta = randi([0 179],1,18);
R = radon(image_mod, theta);
[p_length, p_width] = size(R);


m = (p_length*p_width);
n = (length*width);
y = reshape(R,[],1);
lambda = 0.1;
rel_tol = 0.001;

[x,status]=l1_ls(b_forward_model(length, theta), b_adjoint_model(length, theta, R),m,n,y,lambda,rel_tol, true);

recon_image = idct2(reshape(x, length, length));
imshow((recon_image));

toc;