
tic;
% Reading the image
image1=imread('./slice_52.png');
image2=imread('./slice_53.png');
image_mod_1 = im2double(pad_image(image1));
image_mod_2 = im2double(pad_image(image2));
[length, width] = size(image_mod_1);
theta_1 = randi([0 179],1,18);
theta_2 = randi([0 179],1,18);
theta_fin = cat(1,theta_1, theta_2);
R_1 = radon(image_mod_1, theta_1);
R_2 = radon(image_mod_2, theta_2);
[p_length, p_width] = size(R_1);


m = 2*(p_length*p_width);
n = 2*(length*width);
y = cat(1,reshape(R_1,[],1),reshape(R_2,[],1));
lambda = 0.1;
rel_tol = 0.001;

[x,status]=l1_ls(c_forward_model(length, theta_fin) ...
    , c_adjoint_model(length, theta_fin, R_1),m,n,y,lambda,...
    rel_tol, true);


temp_img = reshape(x, length, length, 2);
temp_img_1 = temp_img(:,:,1);
temp_img_2 = temp_img(:,:,2);
temp_img_2 = temp_img_1 + temp_img_2;


imshow(idct2(temp_img_1));
figure;
imshow(idct2(temp_img_2));

toc;